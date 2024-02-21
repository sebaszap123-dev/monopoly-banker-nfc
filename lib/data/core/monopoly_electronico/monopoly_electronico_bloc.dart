// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
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
    on<PayPlayersEvent>(_payPlayersEvent);
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
    _updatePlayer(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: PlayerTransaction.add,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
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
    _updatePlayer(state.currentPlayer!, uplayed);
    emit(state.copyWith(
      status: GameStatus.transaction,
      gameTransaction: PlayerTransaction.substract,
      moneyExchange: event.money,
      moneyValue: event.type,
      player: uplayed,
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

  _payPlayersEvent(
      PayPlayersEvent event, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final resp = await BankerAlerts.chooseTransaction();
    if (resp != null) {
      switch (resp) {
        case PayTo.playerToPlayer:
          await _p1ToP2(event);
          break;
        case PayTo.playerToPlayers:
          await _p1ToPlayers(event);
        case PayTo.playersToPlayer:
          await _playersToP1(event);
      }
      // TODO: HANDLE PLAYERS O PLAYER TO PLAYER (NFC data (get cardnumber))
    }
    print(resp);
  }

  _p1ToPlayers(PayPlayersEvent event) async {
    final card1 = await BankerAlerts.readNfcDataCard(
        customText: 'Este jugador paga a los demas');

    if (card1 == null) {
      await BankerAlerts.noCardReaded(count: 1);
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
        emit(state.copyWith(
          // TODO: HACER QUE NO PUEDA CAMBIAR DE TARJETA HASTA QUE PAGUE O BANCARROTA (PUEDE HACER OTRAS COSAS COMO COBRAR ETC)
          gameTransaction: PlayerTransaction.paying,
          status: GameStatus.transaction,
        ));
        return;
      }

      final updatedPlayers = state.players
          .map((e) => e.copyWith(
              money: e.number == card1.number
                  ? e.money - reduceMoney
                  : e.money + payMoney))
          .toList();

      emit(state.copyWith(
        players: updatedPlayers,
        status: GameStatus.playing,
        // TODO: AGREGAR A TODOS LOS EMITS QUE TENGAN PLAYING
        gameTransaction: PlayerTransaction.none,
      ));
    }
  }

  // TODO: FUNCIONA PERO QUE PASA SI UNO NO TIENE CON QUE PAGAR???
  _playersToP1(PayPlayersEvent event) async {
    final card = await BankerAlerts.readNfcDataCard(
        customText: 'Este jugador recibirá dinero de todos los demás');

    if (card == null) {
      await BankerAlerts.noCardReaded(count: 1);
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }

    final receiverIndex =
        state.players.indexWhere((element) => element.number == card.number);

    if (receiverIndex != -1) {
      final receiver = state.players[receiverIndex];
      final totalAmount = event.moneyToPay * (state.players.length - 1);

      // Actualizar el saldo del jugador receptor y los demás jugadores
      List<MonopolyPlayerX> cantPay = [];
      for (var player in state.players) {
        if (player.money < event.moneyToPay &&
            player.number != receiver.number) {
          cantPay.add(player);
        }
      }
      if (cantPay.isNotEmpty) {
        final String players = cantPay.map((e) => e.namePlayer).join(', ');
        await BankerAlerts.insufficientFundsPlayers(players: players);
        emit(state.copyWith(
          status: GameStatus.playing,
          gameTransaction: PlayerTransaction.paying,
        ));
      }

      final updatedPlayers = state.players
          .map((player) => player.copyWith(
              money: player.number == receiver.number
                  ? player.money + totalAmount
                  : player.money - event.moneyToPay))
          .toList();

      emit(state.copyWith(
        players: updatedPlayers,
        status: GameStatus.playing,
        gameTransaction: PlayerTransaction.none,
      ));
    }
  }

  _p1ToP2(PayPlayersEvent event) async {
    final List<MonopolyCard?> cards = [];
    final card1 = await BankerAlerts.readNfcDataCard(
        customText: 'Inserta la tarjeta de quien pagará');
    await BankerAlerts.customMessageAlertSuccess(
        text: 'AHora inserta otra tarjeta');
    final card2 = await BankerAlerts.readNfcDataCard(
        customText: 'Inserta la tarjeta de quien recibe el dinero');

    if (card1 == null || card2 == null || card1 == card2) {
      BankerAlerts.customMessageAlertFail(
          text: 'No se leyó correctamente las tarjetas');
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }

    cards.add(card1);
    cards.add(card2);

    final cardNumbers = cards.map((card) => card?.number).toSet();
    final playersToUpdate = state.players
        .where((player) => cardNumbers.contains(player.number))
        .toList();

    if (cards.length != 2) {
      final count = 2 - cards.length;
      await BankerAlerts.noCardReaded(count: count);
      emit(state.copyWith(status: GameStatus.playing));
      return;
    }

    final player1 = playersToUpdate[0];
    final player2 = playersToUpdate[1];
    final payMoney = _convertKtoM(event.type, event.moneyToPay);

    if (player1.money < payMoney) {
      emit(state.copyWith(
        gameTransaction: PlayerTransaction.paying,
        status: GameStatus.transaction,
      ));
      return;
    }

    final updatedPlayer1 = player1.copyWith(money: player1.money - payMoney);
    final updatedPlayer2 = player2.copyWith(money: player2.money + payMoney);

    _updatePlayer(player1, updatedPlayer1);
    _updatePlayer(player2, updatedPlayer2);

    emit(state.copyWith(status: GameStatus.playing));
  }

  double _convertKtoM(MoneyValue value, double currentMoney) {
    double money = 0;
    if (value == MoneyValue.miles) {
      money = currentMoney / 1000;
    } else {
      money = currentMoney;
    }
    return money;
  }

  void _updatePlayer(MonopolyPlayerX old, MonopolyPlayerX uplayer) {
    final index = state.players.indexOf(old);
    final temp = List.of(state.players);
    temp[index] = uplayer;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(players: temp));
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
