import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MonopolyDatabase {
  /// Name of the db
  static const int versionClassic = 1;
  static const int versionElectronic = 5; // Updated version to 3
  static const String _dbElectronic = 'monopoly_elect_1.db';
  static const String _dbClassic = 'monopoly_classic.db';

  // ELECTRONIC
  static const cardPlayerTb = 'MonopolyCards';
  static const playersXTb = 'MonopolyPlayerX';
  static const sessionsTb = 'MonopolySessions'; // New sessions table

  static const String sqlCreateCardPlayers = '''
CREATE TABLE $cardPlayerTb(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  color TEXT NOT NULL,
  colorName TEXT NOT NULL,
  version TEXT NOT NULL
)
''';

  static const String sqlCreatePlayers = '''
CREATE TABLE $playersXTb (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  color TEXT NOT NULL,
  infoNfc TEXT NOT NULL,
  namePlayer TEXT NOT NULL,
  money REAL NOT NULL,
  sessionId INTEGER NOT NULL,
  FOREIGN KEY (sessionId) REFERENCES $sessionsTb(id)
)
''';

  static const String sqlCreateSessions = '''
CREATE TABLE $sessionsTb (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  startTime INTEGER NOT NULL,
  updateTime INTEGER NOT NULL,
  gameVersion TEXT NOT NULL,
  playtime INTEGER NOT NULL
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
        await db.execute(sqlCreateSessions); // Create sessions table first
        await db.execute(sqlCreatePlayers); // Create players table with FK
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
          break;
        case 3:
          batch.execute(sqlCreateSessions); // Create sessions table
          batch.execute('''
            ALTER TABLE $playersXTb 
            ADD COLUMN sessionId INTEGER NOT NULL DEFAULT 0,
            DROP COLUMN gameVersion,
            DROP COLUMN gameSesion,
            ADD FOREIGN KEY (sessionId) REFERENCES $sessionsTb(id);
          ''');
          break;
        case 4:
          batch.execute('''
            ALTER TABLE $cardPlayerTb 
            ADD COLUMN version TEXT NOT NULL DEFAULT electronic
            ''');
          break;
        case 5:
          batch.execute('''
            ALTER TABLE $sessionsTb 
            ADD COLUMN playtime INTEGER NOT NULL DEFAULT 0
            ''');
          break;
      }
    }
  }
}
