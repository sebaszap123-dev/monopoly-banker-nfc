// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/model/money.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/service_locator.dart';

part 'banker_electronic_event_v2.dart';
part 'banker_electronic_state_v2.dart';

class ElectronicGameV2Bloc extends Bloc<ElectronicEvent, ElectronicState> {
  ElectronicGameV2Bloc() : super(const ElectronicState()) {
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

  _backGameEvent(BackupGameEvent event, Emitter<ElectronicState> emit) async {
    if (event.appPaused) {
      if (state.status == GameStatus.backup) return;
      // await getIt<BankerManagerService>().backupPlayers(state.players);
      BankerAlerts.unhandledError(error: "No implementado aun");
      // return;
    }
    if (state.gameSessionId == null) {
      throw Exception(
          'No session id, why you can play if no session is created?');
    }
    BankerAlerts.unhandledError(error: "No implementado aun");

    // emit(state.copyWith(status: GameStatus.loading));
    // await getIt<BankerManagerService>().backupPlayers(state.players);
    // await getIt<BankerManagerService>().updateSession(state.gameSessionId!);
    // emit(state.copyWith(status: GameStatus.backup));
    // try {
    //   getIt<RouterCubit>().state.replace(const HomeRoute());
    // } catch (e) {
    //   rethrow;
    // }
  }

  _restoreGameEvent(
      RestoreGameEvent event, Emitter<ElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    BankerAlerts.unhandledError(error: "No implementado aun");

    // final session =
    //     await getIt<BankerManagerService>().getGameSession(event.sessionId);
    // if (session.players.isEmpty) {
    //   BankerAlerts.unhandledError(error: 'No players of the last session');
    //   emit(state.copyWith(
    //     players: [],
    //     status: GameStatus.endgame,
    //     gameTransaction: GameTransaction.none,
    //   ));
    //   return;
    // }
    // emit(state.copyWith(
    //   gameSessionId: event.sessionId,
    //   players: session.players,
    //   status: GameStatus.playing,
    //   gameTransaction: GameTransaction.none,
    // ));
  }

  _startGameEvent(StartGameEvent event, Emitter<ElectronicState> emit) async {
    try {
      emit(state.copyWith(status: GameStatus.loading));

      final session =
          await getIt<ElectronicDatabaseV2>().createSession(event.players);
      await Future.delayed(const Duration(milliseconds: 900));
      if (session.players.isEmpty) {
        throw 'Error players not found after make session';
      }
      emit(state.copyWith(
        gameSessionId: session.id,
        players: session.players.toList(),
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
      // TODO: CHANGE WITH ANOTHER VIEW
      getIt<RouterCubit>().state.push(const ElectronicGameRoute());
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
    }
  }

  _changeUserEvent(
      UpdatePlayerEvent event, Emitter<ElectronicState> emit) async {
    BankerAlerts.unhandledError(error: "No implementado aun");

    // final resp = await BankerAlerts.readNfcDataCard();
    // try {
    //   if (resp == null) {
    //     return;
    //   }
    //   final player = state.playerFromCard(resp);
    //   if (player == null) {
    //     BankerAlerts.unhandledError(error: 'No player found in this sesion');
    //     emit(state.copyWith(
    //       status: GameStatus.playing,
    //       gameTransaction: GameTransaction.none,
    //     ));
    //     return;
    //   }
    //   emit(state.copyWith(
    //     player: player,
    //     status: GameStatus.transaction,
    //     gameTransaction: GameTransaction.none,
    //   ));
    // } catch (e) {
    //   BankerAlerts.unhandledError(error: e.toString());
    // }
  }

  _finishTurnPlayer(_, Emitter<ElectronicState> emit) async {
    emit(state.copyWith(
      player: null,
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  _addMoneyEvent(AddPlayerMoneyEvent event, Emitter<ElectronicState> emit) {
    if (state.currentPlayer == null || state.status == GameStatus.playing) {
      return;
    }
    final uPlayer = state.currentPlayer!
      ..money = state.moneyPlayer! + event.money;
    _updatePlayer(state.currentPlayer!, uPlayer);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.add,
      moneyExchange: event.money,
      player: uPlayer,
    ));
  }

  _subtractMoneyEvent(SubtractMoneyEvent event, Emitter<ElectronicState> emit) {
    if (state.currentPlayer == null || state.status == GameStatus.playing) {
      return;
    }

    if (state.currentPlayer!.money < event.money) {
      BankerAlerts.noMoneyToSubtract(amount: event.money.value!);
      return;
    }
    if (event.money > Money(type: MoneyType.million, value: 500)) {
      BankerAlerts.invalidAmount(amount: event.money.value!, isBigger: true);
      return;
    }
    if (event.money < Money(type: MoneyType.thousands, value: 1)) {
      BankerAlerts.invalidAmount(amount: event.money.value!, isBigger: false);
      return;
    }
    final subtract = event.money;
    final uPlayer = state.currentPlayer!..money = state.moneyPlayer! - subtract;
    _updatePlayer(state.currentPlayer!, uPlayer);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.substract,
      moneyExchange: event.money,
      player: uPlayer,
    ));
  }

  _passExitEvent(_, Emitter<ElectronicState> emit) async {
    try {
      if (state.currentPlayer == null) {
        final resp = await BankerAlerts.readNfcDataCardV2();
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

  _payPlayersEvent(PayPlayersEvent event, Emitter<ElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final resp = await BankerAlerts.chooseTransactionV2();
    if (resp == null) return;
    switch (resp) {
      case PayToAction.playerToPlayer:
        await _p1ToP2(event);
        break;
      case PayToAction.playerToPlayers:
        await _p1ToPlayers(event, resp);
        break;
      case PayToAction.playersToPlayer:
        await _playersToP1(event, resp);
        break;
    }

    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.none,
    ));
  }

  _p1ToPlayers(PayPlayersEvent event, PayToAction payTo) async {
    final card1 = await BankerAlerts.readNfcDataCard(
        customText: 'Este jugador paga a los demas');

    if (card1 == null) {
      await BankerAlerts.noCardReader(count: 1);
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }

    final payMoney = event.money;
    final reduceMoney = payMoney * (state.players.length - 1);

    final playerIndex = state.players
        .indexWhere((element) => element.card!.number == card1.number);

    if (playerIndex != -1) {
      MonopolyPlayer player = state.players[playerIndex];

      if (player.money < reduceMoney) {
        final insufficientMoney = reduceMoney - player.money;
        BankerAlerts.insufficientFundsPlayersV2(
          players: {player.namePlayer: insufficientMoney},
        );
        emit(state.copyWith(
          gameTransaction: GameTransaction.paying,
          status: GameStatus.transaction,
        ));
        return;
      }

      final updatedPlayers = state.players
          .map(
            (e) => e
              ..money = e.card!.number == card1.number
                  ? e.money - reduceMoney
                  : e.money + payMoney,
          )
          .toList();
      BankerAlerts.payedToGroupsV2(
        money: event.money,
        player: player.namePlayer,
        payTo: payTo,
      );
      emit(state.copyWith(
        players: updatedPlayers,
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    }
  }

  _playersToP1(PayPlayersEvent event, PayToAction payTo) async {
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

    final receiverIndex = state.players
        .indexWhere((element) => element.card!.number == card.number);

    if (receiverIndex != -1) {
      final receiver = state.players[receiverIndex];

      final payMoney = event.money;
      final totalAmount = payMoney * (state.players.length - 1);

      // Actualizar el saldo del jugador receptor y los demás jugadores
      Map<String, Money> cantPay = {};
      for (var player in state.players) {
        if (player.money < payMoney &&
            player.card!.number != receiver.card!.number) {
          cantPay[player.namePlayer] = payMoney - player.money;
        }
      }
      if (cantPay.isNotEmpty) {
        await BankerAlerts.insufficientFundsPlayersXV2(players: cantPay);
        emit(state.copyWith(
          status: GameStatus.playing,
          gameTransaction: GameTransaction.paying,
        ));
        return;
      }

      final updatedPlayers = state.players
          .map((player) => player
            ..money = player.card!.number == receiver.card!.number
                ? player.money + totalAmount
                : player.money - payMoney)
          .toList();
      BankerAlerts.payedToGroupsV2(
        money: event.money,
        player: receiver.namePlayer,
        payTo: payTo,
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

    final playerPays = state.players
        .firstWhere((element) => element.card!.number == card1.number);
    final playerReceive = state.players
        .firstWhere((element) => element.card!.number == card2.number);
    final payMoney = event.money;

    if (playerPays.money < payMoney) {
      final insufficientMoney = event.money - playerPays.money;
      BankerAlerts.insufficientFundsPlayersXV2(
          players: {playerPays.namePlayer: insufficientMoney});
      emit(state.copyWith(
        gameTransaction: GameTransaction.paying,
        status: GameStatus.transaction,
      ));
      return;
    }

    playerReceive.money += payMoney;
    playerPays.money = playerPays.money - payMoney;

    _updatePlayer(playerPays, playerPays);
    _updatePlayer(playerReceive, playerReceive);
    BankerAlerts.payedJ1toJ2V2(
      money: event.money,
      playerPays: playerPays.namePlayer,
      playerReceive: playerReceive.namePlayer,
    );
    emit(state.copyWith(
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
  }

  void _updatePlayer(MonopolyPlayer old, MonopolyPlayer uplayer) {
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = uplayer;
    emit(state.copyWith(players: temp));
  }

  ElectronicState _updateWhenExit(MonopolyPlayer old) {
    final playerPassExit = old
      ..money = old.money + Money(type: MoneyType.million, value: 2);
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

  _endGameEvent(EndGameEvent state, Emitter<ElectronicState> emit) {
    emit(ElectronicState());
  }
}
