part of 'monopoly_electronico_bloc.dart';

sealed class MonopolyElectronicoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HandleCardsEvent extends MonopolyElectronicoEvent {}

class StartGameEvent extends MonopolyElectronicoEvent {
  final List<MonopolyPlayerX> players;
  StartGameEvent(this.players);
}

class RestoreGameEvent extends MonopolyElectronicoEvent {
  final String sesionId;

  RestoreGameEvent({required this.sesionId});
}

class BackupGame extends MonopolyElectronicoEvent {
  final bool appPaused;
  BackupGame({required this.appPaused});
}

class UpdatePlayerEvent extends MonopolyElectronicoEvent {}

class PassExitEvent extends MonopolyElectronicoEvent {}

class FinishTurnPlayerEvent extends MonopolyElectronicoEvent {}

class AddPlayerMoneyEvent extends MonopolyElectronicoEvent {
  final MoneyValue type;
  final double money;
  AddPlayerMoneyEvent({
    required this.type,
    required this.money,
  });
}

class SubstractMoneyEvent extends MonopolyElectronicoEvent {
  final MoneyValue type;
  final double money;
  SubstractMoneyEvent({
    required this.type,
    required this.money,
  });
}

class PayPlayersEvent extends MonopolyElectronicoEvent {
  final double moneyToPay;
  final MoneyValue type;

  PayPlayersEvent(this.moneyToPay, this.type);
}
