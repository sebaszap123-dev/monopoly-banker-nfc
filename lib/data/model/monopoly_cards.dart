import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/default_colors.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:nfc_manager/nfc_manager.dart';

enum NdefStatus { empty, format, card }

class MonopolyCard {
  final int id;
  final String number;
  final Color color;
  final String colorName;
  final GameVersions version;
  String? displayName;
  MonopolyCard._({
    this.id = 0,
    required this.color,
    required this.number,
    required this.colorName,
    required this.version,
    this.displayName,
  });

  // Método para crear un objeto MonopolyCard desde un mapa
  factory MonopolyCard.fromMap(Map<String, dynamic> map) {
    return MonopolyCard._(
      id: map['id'],
      number: map['number'],
      color: (map['color'] as String).toColor(),
      colorName: map['colorName'],
      version: GameVersions.values
          .firstWhere((version) => version.name == map['version']),
    );
  }

  // Método para convertir un objeto MonopolyCard a un mapa
  Map<String, dynamic> toSqlMap() {
    return {
      'number': number,
      'color': color.toHex(),
      'colorName': colorName,
      'version': version.name,
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
      version: GameVersions.electronic,
    );
  }

  static MonopolyCard fromColor(Color color, GameVersions version) {
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
      version: version,
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
    GameVersions? version,
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
      version: version ?? this.version,
    );
  }

  static List<MonopolyCard> get electronicPlayerCards {
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
      version: GameVersions.electronic,
    );
  }

  static NdefStatus isRawCard(NdefMessage? message, List<MonopolyCard> cards) {
    if (message == null) {
      return NdefStatus.empty;
    }
    NdefStatus status = NdefStatus.format;
    List<NdefStatus> statuses = [];
    for (var record in message.records) {
      final recordInfo = NdefRecordInfo.fromNdef(record);
      final isValid = recordInfo.text.isValidCreditCardNumber();

      if (recordInfo.text == 'Empty') {
        statuses.add(NdefStatus.empty);
      }

      if (isValid) {
        final index =
            cards.indexWhere((card) => card.number == recordInfo.text);
        if (index != -1) {
          status = NdefStatus.card;
          statuses.add(status);
        }
      }
    }
    if (statuses.isEmpty) {
      return NdefStatus.empty;
    }
    final hasCard = statuses.indexWhere((status) => status == NdefStatus.card);
    if (hasCard == -1) {
      return NdefStatus.empty;
    }
    return NdefStatus.card;
  }

  // HANDLE ERROS WITH ART SWEET ALERT AND GET_IT CONTEXT ROUTER
  static String _getNumber(NdefRecord record) {
    final numberCard = NdefRecordInfo.fromNdef(record).text;
    if (!numberCard.isValidCreditCardNumber()) {
      // TODO: HANDLE ERROR AND NOTIFY NO USER
      // throw ("It's not a valid credit card number.");
    }
    return numberCard;
  }

  static Color _getColor(NdefRecord record) {
    final colorText = NdefRecordInfo.fromNdef(record).text;
    if (!colorText.isValidColor()) throw Exception('no valid color $colorText');

    return colorText.toColor();
  }
}
