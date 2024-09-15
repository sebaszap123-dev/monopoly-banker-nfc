// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/monopoly_player.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';

part 'banker_electronic_event.dart';
part 'banker_electronic_state.dart';

class MonopolyElectronicBloc
    extends Bloc<MonopolyElectronicEvent, MonopolyElectronicState> {
  MonopolyElectronicBloc() : super(const MonopolyElectronicState()) {
    on<HandleCardsEvent>(_handleCardsEvent);
    on<StartGameEvent>(_startGameEvent);
    on<RestoreGameEvent>(_restoreGameEvent);
    on<BackupGameEvent>(_backGameEvent);
    on<EndGameEvent>(_endGameEvent);
    on<UpdatePlayerEvent>(_changeUserEvent);
    on<PassExitEvent>(_passExitEvent);
    on<FinishTurnPlayerEvent>(_finishTurnPlayer);
    on<AddPlayerMoneyEvent>(_addMoneyEvent);
    on<SubtractMoneyEvent>(_subtractMoneyEvent);
    on<PayPlayersEvent>(_payPlayersEvent);
  }
  _handleCardsEvent(
      HandleCardsEvent event, Emitter<MonopolyElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final cards = await getIt<BankerManagerService>()
        .getAllMonopolyCards(GameVersions.electronic);
    emit(state.copyWith(
      cards: cards,
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  _backGameEvent(
      BackupGameEvent event, Emitter<MonopolyElectronicState> emit) async {
    if (event.appPaused) {
      if (state.status == GameStatus.backup) return;
      await getIt<BankerManagerService>().backupPlayers(state.players);
      return;
    }
    if (state.gameSessionId == null) {
      throw Exception(
          'No session id, why you can play if no session is created?');
    }

    emit(state.copyWith(status: GameStatus.loading));
    await getIt<BankerManagerService>().backupPlayers(state.players);
    await getIt<BankerManagerService>().updateSession(state.gameSessionId!);
    emit(state.copyWith(status: GameStatus.backup));
    try {
      getIt<RouterCubit>().state.replace(const HomeRoute());
    } catch (e) {
      rethrow;
    }
  }

  _restoreGameEvent(
      RestoreGameEvent event, Emitter<MonopolyElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final session =
        await getIt<BankerManagerService>().getGameSession(event.sessionId);
    if (session.players.isEmpty) {
      BankerAlerts.unhandledError(error: 'No players of the last session');
      emit(state.copyWith(
        players: [],
        status: GameStatus.endgame,
        gameTransaction: GameTransaction.none,
      ));
      return;
    }
    emit(state.copyWith(
      gameSessionId: event.sessionId,
      players: session.players,
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  _startGameEvent(
      StartGameEvent event, Emitter<MonopolyElectronicState> emit) async {
    try {
      emit(state.copyWith(status: GameStatus.loading));

      final session = await getIt<BankerManagerService>()
          .createGameSessions(event.version, event.players);
      await Future.delayed(const Duration(milliseconds: 900));
      if (session.players.isEmpty) {
        throw 'Error players not found after make session';
      }
      emit(state.copyWith(
        gameSessionId: session.id,
        players: session.players,
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
    }
  }

  _changeUserEvent(
      UpdatePlayerEvent event, Emitter<MonopolyElectronicState> emit) async {
    final resp = await BankerAlerts.readNfcDataCard();
    try {
      if (resp == null) {
        return;
      }
      final player = state.playerFromCard(resp);
      if (player == null) {
        BankerAlerts.unhandledError(error: 'No player found in this sesion');
        emit(state.copyWith(
          status: GameStatus.playing,
          gameTransaction: GameTransaction.none,
        ));
        return;
      }
      emit(state.copyWith(
        player: player,
        status: GameStatus.transaction,
        gameTransaction: GameTransaction.none,
      ));
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
    }
  }

  _finishTurnPlayer(_, Emitter<MonopolyElectronicState> emit) async {
    emit(state.copyWith(
      player: null,
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  _addMoneyEvent(
      AddPlayerMoneyEvent event, Emitter<MonopolyElectronicState> emit) {
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
    _updatePlayer(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.add,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
    ));
  }

  _subtractMoneyEvent(
      SubtractMoneyEvent event, Emitter<MonopolyElectronicState> emit) {
    if (state.currentPlayer == null || state.status == GameStatus.playing) {
      return;
    }
    final parseMoney =
        event.type == MoneyValue.millon ? event.money : event.money / 1000;
    if (state.currentPlayer!.money < parseMoney) {
      BankerAlerts.noMoneyToSubtract(amount: parseMoney);
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
    _updatePlayer(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.substract,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
    ));
  }

  _passExitEvent(_, Emitter<MonopolyElectronicState> emit) async {
    try {
      if (state.currentPlayer == null) {
        final resp = await BankerAlerts.readNfcDataCard();
        if (resp == null) return;

        final player = state.playerFromCard(resp);
        if (player == null) {
          BankerAlerts.unhandledError(
            error: 'No player found in this session',
          );
          emit(state.copyWith(
            status: GameStatus.playing,
            gameTransaction: GameTransaction.none,
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
      BankerAlerts.unhandledError(error: e.toString());
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    }
  }

  _payPlayersEvent(
      PayPlayersEvent event, Emitter<MonopolyElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final resp = await BankerAlerts.chooseTransactionV1();
    if (resp != null) {
      switch (resp) {
        case PayTo.playerToPlayer:
          await _p1ToP2(event);
          break;
        case PayTo.playerToPlayers:
          await _p1ToPlayers(event, resp);
          break;
        case PayTo.playersToPlayer:
          await _playersToP1(event, resp);
          break;
      }
      return;
    }

    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.none,
    ));
  }

  _p1ToPlayers(PayPlayersEvent event, PayTo payTo) async {
    final card1 = await BankerAlerts.readNfcDataCard(
        customText: 'Este jugador paga a los demas');

    if (card1 == null) {
      await BankerAlerts.noCardReader(count: 1);
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }

    final payMoney = _convertKtoM(event.type, event.moneyToPay);
    final reduceMoney = payMoney * (state.players.length - 1);

    final playerIndex =
        state.players.indexWhere((element) => element.number == card1.number);

    if (playerIndex != -1) {
      MonopolyPlayerX player = state.players[playerIndex];

      if (player.money < reduceMoney) {
        final insufficientMoney = (player.money - reduceMoney).abs();
        BankerAlerts.insufficientFundsPlayersX(
          players: {player.namePlayer!: insufficientMoney},
        );
        emit(state.copyWith(
          gameTransaction: GameTransaction.paying,
          status: GameStatus.transaction,
        ));
        return;
      }

      final updatedPlayers = state.players
          .map((e) => e.copyWith(
                money: e.number == card1.number
                    ? e.money - reduceMoney
                    : e.money + payMoney,
              ))
          .toList();
      BankerAlerts.payedToGroups(
        dinero: event.moneyToPay,
        value: event.type,
        jugador: player.namePlayer!,
        payto: payTo,
      );
      emit(state.copyWith(
        players: updatedPlayers,
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    }
  }

  _playersToP1(PayPlayersEvent event, PayTo payTo) async {
    final card = await BankerAlerts.readNfcDataCard(
        customText: 'Este jugador recibirá dinero de todos los demás');

    if (card == null) {
      await BankerAlerts.noCardReader(count: 1);
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
      return;
    }

    final receiverIndex =
        state.players.indexWhere((element) => element.number == card.number);

    if (receiverIndex != -1) {
      final receiver = state.players[receiverIndex];

      final payMoney = _convertKtoM(event.type, event.moneyToPay);
      final totalAmount = payMoney * (state.players.length - 1);

      // Actualizar el saldo del jugador receptor y los demás jugadores
      Map<String, double> cantPay = {};
      for (var player in state.players) {
        if (player.money < payMoney && player.number != receiver.number) {
          cantPay[player.namePlayer!] = (player.money - payMoney).abs();
        }
      }
      if (cantPay.isNotEmpty) {
        await BankerAlerts.insufficientFundsPlayersX(players: cantPay);
        emit(state.copyWith(
          status: GameStatus.playing,
          gameTransaction: GameTransaction.paying,
        ));
        return;
      }

      final updatedPlayers = state.players
          .map((player) => player.copyWith(
              money: player.number == receiver.number
                  ? player.money + totalAmount
                  : player.money - payMoney))
          .toList();
      BankerAlerts.payedToGroups(
        dinero: event.moneyToPay,
        value: event.type,
        jugador: receiver.namePlayer!,
        payto: payTo,
      );
      emit(state.copyWith(
        players: updatedPlayers,
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    }
  }

  _p1ToP2(PayPlayersEvent event) async {
    final card1 = await BankerAlerts.readNfcDataCard(
        customText: '¿Listo para pagar? Inserta tu tarjeta');
    await Future.delayed(const Duration(milliseconds: 900));
    final card2 = await BankerAlerts.readNfcDataCard(
      customText: 'Recibe tu dinero! Inserta tu tarjeta',
    );

    if (card1 == null || card2 == null || card1 == card2) {
      BankerAlerts.customMessageAlertFail(
          text: 'No se leyó correctamente las tarjetas');
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
      return;
    }

    final playerPays =
        state.players.firstWhere((element) => element.number == card1.number);
    final playerReceive =
        state.players.firstWhere((element) => element.number == card2.number);
    final payMoney = _convertKtoM(event.type, event.moneyToPay);

    if (playerPays.money < payMoney) {
      final insufficientMoney = (playerPays.money - payMoney).abs();
      BankerAlerts.insufficientFundsPlayersX(
          players: {playerPays.namePlayer!: insufficientMoney});
      emit(state.copyWith(
        gameTransaction: GameTransaction.paying,
        status: GameStatus.transaction,
      ));
      return;
    }

    final updateJ1 =
        playerReceive.copyWith(money: playerReceive.money + payMoney);
    final updateJ2 = playerPays.copyWith(money: playerPays.money - payMoney);

    _updatePlayer(playerPays, updateJ1);
    _updatePlayer(playerReceive, updateJ2);
    BankerAlerts.payedJ1toJ2(
      value: event.type,
      dinero: event.moneyToPay,
      playerPays: playerPays.namePlayer!,
      playerReceive: playerReceive.namePlayer!,
    );
    emit(state.copyWith(
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  double _convertKtoM(MoneyValue value, double currentMoney) {
    double money = 0;
    if (value == MoneyValue.miles) {
      final moneyString = (currentMoney / 1000).toStringAsFixed(2);
      money = double.parse(moneyString);
    } else {
      money = currentMoney;
    }
    return money;
  }

  void _updatePlayer(MonopolyPlayerX old, MonopolyPlayerX uplayer) {
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = uplayer;
    emit(state.copyWith(players: temp));
  }

  MonopolyElectronicState _updateWhenExit(MonopolyPlayerX old) {
    final playerPassExit = old.copyWith(money: old.money + 2);
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = playerPassExit;
    return state.copyWith(
      players: temp,
      player: playerPassExit,
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.salida,
    );
  }

  _endGameEvent(EndGameEvent state, Emitter<MonopolyElectronicState> emit) {
    emit(MonopolyElectronicState());
  }
}
