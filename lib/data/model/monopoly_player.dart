import 'dart:ui';

import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';

class MonopolyPlayerX {
  final int id;
  final String number;
  final Color color;
  final String? namePlayer;
  final double money;
  MonopolyPlayerX._({
    this.id = 0,
    this.namePlayer,
    required this.number,
    required this.color,
    this.money = 2.5,
  });

  factory MonopolyPlayerX.fromCard(MonopolyCard card, String player) {
    return MonopolyPlayerX._(
      number: card.number,
      color: card.color,
      namePlayer: player,
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
    );
  }

  // Método para convertir un objeto MonopolyPlayerX a un mapa
  Map<String, dynamic> toSql() {
    return {
      'number': number,
      'color': color.value,
      'namePlayer': namePlayer,
    };
  }

  MonopolyPlayerX copyWith({
    int? id,
    String? number,
    Color? color,
    String? infoNfc,
    String? namePlayer,
  }) {
    return MonopolyPlayerX._(
      id: id ?? this.id,
      number: number ?? this.number,
      color: color ?? this.color,
      namePlayer: namePlayer ?? this.namePlayer,
    );
  }
}
