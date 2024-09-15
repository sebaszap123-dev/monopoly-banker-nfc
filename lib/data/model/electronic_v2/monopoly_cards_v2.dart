import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/default_cards.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'monopoly_cards_v2.g.dart';

enum NdefStatus { empty, format, card }

@embedded
class MonopolyCardV2 {
  late String number;
  late String colorHex;
  late String colorName;
  String? displayName;

  MonopolyCardV2();

  @ignore
  Color get color {
    return colorHex.toColor();
  }

  factory MonopolyCardV2.cardForPlayer(int playerIndex) {
    if (playerIndex < 0 || playerIndex >= defaultCards.length) {
      throw ArgumentError('Invalid player index');
    }

    final List<String> colorNames = defaultCards.keys.toList();
    final String colorName = colorNames[playerIndex];
    final Map<String, Color> playerDefaults = defaultCards[colorName]!;
    final String defaultNumber = playerDefaults.keys.first;
    final Color defaultColor = playerDefaults[defaultNumber]!;

    return MonopolyCardV2()
      ..colorHex = defaultColor.toHex()
      ..number = defaultNumber
      ..colorName = colorName;
  }

  static MonopolyCardV2 fromColor(Color color, GameVersions version) {
    // Buscar el nombre del color correspondiente al color recibido
    final colorName = _nameFromColor(color);

    // Obtener el número asociado al color
    String defaultNumber = '';
    defaultCards[colorName]!.forEach((key, value) {
      if (value == color) {
        defaultNumber = key;
      }
    });

    return MonopolyCardV2()
      ..colorHex = color.toHex()
      ..number = defaultNumber
      ..colorName = colorName;
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

  /// Read card in game
  static MonopolyCardV2 fromNdefMessage(NdefMessage message) {
    final record0 = message.records[0];
    final record1 = message.records[1];
    final number = _getNumber(record0);
    final color = _getColor(record1);
    final colorName = _nameFromColor(color);
    return MonopolyCardV2()
      ..colorHex = color.toHex()
      ..number = number
      ..colorName = colorName;
  }

  static NdefStatus isRawCard(NdefMessage? message, MonopolyCardV2 card,
      List<MonopolyCardV2> currentCards) {
    if (message == null) {
      return NdefStatus.empty;
    }

    int matchesRecord = 0;

    for (var record in message.records) {
      final recordInfo = NdefRecordInfo.fromNdef(record);

      if (recordInfo.text == 'Empty') {
        return NdefStatus.empty;
      }

      if (recordInfo.text.isValidCreditCardNumber()) {
        bool exist = true;
        try {
          currentCards.firstWhere((card) => card.number == card.number);
        } on StateError catch (_) {
          exist = false;
        }
        if (exist) {
          return NdefStatus.card;
        }
        final match =
            card.number == recordInfo.text || card.color == recordInfo.text;

        if (match) {
          matchesRecord++;
          if (matchesRecord >= 2) {
            return NdefStatus.card;
          }
        }
      }
    }

    return NdefStatus.empty;
  }

  // HANDLE ERROS WITH ART SWEET ALERT AND GET_IT CONTEXT ROUTER
  static String _getNumber(NdefRecord record) {
    final numberCard = NdefRecordInfo.fromNdef(record).text;
    if (!numberCard.isValidCreditCardNumber()) {
      BankerAlerts.invalidCardNumber();
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
