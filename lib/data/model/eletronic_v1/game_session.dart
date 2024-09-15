import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/monopoly_player.dart';

class GameSession {
  final GameVersions gameVersion;
  final int? id;
  final DateTime startTime;
  final DateTime updateTime;
  final List<MonopolyPlayerX> players;

  /// Played time in minutes
  final int playtime;
  GameSession({
    this.id,
    required this.gameVersion,
    required this.players,
    required this.startTime,
    required this.updateTime,
    this.playtime = 0,
  });

  GameSession copyWith(
      {int? id,
      List<MonopolyPlayerX>? players,
      DateTime? updateTime,
      int? playtime}) {
    return GameSession(
      id: id ?? this.id,
      players: players ?? this.players,
      updateTime: updateTime ?? this.updateTime,
      // IMMUTABLE
      gameVersion: this.gameVersion,
      startTime: this.startTime,
      playtime: playtime ?? this.playtime,
    );
  }

  Map<String, dynamic> toSqlMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'updateTime': updateTime.millisecondsSinceEpoch,
      'playtime': playtime,
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
      playtime: json['playtime'] as int,
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

  int get playtimeMinutes {
    final now = DateTime.now();
    final difference = now.difference(updateTime);
    return playtime + difference.inMinutes.abs();
  }
}
