import 'package:flutter/material.dart';

final Map<String, Map<String, Color>> defaultCards = {
  'Rojo': {
    '0001 1935 2011 7070': Colors.red.shade800,
  },
  'Morado': {
    '0002 1935 2011 7070': Colors.purpleAccent.shade700,
  },
  'Verde': {
    '0003 1935 2011 7070': Colors.green.shade500,
  },
  'Azul': {
    '0004 1935 2011 7070': Colors.blue.shade900,
  },
  'Azul cielo': {
    '0006 1935 2011 7070': Colors.blue.shade200,
  },
  'Amarillo': {
    '0005 1935 2011 7070': Colors.yellowAccent.shade700,
  },
};

class MonopolyCards {
  final int id;
  final String number;
  final Color color;
  final String colorName;

  MonopolyCards._({
    this.id = 0,
    required this.color,
    required this.number,
    required this.colorName,
  });

  factory MonopolyCards.cardForPlayer(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= defaultCards.length) {
      throw ArgumentError('Invalid player index');
    }

    final List<String> colorNames = defaultCards.keys.toList();
    final String colorName = colorNames[playerIndex];
    final Map<String, Color> playerDefaults = defaultCards[colorName]!;
    final String defaultNumber = playerDefaults.keys.first;
    final Color defaultColor = playerDefaults[defaultNumber]!;

    return MonopolyCards._(
      color: defaultColor,
      number: defaultNumber,
      colorName: colorName,
    );
  }

  static MonopolyCards fromColor(Color color) {
    // Buscar el nombre del color correspondiente al color recibido
    String? colorName;
    defaultCards.forEach((key, value) {
      if (value.values.first == color) {
        colorName = key;
      }
    });

    if (colorName == null) {
      throw ArgumentError('Invalid color');
    }

    // Obtener el número asociado al color
    String defaultNumber = '';
    defaultCards[colorName!]!.forEach((key, value) {
      if (value == color) {
        defaultNumber = key;
      }
    });

    return MonopolyCards._(
      color: color,
      number: defaultNumber,
      colorName: colorName!,
    );
  }

  MonopolyCards copyWith({
    int? id,
    String? number,
    Color? color,
  }) {
    // Buscar el nombre del color correspondiente al color recibido
    String? colorName;
    defaultCards.forEach((key, value) {
      if (value.values.first == (color ?? this.color)) {
        colorName = key;
      }
    });

    if (colorName == null) {
      throw ArgumentError('Invalid color');
    }

    return MonopolyCards._(
      id: id ?? this.id,
      color: color ?? this.color,
      number: number ?? this.number,
      colorName: colorName!,
    );
  }

  static List<MonopolyCards> get playerCards {
    return List.generate(6, (index) => MonopolyCards.cardForPlayer(index));
  }
}
