part of 'banker_electronic_bloc.dart';

sealed class MonopolyElectronicEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HandleCardsEvent extends MonopolyElectronicEvent {}

class StartGameEvent extends MonopolyElectronicEvent {
  final List<MonopolyPlayerX> players;
  StartGameEvent(this.players);
}

class RestoreGameEvent extends MonopolyElectronicEvent {
  final String sessionId;

  RestoreGameEvent({required this.sessionId});
}

class BackupGame extends MonopolyElectronicEvent {
  final bool appPaused;
  BackupGame({required this.appPaused});
}

class UpdatePlayerEvent extends MonopolyElectronicEvent {}

class PassExitEvent extends MonopolyElectronicEvent {}

class FinishTurnPlayerEvent extends MonopolyElectronicEvent {}

class AddPlayerMoneyEvent extends MonopolyElectronicEvent {
  final MoneyValue type;
  final double money;
  AddPlayerMoneyEvent({
    required this.type,
    required this.money,
  });
}

class SubtractMoneyEvent extends MonopolyElectronicEvent {
  final MoneyValue type;
  final double money;
  SubtractMoneyEvent({
    required this.type,
    required this.money,
  });
}

class PayPlayersEvent extends MonopolyElectronicEvent {
  final double moneyToPay;
  final MoneyValue type;

  PayPlayersEvent(this.moneyToPay, this.type);
}
