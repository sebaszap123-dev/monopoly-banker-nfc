import 'package:monopoly_banker/data/database/monopoly_database.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:sqflite/sqflite.dart';

class MonopolyElectronicService {
  final Database _dbX;

  MonopolyElectronicService._(this._dbX);

  static Future<MonopolyElectronicService> initDbX() async {
    try {
      final db = await MonopolyDatabase.initDatabase();
      return MonopolyElectronicService._(db);
    } catch (e) {
      throw ('Error db $e');
    }
  }

  // Método para obtener todas las cartas de Monopoly
  Future<List<MonopolyCard>> getAllMonopolyCards() async {
    try {
      final db = _dbX;
      final results = await db.query(MonopolyDatabase.cardPlayerTb);
      final parsed = results.map((map) => MonopolyCard.fromMap(map)).toList();
      return results.map((map) => MonopolyCard.fromMap(map)).toList();
    } catch (e) {
      // Manejo de errores
      return [];
    }
  }

  /// Create a monopoly card and return the ID: [int] (0 if conflic occurs)
  Future<int> addMonopolyCard(MonopolyCard card) async {
    final db = _dbX;

    final resp = await db.insert(
      MonopolyDatabase.cardPlayerTb,
      card.toSqlMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return resp;
  }

  /// Update a monopoly card and return the COUNT OF ITEMS updated: [int] (0 if conflic occurs)
  Future<int> updateMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    final resp = await db.update(MonopolyDatabase.cardPlayerTb, card.toSqlMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id = ?',
        whereArgs: [card.id]);

    return resp;
  }

  /// Create a monopoly card and return the ID: [int] (0 if conflic occurs)
  Future<int> deleteMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    final resp = await db.delete(MonopolyDatabase.cardPlayerTb,
        where: 'id = ?', whereArgs: [card.id]);

    return resp;
  }

  /// Setup players reponse: count of deleted players [int]
  Future<List<MonopolyPlayerX>> setupPlayers(
      List<MonopolyPlayerX> players) async {
    try {
      final db = _dbX;
      final List<MonopolyPlayerX> temp = [];
      for (var player in players) {
        final id = await db.insert(
          MonopolyDatabase.playersXTb,
          player.toSql(),
        );
        temp.add(player.copyWith(id: id));
      }

      return temp;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///
  Future<void> backupPlayers(List<MonopolyPlayerX> players) async {
    try {
      final db = _dbX;
      for (var player in players) {
        await db.update(
          MonopolyDatabase.playersXTb,
          player.toSql(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'id = ?',
          whereArgs: [player.id],
        );
      }
    } catch (e) {
      print(e);
    }
  }

  /// Reset players reponse: count of deleted players [int]
  Future<int> resetPlayers() async {
    try {
      final db = _dbX;
      final results = await db.delete(
        MonopolyDatabase.playersXTb,
      );

      return results;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
