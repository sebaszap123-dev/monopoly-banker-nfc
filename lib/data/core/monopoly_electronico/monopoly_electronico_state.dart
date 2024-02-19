part of 'monopoly_electronico_bloc.dart';

enum GameStatus { setup, loading, success, playing, transaction }

class MonopolyElectronicoState extends Equatable {
  const MonopolyElectronicoState({
    this.cards = const [],
    this.players = const [],
    this.status = GameStatus.setup,
    this.hasSavedGame = false,
  });
  final bool hasSavedGame;
  final GameStatus status;
  final List<MonopolyCard> cards;
  final List<MonopolyPlayerX> players;

  MonopolyElectronicoState copyWith({
    GameStatus? status,
    List<MonopolyCard>? cards,
    List<MonopolyPlayerX>? players,
    bool? hasSavedGame,
  }) {
    return MonopolyElectronicoState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      players: players ?? this.players,
      hasSavedGame: hasSavedGame ?? this.hasSavedGame,
    );
  }

  @override
  List<Object> get props => [status, cards, players, hasSavedGame];
}
