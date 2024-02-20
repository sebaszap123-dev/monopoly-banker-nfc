// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:nfc_manager/nfc_manager.dart';

enum NdefStatus { empty, format, card }

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

class MonopolyCard {
  final int id;
  final String number;
  final Color color;
  final String colorName;
  String? displayName;
  MonopolyCard._({
    this.id = 0,
    required this.color,
    required this.number,
    required this.colorName,
    this.displayName,
  });

  // Método para crear un objeto MonopolyCard desde un mapa
  factory MonopolyCard.fromMap(Map<String, dynamic> map) {
    return MonopolyCard._(
      id: map['id'],
      number: map['number'],
      color: (map['color'] as String).toColor(),
      colorName: map['colorName'],
    );
  }

  // Método para convertir un objeto MonopolyCard a un mapa
  Map<String, dynamic> toSqlMap() {
    return {
      'number': number,
      'color': color.toHex(),
      'colorName': colorName,
    };
  }

  factory MonopolyCard.cardForPlayer(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= defaultCards.length) {
      throw ArgumentError('Invalid player index');
    }

    final List<String> colorNames = defaultCards.keys.toList();
    final String colorName = colorNames[playerIndex];
    final Map<String, Color> playerDefaults = defaultCards[colorName]!;
    final String defaultNumber = playerDefaults.keys.first;
    final Color defaultColor = playerDefaults[defaultNumber]!;

    return MonopolyCard._(
      color: defaultColor,
      number: defaultNumber,
      colorName: colorName,
    );
  }

  static MonopolyCard fromColor(Color color) {
    // Buscar el nombre del color correspondiente al color recibido
    final colorName = _nameFromColor(color);

    // Obtener el número asociado al color
    String defaultNumber = '';
    defaultCards[colorName]!.forEach((key, value) {
      if (value == color) {
        defaultNumber = key;
      }
    });

    return MonopolyCard._(
      color: color,
      number: defaultNumber,
      colorName: colorName,
    );
  }

  static String _nameFromColor(Color color) {
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

    return colorName ?? color.toHex();
  }

  MonopolyCard copyWith({
    int? id,
    String? number,
    Color? color,
    String? displayName,
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

    return MonopolyCard._(
      id: id ?? this.id,
      color: color ?? this.color,
      number: number ?? this.number,
      colorName: colorName!,
      displayName: displayName ?? this.displayName,
    );
  }

  static List<MonopolyCard> get playerCards {
    return List.generate(6, (index) => MonopolyCard.cardForPlayer(index));
  }

  /// Read card in game
  static MonopolyCard fromNdefMessage(NdefMessage message) {
    final record0 = message.records[0];
    final record1 = message.records[1];
    final number = _getNumber(record0);
    final color = _getColor(record1);
    final colorName = _nameFromColor(color);
    return MonopolyCard._(
      color: color,
      number: number,
      colorName: colorName,
    );
  }

  static NdefStatus isRawCard(NdefMessage? message, List<MonopolyCard> cards) {
    if (message == null) {
      return NdefStatus.empty;
    }
    NdefStatus status = NdefStatus.format;
    for (var record in message.records) {
      final recordInfo = NdefRecordInfo.fromNdef(record);
      final isValid = recordInfo.text.isValidCreditCardNumber();

      if (recordInfo.text == 'Empty') {
        return NdefStatus.empty;
      }

      if (isValid) {
        final index =
            cards.indexWhere((card) => card.number == recordInfo.text);
        if (index != -1) {
          status = NdefStatus.card;
        }
      }
    }

    return status;
  }

  // HANDLE ERROS WITH ART SWEET ALERT AND GET_IT CONTEXT ROUTER
  static String _getNumber(NdefRecord record) {
    final numberCard = NdefRecordInfo.fromNdef(record).text;
    if (!numberCard.isValidCreditCardNumber()) {
      print(numberCard);
      // throw ("It's not a valid credit card number.");
    }
    return numberCard;
  }

  static Color _getColor(NdefRecord record) {
    final colorText = NdefRecordInfo.fromNdef(record).text;
    print(colorText);
    if (!colorText.isValidColor()) print(colorText);

    return colorText.toColor();
  }
}
