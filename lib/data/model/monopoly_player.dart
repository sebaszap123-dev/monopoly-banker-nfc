import 'dart:ui';

import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MonopolyPlayer {
  final int id;
  final String number;
  final Color color;
  final String infoNfc;
  final String? namePlayer;
  MonopolyPlayer._(
      {this.id = 0,
      this.namePlayer,
      required this.number,
      required this.color,
      required this.infoNfc});

  static MonopolyPlayer fromNdefMessage(NdefMessage message) {
    final record0 = message.records[0];
    final record1 = message.records[1];
    final number = _getNumber(record0);
    final color = _getColor(record1);
    final nfcInfo = _getInfo(record0);
    return MonopolyPlayer._(color: color, infoNfc: nfcInfo, number: number);
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

  static String _getInfo(NdefRecord record) {
    return NdefRecordInfo.fromNdef(record).nfcInfo;
  }

  static Color _getColor(NdefRecord record) {
    final colorText = NdefRecordInfo.fromNdef(record).text;
    print(colorText);
    if (!colorText.isValidColor()) print(colorText);

    return colorText.toColor();
  }

  MonopolyPlayer copyWith({
    int? id,
    String? number,
    Color? color,
    String? infoNfc,
    String? namePlayer,
  }) {
    return MonopolyPlayer._(
      id: id ?? this.id,
      number: number ?? this.number,
      color: color ?? this.color,
      infoNfc: infoNfc ?? this.infoNfc,
      namePlayer: namePlayer ?? this.namePlayer,
    );
  }
}
