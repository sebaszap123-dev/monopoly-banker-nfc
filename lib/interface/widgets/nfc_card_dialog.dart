import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/banker_textstyle.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class NfcAddCards extends StatefulWidget {
  const NfcAddCards({
    required this.currentCards,
    required this.context,
    required this.version,
    this.validPlay = false,
    this.startGame,
  });
  final GameVersions version;
  final bool validPlay;
  final List<MonopolyCard> currentCards;
  final BuildContext context;
  final void Function()? startGame;
  @override
  State<NfcAddCards> createState() => _NfcAddCardsState();
}

class _NfcAddCardsState extends State<NfcAddCards> {
  bool isNfc = false;
  MonopolyCard? card;
  NdefStatus? status;
  String messageDialog = 'Select a card to be pair';
  List<MonopolyCard> cards = [];

  @override
  void initState() {
    super.initState();
    // Copiar la lista de currentCards para evitar modificar la lista original
    if (widget.validPlay) {
      messageDialog = 'You can play or pair a new card';
    }
    cards = MonopolyCard.electronicPlayerCards;

    // Eliminar las cartas existentes de la lista original
    cards.removeWhere((player) => widget.currentCards
        .any((existingPlayer) => player.number == existingPlayer.number));
  }

  Future<bool> canOverride(NfcTag tag) async {
    if (tag.data.containsKey('ndef')) {
      final ndef = Ndef.from(tag);
      if (ndef != null) {
        final cachedMessage = ndef.cachedMessage;

        status = MonopolyCard.isRawCard(cachedMessage, widget.currentCards);

        if (status == NdefStatus.format) {
          final ndefFormat = NdefFormatable.from(tag);
          if (ndefFormat != null) {
            final test = WellknownTextRecord(languageCode: 'es', text: 'Empty');
            await ndefFormat.format(NdefMessage([test.toNdef()]));
          }
          return true;
        }

        if (status == NdefStatus.card) {
          // BankerAlerts.alreadyRegisteredCard();
          return true;
        }

        return NdefStatus.empty == status;
      }
    }
    return true;
  }

  Future<void> writeToTag(NfcTag tag) async {
    final hasData = await canOverride(tag);

    if (!Platform.isAndroid) return;

    if (card == null && !hasData && status == null) return;

    final tech = Ndef.from(tag);

    if (status == NdefStatus.card) {
      if (tech is Ndef) {
        final ndef = await tech.read();
        card = MonopolyCard.fromNdefMessage(ndef);
        Navigator.of(context).pop(card);
      }
      return;
    }

    if (tech is Ndef) {
      if (!tech.isWritable) {
        BankerAlerts.unhandledError(error: 'Tag is not ndef writable.');
        return;
      }

      final test = WellknownTextRecord(languageCode: 'es', text: card!.number);
      final color =
          WellknownTextRecord(languageCode: 'es', text: card!.color.toHex());

      try {
        final message = NdefMessage([test.toNdef(), color.toNdef()]);
        await tech.write(message);
      } on PlatformException catch (_) {
        BankerAlerts.unhandledError(
          error: 'Please format your nfc tag with an app',
          myContext: widget.context,
        );
      }

      await getIt<NfcManager>().stopSession();
      setState(() {
        isNfc = false;
      });

      Navigator.of(context).pop(card);
      return;
    }

    BankerAlerts.unhandledError(error: "It's a NDEF card valid");
  }

  onNfc() async {
    if (card == null) {
      BankerAlerts.noCardSelected();
      return;
    }
    ;
    setState(() {
      isNfc = true;
    });
    final resp = await getIt<NfcManager>().isAvailable();
    if (resp) {
      getIt<NfcManager>()
          .startSession(onDiscovered: (NfcTag tag) async => writeToTag(tag));
      return;
    }
    BankerAlerts.unhandledError(error: 'NFC disabled');
  }

  @override
  void dispose() async {
    super.dispose();
    await getIt<NfcManager>().stopSession();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: 300,
          child: isNfc
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NfcLoadingAnimation(
                      color: card?.color,
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        messageDialog,
                        style: BankerTextStyle.subtitle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Color>(
                              borderRadius: BorderRadius.circular(12),
                              icon: Icon(
                                Icons.color_lens,
                                color: Colors.blue.shade700,
                              ),
                              value: card?.color,
                              items: [
                                ...cards.map(
                                  (e) => DropdownMenuItem<Color>(
                                    value: e.color,
                                    child: Text(
                                      e.colorName,
                                      style: TextStyle(
                                          color: Colors.blue.shade900),
                                    ),
                                  ),
                                )
                              ],
                              onChanged: (Color? value) {
                                if (value != null) {
                                  setState(() {
                                    card = MonopolyCard.fromColor(
                                        value, widget.version);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: onNfc,
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Pair',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (widget.validPlay)
                            TextButton(
                              onPressed: widget.startGame,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue.shade100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Play',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
