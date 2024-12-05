import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseUtils {
  static Future<int> countQuery(
      String dbName, Database db, GameVersions version) async {
    final count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $dbName WHERE gameVersion = "${version.name}"'));
    if (count == null) {
      return 0;
    }
    return count;
  }
}
