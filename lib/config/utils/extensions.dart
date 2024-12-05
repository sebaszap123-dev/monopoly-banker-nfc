import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/model/property.dart';

extension IntExtension on int {
  String toHexString() {
    return '0x${toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
}

extension Uint8ListExtension on Uint8List {
  String toHexString({String empty = '-', String separator = ' '}) {
    return isEmpty ? empty : map((e) => e.toHexString()).join(separator);
  }
}

extension ColorExtension on String {
  Color toColor({double opacity = 1.0}) {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    if (hexString.contains('#')) {
      buffer.write(hexString.replaceFirst('#', ''));
    }
    int colorValue = int.parse(buffer.toString(), radix: 16);
    return Color(colorValue).withOpacity(opacity);
  }
}

extension HexExtension on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2)}';
  }
}

extension ColorValidator on String {
  bool isValidColor() {
    final hexRegex = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
    return hexRegex.hasMatch(this);
  }
}

extension CreditCardValidation on String {
  bool isValidCreditCardNumber() {
    // Eliminar espacios en blanco
    String cleanedNumber = replaceAll(' ', '');

    final number = int.tryParse(cleanedNumber);
    if (cleanedNumber.length != 16 && number == null) {
      return false;
    }
    return true;
  }
}

extension GetColorBasedOnType on PropertyType {
  Color get color {
    switch (this) {
      case PropertyType.coffee:
        return Colors.brown;
      case PropertyType.skyBlue:
        return '#87CEEB'.toColor();
      case PropertyType.magenta:
        return '#800080'.toColor();
      case PropertyType.orange:
        return Colors.orange;
      case PropertyType.red:
        return '#DC143C'.toColor();
      case PropertyType.yellow:
        return '#FFD700'.toColor();
      case PropertyType.green:
        return '#228B22'.toColor();
      case PropertyType.blue:
        return '#4169E1'.toColor();
      case PropertyType.services:
        return Colors.white;
      case PropertyType.ferro:
        return Colors.white;
    }
  }
}
