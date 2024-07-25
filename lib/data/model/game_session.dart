import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';

class GameSession {
  final GameVersions gameVersion;
  final int? id;
  final DateTime startTime;
  final DateTime updateTime;
  final List<MonopolyPlayerX> players;

  GameSession({
    this.id,
    required this.gameVersion,
    required this.players,
    required this.startTime,
    required this.updateTime,
  });

  GameSession copyWith(
      {int? id, List<MonopolyPlayerX>? players, DateTime? updateTime}) {
    return GameSession(
      id: id ?? this.id,
      players: players ?? this.players,
      updateTime: updateTime ?? this.updateTime,
      // IMMUTABLE
      gameVersion: this.gameVersion,
      startTime: this.startTime,
    );
  }

  Map<String, dynamic> toSqlMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'updateTime': updateTime.millisecondsSinceEpoch,
      'gameVersion': gameVersion.name,
    };
  }

  factory GameSession.fromMap({required Map<String, dynamic> json}) {
    return GameSession(
      id: json['id'],
      gameVersion: GameVersions.values
          .firstWhere((version) => version.name == json['gameVersion']),
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
      updateTime:
          DateTime.fromMillisecondsSinceEpoch(json['updateTime'] as int),
      players: [],
    );
  }

  factory GameSession.generateSession(GameVersions version) {
    return GameSession(
      players: [],
      updateTime: DateTime.now(),
      // IMMUTABLE
      gameVersion: version,
      startTime: DateTime.now(),
    );
  }
}
