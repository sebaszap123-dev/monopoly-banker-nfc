import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/session.dart';

abstract class ElectronicRepositoryV2 {
  Future<void> openIsarDB();
  Future<GameSessions> createSession(List<MonopolyPlayer> players);
  Future<void> backupSession(
      List<MonopolyPlayer> players, GameSessions session);
}
