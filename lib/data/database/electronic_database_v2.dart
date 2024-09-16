import 'package:isar/isar.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/property.dart';
import 'package:monopoly_banker/data/model/session.dart';
import 'package:monopoly_banker/data/repository/eletronic_repository_v2.dart';
import 'package:path_provider/path_provider.dart';

class ElectronicDatabaseV2 extends ElectronicRepositoryV2 {
  late Isar isar;

  ElectronicDatabaseV2();

  Future<void> initialize() async {
    await openIsarDB();
  }

  @override
  Future<void> openIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        MonopolyPlayerSchema,
        GameSessionsSchema,
        HouseSchema,
        RailWaySchema,
        CompanyServiceSchema,
      ],
      directory: dir.path,
    );
  }

  @override
  Future<void> backupSession(
      List<MonopolyPlayer> players, GameSessions session) async {
    await _savePlayers(players);
    await isar.writeTxn(() async {
      await isar.gameSessions.put(session);
      await session.players.save();
    });
  }

  @override
  Future<GameSessions> createSession(List<MonopolyPlayer> players) async {
    // Save the players to the database
    await _savePlayers(players);

    // SESSION
    final session = GameSessions();
    session
      ..startTime = DateTime.now()
      ..updateTime = DateTime.now()
      ..version = GameVersions.electronic
      ..playtime = 0;

    // Perform all write operations in one transaction
    await isar.writeTxn<void>(() async {
      await isar.gameSessions.put(session);
      print(session);

      // Add the players to the session
      session.players.addAll(players);

      // Save the session with updated players
      await session.players.save();
    });

    // Return the session
    return session;
  }

  Future<List<int>> _savePlayers(List<MonopolyPlayer> players) async {
    return await isar.writeTxn(() async {
      return await isar.monopolyPlayers.putAll(players);
    });
  }

  @override
  Future<GameSessions?> restoreSession(int session) async {
    return await isar.gameSessions.get(session);
  }

  Future<List<GameSessions>> getGameSessions() async {
    return await isar.gameSessions.where().findAll();
  }

  @override
  Future<int> countSessions() async {
    return await isar.gameSessions.where().count();
  }

  @override
  Future<bool> addPropertyToPlayer(
      MonopolyPlayer player, Property property) async {
    try {
      await isar.writeTxn(() async {
        if (property is House) {
          await isar.houses.put(property);
          player.houses.add(property);
          await player.houses.save();
        } else if (property is CompanyService) {
          await isar.companyServices.put(property);
          player.services.add(property);
          await player.services.save();
        } else if (property is RailWay) {
          await isar.railWays.put(property);
          player.railways.add(property);
          await player.railways.save();
        }

        // Guarda los cambios del jugador
        await isar.monopolyPlayers.put(player);
      });
      return true;
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
      return false;
    }
  }

  @override
  Future<bool> transferPropertiesPlayers(MonopolyPlayer playerToTransfer,
      MonopolyPlayer proprietary, List<Property> properties) async {
    try {
      await isar.writeTxn(() async {
        for (var property in properties) {
          // Remover la propiedad del jugador propietario original
          if (property is House) {
            proprietary.houses.remove(property);
            await proprietary.houses.save();
          } else if (property is CompanyService) {
            proprietary.services.remove(property);
            await proprietary.services.save();
          } else if (property is RailWay) {
            proprietary.railways.remove(property);
            await proprietary.railways.save();
          }

          // Agregar la propiedad al nuevo jugador
          if (property is House) {
            playerToTransfer.houses.add(property);
            await playerToTransfer.houses.save();
          } else if (property is CompanyService) {
            playerToTransfer.services.add(property);
            await playerToTransfer.services.save();
          } else if (property is RailWay) {
            playerToTransfer.railways.add(property);
            await playerToTransfer.railways.save();
          }
        }

        // Guardar ambos jugadores para persistir los cambios
        await isar.monopolyPlayers.put(proprietary);
        await isar.monopolyPlayers.put(playerToTransfer);
      });
      return true;
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
      return false;
    }
  }

  @override
  Future<bool> mortgagePropertyToPlayer(
      MonopolyPlayer player, Property property,
      {bool isMortgage = false}) async {
    property.isMortgage = isMortgage;
    try {
      await isar.writeTxn(() async {
        if (property is House) {
          await isar.houses.put(property);
          await player.houses.save();
        } else if (property is CompanyService) {
          await isar.companyServices.put(property);
          await player.services.save();
        } else if (property is RailWay) {
          await isar.railWays.put(property);
          await player.railways.save();
        }

        // Guarda los cambios del jugador
        await isar.monopolyPlayers.put(player);
      });
      return true;
    } catch (e) {
      BankerAlerts.unhandledError(error: e.toString());
      return false;
    }
  }

  @override
  Future<GameSessions?> lastSession() {
    return isar.gameSessions.where().sortByPlaytimeDesc().findFirst();
  }

  @override
  Future<void> deleteGameSession(int id) async {
    await isar.writeTxn(() async {
      final session = await isar.gameSessions.get(id);
      if (session == null) return;
      await session.players.filter().deleteAll();
      await session.players.save();
      await isar.gameSessions.delete(session.id);
    });
  }
}
