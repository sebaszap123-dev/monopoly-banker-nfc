import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';

class GameSession {
  final GameVersions version;
  final String sessionId;
  final List<MonopolyPlayerX> players;

  GameSession(this.version, this.players, this.sessionId);
}
