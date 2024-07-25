import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/game_session.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';

abstract class BankerRepository {
  Future<List<MonopolyCard>> getAllMonopolyCards(GameVersions version);
  Future<int> addMonopolyCard(MonopolyCard card);
  Future<int> addPlayerX(MonopolyPlayerX player);
  Future<List<MonopolyPlayerX>> getSessionPlayers(String idSession);
  Future<int> updateMonopolyCard(MonopolyCard card);
  Future<int> deleteMonopolyCard(MonopolyCard card);
  Future<void> deleteAllPlayers(GameVersions version);
  // Future<List<MonopolyPlayerX>> _setupPlayers(List<MonopolyPlayerX> players);
  Future<void> backupPlayers(List<MonopolyPlayerX> players);
  Future<int> resetPlayers();
  Future<GameSession> createGameSessions(
      GameVersions version, List<MonopolyPlayerX> players);
  Future<List<GameSession>> getGameSessions(GameVersions version);
  Future<GameSession> getGameSession(int id);
  Future<bool> updateSession(int sessionId);
  Future<bool> deleteSession(int sessionId);
}
