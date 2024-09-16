import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/property.dart';
import 'package:monopoly_banker/data/model/session.dart';

abstract class ElectronicRepositoryV2 {
  Future<void> openIsarDB();
  Future<GameSessions> createSession(List<MonopolyPlayer> players);
  Future<void> backupSession(
      List<MonopolyPlayer> players, GameSessions session);
  Future<void> restoreSession(int session);
  Future<void> addPropertyToPlayer(MonopolyPlayer player, Property property);
  Future<void> mortgagePropertyToPlayer(
      MonopolyPlayer player, Property property,
      {bool isMortgage = true});
  Future<void> transferPropertiesPlayers(MonopolyPlayer playerToTransfer,
      MonopolyPlayer proprietary, List<Property> properties);
  Future<int> countSessions();
  Future<GameSessions?> lastSession();
  Future<List<GameSessions>> getGameSessions();
  Future<void> deleteGameSession(int id);
}
