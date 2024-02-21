import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/transaction_button.dart';
import 'package:uuid/uuid.dart';

part 'monopoly_electronico_event.dart';
part 'monopoly_electronico_state.dart';

class MonopolyElectronicoBloc
    extends Bloc<MonopolyElectronicoEvent, MonopolyElectronicoState> {
  MonopolyElectronicoBloc() : super(const MonopolyElectronicoState()) {
    on<HandleCardsEvent>(_handleCardsEvent);
    on<StartGameEvent>(_startGameEvent);
    on<UpdatePlayerEvent>(_changeUserEvent);
    on<PassExitEvent>(_passExitEvent);
    on<FinishTurnPlayerEvent>(_finishTurnPlayer);
    on<AddPlayerMoneyEvent>(_addMoneyEvent);
    on<SubstractMoneyEvent>(_substractMoneyEvent);
  }
  _handleCardsEvent(
      HandleCardsEvent event, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final hasSavedGames = await getIt<MonopolyGamesStorage>().hasCurrentGames;
    // TODO: RESTORE IF SAVEDGAMES IN ELETRONIC and user wants to (show alert)
    final cards =
        await getIt<MonopolyElectronicService>().getAllMonopolyCards();
    emit(state.copyWith(
      cards: cards,
      status: GameStatus.playing,
    ));
  }

  _startGameEvent(
      StartGameEvent event, Emitter<MonopolyElectronicoState> emit) async {
    try {
      emit(state.copyWith(status: GameStatus.loading));
      final sesionId = const Uuid().v1();
      final players =
          event.players.map((e) => e.copyWith(gameSesion: sesionId)).toList();
      List<MonopolyPlayerX> sesion = [];
      for (var player in players) {
        final id = await getIt<MonopolyElectronicService>().addPlayerX(player);
        final tempPlayer = player.copyWith(id: id);
        sesion.add(tempPlayer);
      }
      await Future.delayed(const Duration(milliseconds: 900));
      await getIt<MonopolyGamesStorage>().startGameX();
      emit(state.copyWith(players: event.players, status: GameStatus.playing));
    } catch (e) {
      BankerAlerts.unhandleErros(error: e.toString());
    }
  }

  _changeUserEvent(
      UpdatePlayerEvent event, Emitter<MonopolyElectronicoState> emit) async {
    final resp = await BankerAlerts.readNfcDataCard();
    try {
      if (resp == null) {
        BankerAlerts.unhandleErros(error: 'Can handle card');
        return;
      }
      final player = state.playerFromCard(resp);
      if (player == null) {
        BankerAlerts.unhandleErros(error: 'No player found in this sesion');
        emit(state.copyWith(
            status: GameStatus.playing,
            errorMessage: 'No card found in this sesion: ${resp.number}'));
        return;
      }
      emit(state.copyWith(
        player: player,
        status: GameStatus.transaction,
        gameTransaction: PlayerTransaction.none,
      ));
    } catch (e) {
      BankerAlerts.unhandleErros(error: e.toString());
    }
  }

  _finishTurnPlayer(_, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(
      player: null,
      status: GameStatus.playing,
      gameTransaction: PlayerTransaction.none,
    ));
  }

  _addMoneyEvent(
      AddPlayerMoneyEvent event, Emitter<MonopolyElectronicoState> emit) {
    if (state.currentPlayer == null || state.status == GameStatus.playing) {
      return;
    }
    final parseMoney =
        event.type == MoneyValue.millon ? event.money : event.money / 1000;
    final money = parseMoney.toStringAsFixed(2);
    if (money.length > 6) {
      BankerAlerts.invalidAmount(amount: event.money, isBigger: true);
      return;
    }
    if (money.length < 2) {
      BankerAlerts.invalidAmount(amount: event.money, isBigger: false);
      return;
    }
    final toAddMoney = double.parse(money);
    final uplayed =
        state.currentPlayer!.copyWith(money: toAddMoney + state.moneyPlayer!);
    final players = _updatePlayers(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: PlayerTransaction.add,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
      players: players,
    ));
  }

  _substractMoneyEvent(
      SubstractMoneyEvent event, Emitter<MonopolyElectronicoState> emit) {
    if (state.currentPlayer == null || state.status == GameStatus.playing) {
      return;
    }
    final parseMoney =
        event.type == MoneyValue.millon ? event.money : event.money / 1000;
    if (state.currentPlayer!.money < parseMoney) {
      BankerAlerts.noMoneyToSubstract(amount: parseMoney);
      return;
    }
    final money = parseMoney.toStringAsFixed(2);
    if (money.length > 6) {
      BankerAlerts.invalidAmount(amount: event.money, isBigger: true);
      return;
    }
    if (money.length < 2) {
      BankerAlerts.invalidAmount(amount: event.money, isBigger: false);
      return;
    }
    final substract = double.parse(money);
    final uplayed = state.currentPlayer!
        .copyWith(money: (state.moneyPlayer! - substract).abs());
    final players = _updatePlayers(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: PlayerTransaction.substract,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
      players: players,
    ));
  }

  _passExitEvent(_, Emitter<MonopolyElectronicoState> emit) async {
    try {
      if (state.currentPlayer == null) {
        final resp = await BankerAlerts.readNfcDataCard();
        if (resp == null) return;

        final player = state.playerFromCard(resp);
        if (player == null) {
          BankerAlerts.unhandleErros(
            error: 'No player found in this session',
          );
          emit(state.copyWith(
            status: GameStatus.playing,
            errorMessage: 'No card found in this session: ${resp.number}',
          ));
          return;
        }
        emit(_updateWhenExit(player));
        return;
      } else {
        emit(_updateWhenExit(state.currentPlayer!));
        return;
      }
    } catch (e) {
      BankerAlerts.unhandleErros(error: e.toString());
      emit(state.copyWith(
          status: GameStatus.playing, errorMessage: 'Error al tomar user'));
    }
  }

  List<MonopolyPlayerX> _updatePlayers(
      MonopolyPlayerX old, MonopolyPlayerX uplayer) {
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = uplayer;
    return temp;
  }

  MonopolyElectronicoState _updateWhenExit(MonopolyPlayerX old) {
    final playerPassExit = old.copyWith(money: old.money + 2);
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = playerPassExit;
    return state.copyWith(
      players: temp,
      player: playerPassExit,
      status: GameStatus.transaction,
      gameTransaction: PlayerTransaction.salida,
    );
  }
}
