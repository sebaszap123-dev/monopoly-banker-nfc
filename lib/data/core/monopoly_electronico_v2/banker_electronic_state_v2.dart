part of 'banker_electronic_bloc_v2.dart';

enum GameStatus { setup, loading, endgame, playing, transaction, backup }

enum GameTransaction { none, salida, add, substract, paying }

/// P1-P2 [int] P1 PAGA A P2
/// P1-P'S el P1 paga a todos los demas
/// P'S-P1 Los players le pagan al player en cuestión (tarjetas especiales)
enum PayToAction {
  playerToPlayer,
  playerToPlayers,
  playersToPlayer,
}

class ElectronicState extends Equatable {
  const ElectronicState({
    this.cards = const [],
    this.players = const [],
    this.status = GameStatus.setup,
    this.currentPlayer,
    this.gameTransaction = GameTransaction.none,
    this.fromPlayer,
    this.gameSession,
    this.moneyExchange,
    // MoneyType moneyValue = MoneyType.million,
  });
  final GameStatus status;
  final List<MonopolyCardV2> cards;
  final List<MonopolyPlayer> players;
  final MonopolyPlayer? currentPlayer;
  final MonopolyPlayer? fromPlayer;
  final GameTransaction gameTransaction;
  final Money? moneyExchange;
  final GameSessions? gameSession;

  /// Copy method to create a new instance with the updated values
  ElectronicState copyWith({
    GameSessions? gameSession,
    GameStatus? status,
    List<MonopolyCardV2>? cards,
    List<MonopolyPlayer>? players,
    MonopolyPlayer? player,
    MonopolyPlayer? fromPlayer,
    GameTransaction? gameTransaction,
    Money? moneyExchange,
  }) {
    return ElectronicState(
      moneyExchange: moneyExchange ?? this.moneyExchange,
      gameSession: gameSession ?? this.gameSession,
      status: status ?? this.status,
      cards: cards ?? this.cards,
      players: players ?? this.players,
      currentPlayer: player,
      gameTransaction: gameTransaction ?? this.gameTransaction,
      fromPlayer: fromPlayer,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cards,
        players,
        currentPlayer,
        fromPlayer,
        gameTransaction,
      ];

  MonopolyPlayer? playerFromCard(MonopolyCardV2 card) {
    final index =
        players.indexWhere((element) => card.number == element.card!.number);
    if (index != -1) {
      return players[index];
    }
    return null;
  }

  String get messageTransaction {
    switch (gameTransaction) {
      case GameTransaction.none:
        return '';
      case GameTransaction.salida:
        return '+ 2 M';
      case GameTransaction.add:
      case GameTransaction.substract:
        return moneyExchange.toString();
      case GameTransaction.paying:
        return 'Paying to player';
    }
  }

  Money? get moneyPlayer {
    return currentPlayer?.money;
  }
}
