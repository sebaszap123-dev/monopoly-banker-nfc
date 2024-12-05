import 'package:isar/isar.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/player.dart';
part 'session.g.dart';

@collection
class GameSessions {
  Id id = Isar.autoIncrement;

  @enumerated
  late GameVersions version;

  late DateTime createdAt;
  DateTime? restoredAt;
  late DateTime updateAt;

  late int playtime;
  final players = IsarLinks<MonopolyPlayer>();

  @ignore
  Duration get playtimeDuration {
    // Optimización: Calcula la duración directamente sin crear variables intermedias.
    return Duration(
        milliseconds:
            playtime + DateTime.now().difference(updateAt).inMilliseconds);
  }

  void updatePlayTime() {
    updateAt = DateTime.now();
    // Optimización: Usa un solo cálculo de diferencia.
    final difference =
        restoredAt?.difference(updateAt) ?? createdAt.difference(updateAt);
    playtime += difference.inMilliseconds.abs();
  }

  void restored() {
    restoredAt = DateTime.now();
  }
}
