// ignore_for_file: avoid_print

import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/database/monopoly_database.dart';
import 'package:monopoly_banker/data/model/game_session.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/repository/banker_repository.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class BankerElectronicService extends BankerRepository {
  final Database _dbX;

  BankerElectronicService._(this._dbX);

  static Future<BankerElectronicService> initDbX() async {
    try {
      final db = await MonopolyDatabase.initDatabase();
      return BankerElectronicService._(db);
    } catch (e) {
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      throw ('Error db $e');
    }
  }

  /// Método para obtener todas las cartas de Monopoly
  @override
  Future<List<MonopolyCard>> getAllMonopolyCards(GameVersions version) async {
    try {
      final db = _dbX;
      final results = await db.query(MonopolyDatabase.cardPlayerTb,
          where: 'gameVersion = ?', whereArgs: [version.name]);
      return results.map((map) => MonopolyCard.fromMap(map)).toList();
    } catch (e) {
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      throw e;
    }
  }

  /// Create a monopoly card and return the ID: [int] (0 if conflict occurs)
  @override
  Future<int> addMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    final cards = await db.query(MonopolyDatabase.cardPlayerTb,
        where: 'number = ?', whereArgs: [card.number], limit: 1);
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

  /// Create a monopoly [MonopolyPlayerX] and return the ID: [int] (0 if conflict occurs)
  @override
  Future<int> addPlayerX(MonopolyPlayerX player) async {
    final db = _dbX;

    final resp = await db.insert(
      MonopolyDatabase.playersXTb,
      player.toSql(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return resp;
  }

  /// Create a monopoly [MonopolyPlayerX] and return the ID: [int] (0 if conflict occurs)
  @override
  Future<List<MonopolyPlayerX>> getSessionPlayers(String idSession) async {
    final db = _dbX;

    final resp = await db.query(
      MonopolyDatabase.playersXTb,
      where: 'gameSesion = ?',
      whereArgs: [idSession],
    );

    return resp.map((e) => MonopolyPlayerX.fromMap(e)).toList();
  }

  /// Update a monopoly card and return the COUNT OF ITEMS updated: [int] (0 if conflict occurs)
  @override
  Future<int> updateMonopolyCard(MonopolyCard card) async {
    final db = _dbX;
    final resp = await db.update(MonopolyDatabase.cardPlayerTb, card.toSqlMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id = ?',
        whereArgs: [card.id]);

    return resp;
  }

  /// Delete a monopoly card and return the ID: [int] (0 if conflict occurs)
  @override
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
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      throw e;
    }
  }

  /// Create a monopoly player [MonopolyPlayerX] and return the COUNT: [int] (0 if conflict occurs)
  @override
  Future<void> deleteAllPlayers(GameVersions version) async {
    final db = _dbX;
    final resp = await db.delete(MonopolyDatabase.playersXTb,
        where: 'gameVersion = ?', whereArgs: [version.name]);
    await getIt<MonopolyGamesStorage>().deleteGameX();
    BankerAlerts.showSuccessDeletedPlayers(resp);
  }

  /// Backup data players
  @override
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
      await batch.commit();
    } catch (e) {
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      throw e;
    }
  }

  /// Reset players reponse: count of deleted players [int]
  @override
  Future<int> resetPlayers() async {
    try {
      final db = _dbX;
      final results = await db.delete(
        MonopolyDatabase.playersXTb,
      );
      return results;
    } catch (e) {
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      throw e;
    }
  }

  /// Setup players reponse: count of deleted players [int]
  Future<List<MonopolyPlayerX>> _setupPlayers(
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

      final List<MonopolyPlayerX> playersx = [];
      for (int index = 0; resp.length > index; index++) {
        final idPlayer = players[index].copyWith(id: resp[index] as int);
        playersx.add(idPlayer);
      }
      return playersx;
    } catch (e) {
      // Maneja el error y notifica que no se pudo agregar jugadores
      // Puedes registrar el error o mostrar una notificación adecuada aquí
      // TODO: HANDLE ERROR AND NOTIFY NO USER

      throw Exception('Failed to setup players: $e');
    }
  }

  @override
  Future<GameSession> createGameSessions(
      GameVersions version, List<MonopolyPlayerX> players) async {
    try {
      final db = _dbX;
      GameSession session = GameSession.generateSession(version);
      final sessionId = await db.insert(
        MonopolyDatabase.sessionsTb,
        session.toSqlMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      session = session.copyWith(id: sessionId);
      final rawPlayers =
          players.map((player) => player.copyWith(sessionId: 1)).toList();
      final sessionPlayers = await _setupPlayers(rawPlayers);
      session = session.copyWith(players: sessionPlayers);
      return session;
    } catch (e) {
      print('Failed to save session $e');
      throw Exception('invalid session');
    }
  }

  @override
  Future<List<GameSession>> getGameSessions(GameVersions version) async {
    final db = _dbX;

    try {
      // Obtener las sesiones de la base de datos
      final sessionResp = await db.query(
        MonopolyDatabase.sessionsTb,
        where: '"gameVersion" = ?',
        whereArgs: [version.name],
        orderBy: '"startTime"',
      );

      // Convierte las sesiones obtenidas en una lista de IDs de sesiones
      final sessionIds = sessionResp.map((e) => e['id'] as int).toList();

      // Inicializar una lista para almacenar las sesiones de juego
      final List<GameSession> gameSessions = [];

      for (var sessionId in sessionIds) {
        // Obtener los jugadores de cada sesión
        final playerResp = await db.query(
          MonopolyDatabase.playersXTb,
          where: '"sessionId" = ?',
          whereArgs: [sessionId],
          orderBy: '"number"',
        );

        // Convertir la respuesta en una lista de jugadores
        final players =
            playerResp.map((e) => MonopolyPlayerX.fromMap(e)).toList();

        // Agregar la sesión de juego a la lista
        // TODO: ARREGLAR
        // gameSessions.add(GameSession(version, players, sessionId.toString()));
      }

      return gameSessions;
    } catch (e) {
      // Manejo de errores
      print('Error fetching game sessions: $e');
      return [];
    }
  }
}
