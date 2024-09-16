part of 'banker_electronic_bloc_v2.dart';

sealed class ElectronicEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartGameEvent extends ElectronicEvent {
  final List<MonopolyPlayer> players;
  StartGameEvent(this.players);
}

class RestoreGameEvent extends ElectronicEvent {
  final int sessionId;

  RestoreGameEvent({required this.sessionId});
}

class BackupGameEvent extends ElectronicEvent {
  final bool appPaused;
  BackupGameEvent({required this.appPaused});
}

class EndGameEvent extends ElectronicEvent {
  // final bool appPaused;
  EndGameEvent();
}

class UpdatePlayerEvent extends ElectronicEvent {}

class PassExitEvent extends ElectronicEvent {}

class FinishTurnPlayerEvent extends ElectronicEvent {}

class AddPlayerMoneyEvent extends ElectronicEvent {
  final Money money;

  AddPlayerMoneyEvent({
    required this.money,
  });
}

class SubtractMoneyEvent extends ElectronicEvent {
  final Money money;

  SubtractMoneyEvent({
    required this.money,
  });
}

class PayPlayersEvent extends ElectronicEvent {
  final Money money;

  PayPlayersEvent(this.money);
}

class BuyProperty extends ElectronicEvent {
  final Property property;
  final MonopolyPlayer player;
  BuyProperty(this.property, this.player);
}

class MortgageProperty extends ElectronicEvent {
  final Property property;
  final MonopolyPlayer player;
  MortgageProperty(this.property, this.player);
}

class ChangeProperties extends ElectronicEvent {
  final List<Property> properties;
  final MonopolyPlayer playerReceiver;
  final MonopolyPlayer playerGiving;

  ChangeProperties(this.properties, this.playerReceiver, this.playerGiving);
}
