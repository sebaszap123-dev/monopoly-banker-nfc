import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MonopolyDatabase {
  /// Name of the db
  static const int versionClassic = 1;
  static const int versionElectronic = 2; // Updated version to 2
  static const String _dbElectronic = 'monopoly_elect_1.db';
  static const String _dbClassic = 'monopoly_classic.db';

  // ELECTRONIC
  static const cardPlayerTb = 'MonopolyCards';
  static const playersXTb = 'MonopolyPlayerX';

  static const String sqlCreateCardPlayers = '''
CREATE TABLE $cardPlayerTb(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  color TEXT NOT NULL,
  colorName TEXT NOT NULL,
  gameVersion TEXT NOT NULL
)
''';

  static const String sqlCreatePlayers = '''
CREATE TABLE $playersXTb (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  color TEXT NOT NULL,
  infoNfc TEXT NOT NULL,
  namePlayer TEXT NOT NULL,
  gameSesion TEXT NOT NULL,
  money REAL NOT NULL,
  gameVersion TEXT NOT NULL
)
''';

  /// Version of database change when you update the database

  /// Get the path of the database for Query Tasks
  static Future<String> getPathElectronic() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbElectronic);
    return path;
  }

  static Future<String> getPathClassic() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbClassic);
    return path;
  }

  static String get dbElectronic => _dbElectronic;
  static String get dbClassic => _dbClassic;

  static Future<Database> initDatabase() async {
    final electronicPath = await getPathElectronic();
    return await openDatabase(
      electronicPath,
      version: versionElectronic,
      onCreate: (db, version) async {
        await db.execute(sqlCreateCardPlayers);
        await db.execute(sqlCreatePlayers);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        _handleDatabaseUpgrades(batch, oldVersion, newVersion);
        await batch.commit();
      },
    );
  }

  static void _handleDatabaseUpgrades(
      Batch batch, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      switch (newVersion) {
        case 2:
          batch.execute('''
        ALTER TABLE $cardPlayerTb ADD COLUMN gameVersion TEXT NOT NULL DEFAULT '${GameVersions.electronic.name}';
      ''');
          batch.execute('''
        ALTER TABLE $playersXTb ADD COLUMN gameVersion TEXT NOT NULL DEFAULT '${GameVersions.electronic.name}';
      ''');
      }
      // Add further version upgrades here
      // e.g., if (oldVersion < 3) { ... }
    }
  }
}
