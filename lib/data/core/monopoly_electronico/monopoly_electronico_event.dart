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

class ChangeCurrentUser extends MonopolyElectronicoEvent {}

class PassExitEvent extends MonopolyElectronicoEvent {}

class FinishTurnPlayer extends MonopolyElectronicoEvent {}
