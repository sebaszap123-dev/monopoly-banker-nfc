// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/database/utils/electronic_properties.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/model/money.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/property.dart';
import 'package:monopoly_banker/data/model/session.dart';
import 'package:monopoly_banker/data/service_locator.dart';

part 'banker_electronic_event_v2.dart';
part 'banker_electronic_state_v2.dart';

class ElectronicGameV2Bloc extends Bloc<ElectronicEvent, ElectronicState> {
  ElectronicGameV2Bloc() : super(const ElectronicState()) {
    on<StartGameEvent>(_startGameEvent);
    on<RestoreGameEvent>(_restoreGameEvent);
    on<BackupGameEvent>(_backGameEvent);
    on<EndGameEvent>(_endGameEvent);
    // User payments
    on<UpdatePlayerEvent>(_changeUserEvent);
    on<PassExitEvent>(_passExitEvent);
    on<FinishTurnPlayerEvent>(_finishTurnPlayer);
    on<AddPlayerMoneyEvent>(_addMoneyEvent);
    on<SubtractMoneyEvent>(_subtractMoneyEvent);
    on<PayPlayersEvent>(_payPlayersEvent);
    // Properties
    on<BuyProperty>(_buyProperty);
    on<MortgageProperty>(_mortgageProperty);
    on<ChangeProperties>(_exchangeProperties);
  }

  _backGameEvent(BackupGameEvent event, Emitter<ElectronicState> emit) async {
    if (state.gameSession == null) {
      throw Exception(
          'No session id, why you can play if no session is created?');
    }
    if (event.appPaused) {
      if (state.status == GameStatus.backup) return;
      await getIt<ElectronicDatabaseV2>()
          .backupSession(state.players, state.gameSession!);
      return;
    }

    emit(state.copyWith(status: GameStatus.loading));
    await getIt<ElectronicDatabaseV2>()
        .backupSession(state.players, state.gameSession!);
    emit(state.copyWith(status: GameStatus.backup));
    if (event.exitGame) {
      emit(ElectronicState());
      getIt<RouterCubit>().state.replace(const HomeRoute());
      return;
    }
    BankerAlerts.customMessageAlertSuccess(text: "Se guardo el juego");
  }

