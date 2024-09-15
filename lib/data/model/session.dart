import 'package:isar/isar.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/player.dart';
part 'session.g.dart';

@collection
class GameSessions {
  Id id = Isar.autoIncrement;

  @enumerated
  late GameVersions version;

  late DateTime startTime;
  late DateTime updateTime;

  late int playtime;
  final players = IsarLinks<MonopolyPlayer>();

  @ignore
  Duration get playtimeDuration {
    final now = DateTime.now();
    final difference = now.difference(updateTime);
    playtime = playtime + difference.inMilliseconds;
    return Duration(milliseconds: playtime);
  }
}
