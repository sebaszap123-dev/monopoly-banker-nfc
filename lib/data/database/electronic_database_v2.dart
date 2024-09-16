import 'package:isar/isar.dart';
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
      ..version = GameVersions.electronicv2
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
  Future<void> setupProperties() async {
    // TODO: RE-EVALUATE
    // final properties = PropertyManager.getPredefinedProperties();

    // // Filtramos las propiedades con whereType en lugar de where para obtener listas del tipo correcto
    // final houses = properties.whereType<House>().toList();
    // final companies = properties.whereType<CompanyService>().toList();
    // final railway = properties.whereType<FerroService>().toList();

    // await isar.writeTxn(() async {
    //   final dbHouses = await isar.houses.where().count();
    //   if (dbHouses == 0) {
    //     await isar.houses.putAll(houses);
    //   }
    //   final dbCompanies = await isar.companyServices.where().count();
    //   if (dbCompanies == 0) {
    //     await isar.companyServices.putAll(companies);
    //   }
    //   final dbRailway = await isar.ferroServices.where().count();
    //   if (dbRailway == 0) {
    //     await isar.ferroServices.putAll(railway);
    //   }
    // });
  }

  @override
  Future<GameSessions?> restoreSession(int session) async {
    return await isar.gameSessions.get(session);
  }
}
