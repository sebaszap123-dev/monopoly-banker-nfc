import 'package:shared_preferences/shared_preferences.dart';
import 'package:monopoly_banker/config/utils/default_cards.dart'; // Asegúrate de importar el archivo

class ElectronicPreferenceV2 {
  // Obtain shared preferences.
  late SharedPreferences prefs;

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> cardAdd(String number) async {
    await prefs.setBool(number, true);
  }

  Future<void> cardRemove(String number) async {
    await prefs.setBool(number, false);
  }

  Future<bool> checkRedCard() async {
    final number = defaultCards['Rojo']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }

  Future<bool> checkPurpleCard() async {
    final number = defaultCards['Morado']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }

  Future<bool> checkSkyBlueCard() async {
    final number = defaultCards['Azul cielo']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }

  Future<bool> checkYellowCard() async {
    final number = defaultCards['Amarillo']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }

  Future<bool> checkBlueCard() async {
    final number = defaultCards['Azul']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }

  Future<bool> checkGreenCard() async {
    final number = defaultCards['Verde']!.keys.first;
    bool? storedNumber = prefs.getBool(number);

    if (storedNumber == null) {
      return false;
    }
    return storedNumber;
  }
}
