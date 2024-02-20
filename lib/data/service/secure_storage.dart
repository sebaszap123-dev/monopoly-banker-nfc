import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MonopolyGamesStorage {
// Create storage
  final storage = const FlutterSecureStorage();
  static const String _eletronicGames = 'saved_games_x';
  static const String _classicGames = 'saved_games_c';

  /// Has games saved [bool]
  Future<bool> get hasCurrentGames async {
    final futures = [
      storage.read(key: _eletronicGames),
      storage.read(key: _classicGames),
    ];

    final responses = await Future.wait(futures);

    return responses.contains('1');
  }

  Future<void> startGameX() async {
    await storage.write(key: _eletronicGames, value: '1');
  }

  Future<void> saveGameClassic() async {
    await storage.write(key: _classicGames, value: '1');
  }

  Future<void> deleteGameX() async {
    await storage.delete(key: _eletronicGames);
  }

  Future<void> deleteGameClassic() async {
    await storage.delete(key: _classicGames);
  }
}
