import 'package:isar/isar.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/session.dart';
import 'package:monopoly_banker/data/repository/eletronic_repository_v2.dart';
import 'package:path_provider/path_provider.dart';

class ElectronicDatabaseV2 extends ElectronicRepositoryV2 {
  late Isar db;

  ElectronicDatabaseV2();

  Future<void> initialize() async {
    await openIsarDB();
  }

  @override
  Future<void> openIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open(
      [
        MonopolyPlayerSchema,
        GameSessionsSchema,
      ],
      directory: dir.path,
    );
  }
}
