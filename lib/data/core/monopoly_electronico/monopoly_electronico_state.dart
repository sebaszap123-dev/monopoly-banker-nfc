part of 'monopoly_electronico_bloc.dart';

enum GameStatus { setup, loading, success, playing, transaction }

class MonopolyElectronicoState extends Equatable {
  const MonopolyElectronicoState({
    this.cards = const [],
    this.players = const [],
    this.status = GameStatus.setup,
    this.currentPlayer,
    this.errorMessage,
  });
  final GameStatus status;
  final List<MonopolyCard> cards;
  final List<MonopolyPlayerX> players;
  final MonopolyPlayerX? currentPlayer;
  final String? errorMessage;
  MonopolyElectronicoState copyWith({
    GameStatus? status,
    List<MonopolyCard>? cards,
    List<MonopolyPlayerX>? players,
    MonopolyPlayerX? player,
    String? errorMessage,
  }) {
    return MonopolyElectronicoState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      players: players ?? this.players,
      currentPlayer: player,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, cards, players, currentPlayer, errorMessage];

  MonopolyPlayerX? playerFromCard(MonopolyCard card) {
    final index =
        players.indexWhere((element) => card.number == element.number);
    if (index != -1) {
      return players[index];
    }
    return null;
  }
}
