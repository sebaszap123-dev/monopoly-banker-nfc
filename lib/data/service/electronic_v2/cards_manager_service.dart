import 'package:monopoly_banker/config/utils/default_cards.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/database/electronic_preference_v2.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class CardsManagerService {
  static Future<List<MonopolyCardV2>> getRegisteredCards() async {
    final preferences = getIt<ElectronicPreferenceV2>();
    List<MonopolyCardV2> cards = [];

    // Mapeamos los colores a las funciones de verificación de preferencia
    final Map<String, Future<bool>> cardPreferences = {
      'Azul': preferences.checkBlueCard(),
      'Verde': preferences.checkGreenCard(),
      'Morado': preferences.checkPurpleCard(),
      'Rojo': preferences.checkRedCard(),
      'Amarillo': preferences.checkYellowCard(),
      'Azul cielo': preferences.checkSkyBlueCard(),
    };

    for (var color in cardPreferences.keys) {
      bool hasCard = await cardPreferences[color]!;
      if (hasCard) {
        MonopolyCardV2? card = createCardByColor(color);
        if (card != null) {
          cards.add(card);
        }
      }
    }

    return cards;
  }

  // Función para crear una carta MonopolyCardV2 a partir de un color
  static MonopolyCardV2? createCardByColor(String colorName) {
    if (defaultCards.containsKey(colorName)) {
      return MonopolyCardV2()
        ..number = defaultCards[colorName]!.keys.first
        ..colorHex = defaultCards[colorName]!.values.first.toHex()
        ..colorName = colorName;
    }
    return null; // Si no existe el color, retornamos null
  }

  static Future<void> addCard(MonopolyCardV2 card) async {
    await getIt<ElectronicPreferenceV2>().cardAdd(card.number);
  }

  static Future<bool> removeCard(MonopolyCardV2 card) async {
    return await getIt<ElectronicPreferenceV2>().cardRemove(card.number);
  }
}
