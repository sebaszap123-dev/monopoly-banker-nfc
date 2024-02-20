import 'dart:ui';

import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:uuid/uuid.dart';

class MonopolyPlayerX {
  final int id;
  final String number;
  final Color color;
  final double money;
  final String infoNfc;
  final String? gameSesion;
  final String? namePlayer;
  MonopolyPlayerX._({
    this.id = 0,
    required this.number,
    required this.color,
    required this.infoNfc,
    this.namePlayer,
    this.gameSesion,
    this.money = 15,
  });

  factory MonopolyPlayerX.fromCard(MonopolyCard card, String player) {
    return MonopolyPlayerX._(
      number: card.number,
      color: card.color,
      namePlayer: player,
      infoNfc: const Uuid().v6(),
    );
  }

  // Método para crear un objeto MonopolyPlayerX desde un mapa
  factory MonopolyPlayerX.fromMap(Map<String, dynamic> map) {
    return MonopolyPlayerX._(
      id: map['id'],
      number: map['number'],
      color: (map['color'] as String).toColor(),
      money: map['money'],
      namePlayer: map['namePlayer'],
      gameSesion: map['gameSesion'],
      infoNfc: const Uuid().v6(),
    );
  }

  // Método para convertir un objeto MonopolyPlayerX a un mapa
  Map<String, dynamic> toSql() {
    return {
      'number': number,
      'color': color.toHex(),
      'namePlayer': namePlayer,
      'gameSesion': gameSesion,
      'money': money,
      'infoNfc': infoNfc
    };
  }

  MonopolyPlayerX copyWith({
    int? id,
    String? number,
    Color? color,
    String? infoNfc,
    String? namePlayer,
    String? gameSesion,
    double? money,
  }) {
    return MonopolyPlayerX._(
      id: id ?? this.id,
      number: number ?? this.number,
      color: color ?? this.color,
      namePlayer: namePlayer ?? this.namePlayer,
      gameSesion: gameSesion,
      infoNfc: const Uuid().v6(),
      money: money ?? this.money,
    );
  }
}
