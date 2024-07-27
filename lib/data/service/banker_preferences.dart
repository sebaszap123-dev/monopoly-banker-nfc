import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BankerPreferences {
// Create storage
  final storage = const FlutterSecureStorage();
  // static const String _sessions =
  //     'sessions-7e4c8681-f94d-4b5a-bc76-a2bcbba7021b';
  // static const String _sessionId = 'id_session';
  // static const String _classicGames = 'saved_games_c';

  /// Has games saved [bool]
  // Future<bool> get hasCurrentGamesClassic async {
  //   final response = await storage.read(key: _classicGames);
  //   if (response == null) {
  //     return false;
  //   }
  //   return response.contains('1');
  // }

  // Future<bool> get hasSessions async {
  //   final response = await storage.read(key: _sessions);
  //   if (response == null) {
  //     return false;
  //   }
  //   return response == '1';
  // }

  // Future<void> startGameX({required String lastSessionId}) async {
  //   await storage.write(key: _sessionId, value: lastSessionId);
  //   await storage.write(key: _electronicGames, value: '1');
  // }

  // Future<void> updateSessions(bool hasSession) async {
  //   if (hasSession) {
  //     await storage.write(key: _sessions, value: '1');
  //     return;
  //   }
  //   storage.write(key: _sessions, value: '0');
  // }

  // Future<String?> idSession() async {
  //   return await storage.read(key: _sessionId);
  // }

  // Future<void> deleteGameX() async {
  //   await storage.delete(key: _sessionId);
  //   await storage.delete(key: _electronicGames);
  // }

  // Future<void> deleteGameClassic() async {
  //   await storage.delete(key: _classicGames);
  // }
}