  _restoreGameEvent(
      RestoreGameEvent event, Emitter<ElectronicState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    // throw UnimplementedError("Unable to restore ");
    final session =
        await getIt<ElectronicDatabaseV2>().restoreSession(event.sessionId);
    if (session == null) {
      BankerAlerts.customMessageAlertFail(
          text: "No se encontró la sesión por favor prueba otra vez.");
      return;
    }
    if (session.players.isEmpty) {
      BankerAlerts.unhandledError(error: 'No players of the last session');
      emit(state.copyWith(
        players: [],
        status: GameStatus.setup,
        gameTransaction: GameTransaction.none,
      ));
      return;
    }

    final properties = await PropertyManager.getPredefinedProperties();
    final players = session.players.toList();

    // Obtener las listas de propiedades de cada jugador
    final houses = players.expand((player) => player.houses.toList()).toList();
    final services =
        players.expand((player) => player.services.toList()).toList();
    final railways =
        players.expand((player) => player.railways.toList()).toList();

    // Remover casas que ya existen en los jugadores
    properties.removeWhere((property) =>
        property is House &&
        houses.any((house) => house.title == property.title));

    // Remover servicios que ya existen en los jugadores
    properties.removeWhere((property) =>
        property is CompanyService &&
        services.any((service) => service.title == property.title));

    // Remover ferrocarriles que ya existen en los jugadores
    properties.removeWhere((property) =>
        property is RailWay &&
        railways.any((railway) => railway.title == property.title));

    emit(state.copyWith(
      gameSession: session,
      players: players,
      propertiesToSell: properties,
      status: GameStatus.playing,
      gameTransaction: GameTransaction.none,
    ));
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

      final properties = await PropertyManager.getPredefinedProperties();

      emit(state.copyWith(
        gameSession: session,
        players: session.players.toList(),
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
        propertiesToSell: properties,
      ));
      getIt<RouterCubit>().state.push(const ElectronicGameRoute());
    } catch (e) {
      rethrow;
      // BankerAlerts.unhandledError(error: e.toString());
    }
  }

  _changeUserEvent(
      UpdatePlayerEvent event, Emitter<ElectronicState> emit) async {
    final resp = await BankerAlerts.readNfcDataCardV2();
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
        currentPlayer: player,
        status: GameStatus.transaction,
        gameTransaction: GameTransaction.none,
      ));
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
    }
  }

  _finishTurnPlayer(_, Emitter<ElectronicState> emit) async {
    emit(state.copyWith(
      currentPlayer: null,
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
    _updatePlayerOldNew(state.currentPlayer!, uPlayer);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.add,
      moneyExchange: event.money,
      currentPlayer: uPlayer,
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
    _updatePlayerOldNew(state.currentPlayer!, uPlayer);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.subtract,
      moneyExchange: event.money,
      currentPlayer: uPlayer,
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
    final card1 = await BankerAlerts.readNfcDataCardV2(
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
    final card = await BankerAlerts.readNfcDataCardV2(
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
        await BankerAlerts.insufficientFundsPlayersV2(players: cantPay);
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
    final card1 = await BankerAlerts.readNfcDataCardV2(
        customText: '¿Listo para pagar? Inserta tu tarjeta');
    await Future.delayed(const Duration(milliseconds: 900));
    final card2 = await BankerAlerts.readNfcDataCardV2(
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
      BankerAlerts.insufficientFundsPlayersV2(
          players: {playerPays.namePlayer: insufficientMoney});
      emit(state.copyWith(
        gameTransaction: GameTransaction.paying,
        status: GameStatus.transaction,
      ));
      return;
    }

    playerReceive.money += payMoney;
    playerPays.money = playerPays.money - payMoney;

    _updatePlayerOldNew(playerPays, playerPays);
    _updatePlayerOldNew(playerReceive, playerReceive);
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

  void _updatePlayerOldNew(MonopolyPlayer old, MonopolyPlayer upPlayer) {
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = upPlayer;
    emit(state.copyWith(players: temp));
  }

  void _updatePlayer(MonopolyPlayer player) {
    final index = state.players.indexOf(player);
    final temp = List.of(state.players);
    temp[index] = player;
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
      currentPlayer: playerPassExit,
      status: GameStatus.transaction,
      gameTransaction: GameTransaction.exit,
    );
  }

  _endGameEvent(EndGameEvent event, Emitter<ElectronicState> emit) {
    emit(ElectronicState());
  }

  _buyProperty(BuyProperty event, Emitter<ElectronicState> emit) async {
    try {
      final player = await _obtainPlayer;
      if (player == null) return;
      emit(state.copyWith(
        status: GameStatus.loading,
        gameTransaction: GameTransaction.none,
      ));
      List<Property> properties = [...state.propertiesToSell];
      properties
          .removeWhere((element) => element.title == event.property.title);
      if (player.money < event.property.buyValue) {
        BankerAlerts.customMessageAlertFail(
            text: "No tienes dinero suficiente para pagarlo");
        emit(state.copyWith(
          status: GameStatus.playing,
          gameTransaction: GameTransaction.none,
        ));
        return;
      }
      final wasAdded = await getIt<ElectronicDatabaseV2>()
          .addPropertyToPlayer(player, event.property);
      if (wasAdded) {
        player.money = player.money - event.property.buyValue;
        _updatePlayer(player);
        emit(state.copyWith(
          propertiesToSell: properties,
          status: GameStatus.transaction,
          gameTransaction: GameTransaction.buy_property,
          currentPlayer: player,
        ));
        return;
      }
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    } catch (e) {
      rethrow;
    }
  }

  _mortgageProperty(
      MortgageProperty event, Emitter<ElectronicState> emit) async {
    final player = await _obtainPlayer;
    if (player == null) return;
    // Emitir estado de carga
    emit(state.copyWith(status: GameStatus.loading));

    final isMortgage = event.property.isMortgage;
    final mortgageAmount = event.property.mortgage;
    // Levantar la hipoteca
    final demortgage = mortgageAmount * 1.1;
    final playerHasEnoughMoney = player.money > demortgage;

    if (isMortgage && playerHasEnoughMoney) {
      // Levantar la hipoteca
      await _processMortgage(
          player, event.property, demortgage, MortgageAction.up);
    } else if (!isMortgage) {
      // Hipotecar la propiedad
      await _processMortgage(
          player, event.property, mortgageAmount, MortgageAction.down);
    }
  }

  Future<MonopolyPlayer?> get _obtainPlayer async {
    MonopolyPlayer? player;
    if (state.currentPlayer == null) {
      final resp = await BankerAlerts.readNfcDataCardV2();
      if (resp == null) return null;
      player = state.playerFromCard(resp);
      return player;
    }
    return state.currentPlayer;
  }

  // Future<MonopolyPlayer?> get _readPlayer async {
  //   MonopolyPlayer? player;
  //   final resp = await BankerAlerts.readNfcDataCardV2();
  //   if (resp == null) return null;
  //   player = state.playerFromCard(resp);
  //   if (player == null) return null;
  //   return player;
  // }

  Future<void> _processMortgage(
    MonopolyPlayer player,
    Property property,
    Money mortgageAmount,
    MortgageAction action,
  ) async {
    await getIt<ElectronicDatabaseV2>()
        .mortgagePropertyToPlayer(player, property);

    // Actualizar el dinero del jugador
    switch (action) {
      case MortgageAction.up:
        player.money -= mortgageAmount;
      case MortgageAction.down:
        player.money += mortgageAmount;
    }
    _updatePlayer(player);

    // Emitir estado de transacción
    emit(state.copyWith(
      status: GameStatus.transaction,
      currentPlayer: player,
      gameTransaction: action == MortgageAction.up
          ? GameTransaction.subtract
          : GameTransaction.add,
      moneyExchange: mortgageAmount,
    ));
  }

  _exchangeProperties(
      ChangeProperties event, Emitter<ElectronicState> emit) async {
    if (event.status == TransferTransaction.selectingPlayer1) {
      emit(state.copyWith(
        status: GameStatus.transaction,
        gameTransaction: GameTransaction.transfer_properties,
      ));
    }
    if (event.status == TransferTransaction.transactionSuccess) {
      if (event.player1 == null || event.player2 == null) {
        throw Exception("Players cant be null in Transfers");
      }
      if (event.propertiesPlayer1.isEmpty && event.moneyPlayer1 == null) {
        throw Exception(
            "${event.player1!.namePlayer} need to transfer something");
      }
      if (event.propertiesPlayer2.isEmpty && event.moneyPlayer2 == null) {
        throw Exception(
            "${event.player2!.namePlayer} need to transfer something");
      }

      if (event.propertiesPlayer1.isNotEmpty) {
        try {
          await getIt<ElectronicDatabaseV2>().transferPropertiesPlayers(
              event.player2!, event.player1!, event.propertiesPlayer1);
          _updatePlayer(event.player1!);
          _updatePlayer(event.player2!);
        } catch (e) {
          rethrow;
        }
      }
      if (event.propertiesPlayer2.isNotEmpty) {
        try {
          await getIt<ElectronicDatabaseV2>().transferPropertiesPlayers(
              event.player1!, event.player2!, event.propertiesPlayer2);
          _updatePlayer(event.player1!);
          _updatePlayer(event.player2!);
        } catch (e) {
          rethrow;
        }
      }
      if (event.moneyPlayer1 != null) {
        try {
          event.player1!.money -= event.moneyPlayer1!;
          event.player2!.money += event.moneyPlayer1!;
          _updatePlayer(event.player1!);
          _updatePlayer(event.player2!);
        } catch (e) {
          rethrow;
        }
      }
      if (event.moneyPlayer2 != null) {
        try {
          event.player1!.money += event.moneyPlayer2!;
          event.player2!.money -= event.moneyPlayer2!;
          _updatePlayer(event.player1!);
          _updatePlayer(event.player2!);
        } catch (e) {
          rethrow;
        }
      }
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
      BankerAlerts.customMessageAlertSuccess(text: "Trato exitoso!");
    }
    if (event.status == TransferTransaction.transactionError ||
        event.status == TransferTransaction.transactionCancel) {
      emit(state.copyWith(
        status: GameStatus.playing,
        gameTransaction: GameTransaction.none,
      ));
    }
  }
}

enum MortgageAction { up, down }
