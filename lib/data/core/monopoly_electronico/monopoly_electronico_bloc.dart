import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:uuid/uuid.dart';

part 'monopoly_electronico_event.dart';
part 'monopoly_electronico_state.dart';

class MonopolyElectronicoBloc
    extends Bloc<MonopolyElectronicoEvent, MonopolyElectronicoState> {
  MonopolyElectronicoBloc() : super(const MonopolyElectronicoState()) {
    on<HandleCardsEvent>(_handleCardsEvent);
    on<StartGameEvent>(_startGameEvent);
    on<ChangeCurrentUser>(_changeUserEvent);
    on<PassExitEvent>(_passExitEvent);
    on<FinishTurnPlayer>(_finishTurnPlayer);
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
      status: GameStatus.success,
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
      ChangeCurrentUser event, Emitter<MonopolyElectronicoState> emit) async {
    try {
      final resp = await BankerAlerts.readNfcDataCard();
      if (resp == null) {
        BankerAlerts.unhandleErros(error: 'Can handle card');
        return;
      }
      final player = state.playerFromCard(resp);
      if (player == null) {
        BankerAlerts.unhandleErros(error: 'No player found in this sesion');
        emit(state.copyWith(
            status: GameStatus.success,
            errorMessage: 'No card found in this sesion: ${resp.number}'));
        return;
      }
      emit(state.copyWith(player: player, status: GameStatus.transaction));
    } catch (e) {
      BankerAlerts.unhandleErros(error: e.toString());
    }
  }

  _finishTurnPlayer(_, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(
      player: null,
      status: GameStatus.playing,
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
            status: GameStatus.success,
            errorMessage: 'No card found in this session: ${resp.number}',
          ));
          return;
        }
        emit(_updatePlayers(player));
      } else {
        emit(_updatePlayers(state.currentPlayer!));
      }
      emit(state.copyWith(status: GameStatus.transaction));
    } catch (e) {
      BankerAlerts.unhandleErros(error: e.toString());
    }
  }

  MonopolyElectronicoState _updatePlayers(MonopolyPlayerX old) {
    final playerPassExit = old.copyWith(money: old.money + 2);
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = playerPassExit;
    return state.copyWith(
      players: temp,
      player: playerPassExit,
    );
  }
}
