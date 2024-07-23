// ignore_for_file: avoid_print

import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/database/monopoly_database.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';
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
      return results.map((map) => MonopolyCard.fromMap(map)).toList();
    } catch (e) {
      // Manejo de errores
      return [];
    }
  }

  /// Create a monopoly card and return the ID: [int] (0 if conflic occurs)
  Future<int> addMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    final cards = await db.query(MonopolyDatabase.cardPlayerTb,
        where: 'number = ?', whereArgs: [card.number], limit: 1);
    print(cards);
    if (cards.isNotEmpty) {
      BankerAlerts.alreadyRegisteredCard();
      return -1;
    }
    final resp = await db.insert(
      MonopolyDatabase.cardPlayerTb,
      card.toSqlMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return resp;
  }

  /// Create a monopoly [MonopolyPlayerX] and return the ID: [int] (0 if conflic occurs)
  Future<int> addPlayerX(MonopolyPlayerX player) async {
    final db = _dbX;

    final resp = await db.insert(
      MonopolyDatabase.playersXTb,
      player.toSql(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return resp;
  }

  /// Create a monopoly [MonopolyPlayerX] and return the ID: [int] (0 if conflic occurs)
  Future<List<MonopolyPlayerX>> getSesionPlayers(String idSesion) async {
    final db = _dbX;

    final resp = await db.query(
      MonopolyDatabase.playersXTb,
      where: 'gameSesion = ?',
      whereArgs: [idSesion],
    );

    return resp.map((e) => MonopolyPlayerX.fromMap(e)).toList();
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

  /// Delete a monopoly card and return the ID: [int] (0 if conflict occurs)
  Future<int> deleteMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    try {
      // Delete by id or number
      final resp = await db.delete(
        MonopolyDatabase.cardPlayerTb,
        where: 'id = ? OR number = ?',
        whereArgs: [card.id, card.number],
      );

      // If a row was deleted, return the card.id, else return 0
      return resp > 0 ? card.id : 0;
    } catch (e) {
      // Handle any exceptions and return 0
      return 0;
    }
  }

  /// Create a monopoly player [MonopolyPlayerX] and return the COUNT: [int] (0 if conflic occurs)
  Future<void> deleteAllPlayers() async {
    final db = _dbX;
    final resp = await db.delete(
      MonopolyDatabase.playersXTb,
    );
    await getIt<MonopolyGamesStorage>().deleteGameX();
    BankerAlerts.showSuccessDeletedPlayers(resp);
  }

  /// Setup players reponse: count of deleted players [int]
  Future<List<MonopolyPlayerX>> setupPlayers(
      List<MonopolyPlayerX> players) async {
    try {
      final db = _dbX.batch();
      for (var player in players) {
        db.insert(
          MonopolyDatabase.playersXTb,
          player.toSql(),
        );
      }
      final resp = await db.commit();

      // temp.add(player.copyWith(id: id));
      print(resp[0]);
      final List<MonopolyPlayerX> playersx = [];
      for (int index = 0; resp.length > index; index++) {
        final idPlayer = players[index].copyWith(id: resp[index] as int);
        playersx.add(idPlayer);
      }
      return playersx;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///
  Future<void> backupPlayers(List<MonopolyPlayerX> players) async {
    try {
      final batch = _dbX.batch();
      for (var player in players) {
        batch.update(
          MonopolyDatabase.playersXTb,
          player.toSql(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'id = ?',
          whereArgs: [player.id],
        );
      }
      final resp = await batch.commit();
      print(resp);
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
