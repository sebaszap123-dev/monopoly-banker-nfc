part of 'monopoly_electronico_bloc.dart';

enum GameStatus { setup, loading, endgame, playing, transaction }

enum PlayerTransaction { none, salida, add, substract, fromPlayers }

class MonopolyElectronicoState extends Equatable {
  const MonopolyElectronicoState({
    this.cards = const [],
    this.players = const [],
    this.status = GameStatus.setup,
    this.currentPlayer,
    this.errorMessage,
    this.gameTransaction = PlayerTransaction.none,
    this.fromPlayer,
    double moneyExchange = 0,
    MoneyValue moneyValue = MoneyValue.millon,
  })  : _moneyValue = moneyValue,
        _moneyExchange = moneyExchange;
  final GameStatus status;
  final List<MonopolyCard> cards;
  final List<MonopolyPlayerX> players;
  final MonopolyPlayerX? currentPlayer;
  final MonopolyPlayerX? fromPlayer;
  final String? errorMessage;
  final PlayerTransaction gameTransaction;
  final double _moneyExchange;
  final MoneyValue _moneyValue;
  MonopolyElectronicoState copyWith({
    GameStatus? status,
    List<MonopolyCard>? cards,
    List<MonopolyPlayerX>? players,
    MonopolyPlayerX? player,
    MonopolyPlayerX? fromPlayer,
    String? errorMessage,
    PlayerTransaction? gameTransaction,
    double? moneyExchange,
    MoneyValue? moneyValue,
  }) {
    return MonopolyElectronicoState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      players: players ?? this.players,
      currentPlayer: player,
      errorMessage: errorMessage ?? this.errorMessage,
      gameTransaction: gameTransaction ?? this.gameTransaction,
      fromPlayer: fromPlayer,
      moneyExchange: moneyExchange ?? _moneyExchange,
      moneyValue: moneyValue ?? _moneyValue,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cards,
        players,
        currentPlayer,
        errorMessage,
        fromPlayer,
        gameTransaction,
      ];

  MonopolyPlayerX? playerFromCard(MonopolyCard card) {
    final index =
        players.indexWhere((element) => card.number == element.number);
    if (index != -1) {
      return players[index];
    }
    return null;
  }

  String get messageTransaction {
    switch (gameTransaction) {
      case PlayerTransaction.none:
        return '';
      case PlayerTransaction.salida:
        return '+ 2 M';
      case PlayerTransaction.add:
      case PlayerTransaction.substract:
        return '$_moneyExchange ${_moneyValue == MoneyValue.millon ? 'M' : 'K'}';
      case PlayerTransaction.fromPlayers:
        return '+ $_moneyExchange ${_moneyValue.name}: ${fromPlayer?.namePlayer}';
    }
  }

  double? get moneyPlayer {
    return currentPlayer?.money;
  }
}
