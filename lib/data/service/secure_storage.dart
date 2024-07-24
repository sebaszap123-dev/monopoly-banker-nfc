import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MonopolyGamesStorage {
// Create storage
  final storage = const FlutterSecureStorage();
  static const String _electronicGames = 'saved_games_x';
  static const String _sessionId = 'id_session';
  static const String _classicGames = 'saved_games_c';

  /// Has games saved [bool]
  Future<bool> get hasCurrentGamesClassic async {
    final response = await storage.read(key: _classicGames);
    if (response == null) {
      return false;
    }
    return response.contains('1');
  }

  Future<bool> get hasCurrentGamesElectronic async {
    final response = await storage.read(key: _electronicGames);
    if (response == null) {
      return false;
    }
    return response.contains('1');
  }

  Future<void> startGameX({required String lastSessionId}) async {
    await storage.write(key: _sessionId, value: lastSessionId);
    await storage.write(key: _electronicGames, value: '1');
  }

  Future<void> saveGameClassic() async {
    await storage.write(key: _classicGames, value: '1');
  }

  Future<String?> idSession() async {
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
