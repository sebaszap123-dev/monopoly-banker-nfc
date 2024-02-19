import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MonopolyDatabase {
  /// Name of the db
  static const int versionClassic = 1;
  static const int versionElectronic = 1;
  static const String _dbEletronic = 'monopoly_elect_1.db';
  static const String _dbClassic = 'monopoly_elect_1.db';

  // ELECTRONIC
  static const cardPlayerTb = 'card_players_electronic';
  static const String sqlCreatePlayers = '''
CREATE TABLE $cardPlayerTb(
CREATE TABLE MonopolyCards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  color INTEGER NOT NULL,
  colorName TEXT NOT NULL
)
''';

  /// Version of database change when you update the database

  /// Get the path of the database for Query Tasks
  static Future<String> getPathElectronic() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbEletronic);
    return path;
  }

  static Future<String> getPathClassic() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbClassic);
    return path;
  }

  static String get dbEletronic => _dbEletronic;
  static String get dbClassic => _dbClassic;
}
