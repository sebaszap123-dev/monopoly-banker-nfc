import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MonopolyGamesStorage {
// Create storage
  final storage = const FlutterSecureStorage();
  static const String _electronicGames = 'saved_games_x';
  static const String _sessionId = 'id_session';
  static const String _classicGames = 'saved_games_c';

  /// Has games saved [bool]
  Future<bool> get hasCurrentGames async {
    final futures = [
      storage.read(key: _electronicGames),
      storage.read(key: _classicGames),
    ];

    final responses = await Future.wait(futures);

    return responses.contains('1');
  }

  Future<void> startGameX({required String sessionId}) async {
    await storage.write(key: _sessionId, value: sessionId);
    await storage.write(key: _electronicGames, value: '1');
  }

  Future<void> saveGameClassic() async {
    await storage.write(key: _classicGames, value: '1');
  }

  Future<String?> idSesion() async {
    return await storage.read(key: _sessionId);
  }

  Future<void> deleteGameX() async {
    await storage.delete(key: _sessionId);
    await storage.delete(key: _electronicGames);
  }

  Future<void> deleteGameClassic() async {
    await storage.delete(key: _classicGames);
  }
}
