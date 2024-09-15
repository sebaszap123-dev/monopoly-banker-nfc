import 'package:isar/isar.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';

import 'package:monopoly_banker/data/model/money.dart';

part 'player.g.dart';

@collection
class MonopolyPlayer {
  Id id = Isar.autoIncrement;
  MonopolyCardV2? card;
  late Money money;
  late int sessionId;
  String? name;
  // late GameVersions version;
  @ignore
  String get namePlayer {
    return this.name ?? 'Jugador $id';
  }
}
