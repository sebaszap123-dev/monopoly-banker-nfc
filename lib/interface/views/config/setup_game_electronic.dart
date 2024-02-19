import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:nfc_manager/nfc_manager.dart';

class EletronicGameSetup extends StatefulWidget {
  const EletronicGameSetup({
    super.key,
  });

  @override
  State<EletronicGameSetup> createState() => _EletronicGameSetupState();
}

class _EletronicGameSetupState extends State<EletronicGameSetup> {
  Map<MonopolyCard, bool> cards = {};
  List<MonopolyPlayerX> players = [];
  bool isLoading = true;
  _initCards() async {
    final resp = await getIt<MonopolyElectronicService>().getAllMonopolyCards();
    // getIt<MonopolyElectronicService>().deleteMonopolyCard(resp[1]);
    if (resp.isNotEmpty) {
      for (var card in resp) {
        cards[card] = false;
      }
    }
    print(cards.length);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  void deleteCard(MonopolyCard card) async {
    final resp =
        await getIt<MonopolyElectronicService>().deleteMonopolyCard(card);
    if (resp != 0) {
      cards.remove(card);
    }
    setState(() {});
  }

  void addPlayer(MonopolyCard card) async {
    final playerName = await BankerAlerts.showAddPlayerAlert();
    if (playerName != null) {
      players.add(MonopolyPlayerX.fromCard(card, playerName));
    }
  }

  bool get _maxPlayers {
    return cards.length == 6;
  }

  Color? color;

  void addNewCard() async {
    final resp = await showDialog<MonopolyCard>(
        context: context,
        builder: (_) {
          return _NfcAddCards(
            currentCards: cards.keys.map((key) => key).toList(),
          );
        });
    if (resp != null) {
      final id = await getIt<MonopolyElectronicService>().addMonopolyCard(resp);
      final card = resp.copyWith(id: id);
      cards[card] = false;
      setState(() {});
    }
  }

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Choose cards for each player'),
          backgroundColor: Colors.grey.shade100,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: !_maxPlayers ? addNewCard : () {},
          child: Icon(
            !_maxPlayers ? Icons.nfc_rounded : Icons.play_circle_rounded,
          ),
        ),
        body: cards.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 50),
                  ...cards.entries.map((e) => MonopolyCreditCard(
                        cardHeight: cardHeight,
                        isSelected: e.value,
                        color: e.key.color,
                        cardNumber: e.key.number,
                        onTap: () {
                          // deleteCard(e.key);
                          cards[e.key] = !e.value;
                          setState(() {});
                        },
                      ))
                ],
              )
            : const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No players register',
                          style: TextStyle(fontSize: 40)),
                      Icon(Icons.gamepad_rounded, size: 180),
                    ]),
              ));
  }
}

class _NfcAddCards extends StatefulWidget {
  const _NfcAddCards({
    required this.currentCards,
  });
  final List<MonopolyCard> currentCards;
  @override
  State<_NfcAddCards> createState() => _NfcAddCardsState();
}

class _NfcAddCardsState extends State<_NfcAddCards> {
  bool isNfc = false;
  MonopolyCard? card;

  List<MonopolyCard> players = [];

  @override
  void initState() {
    super.initState();
    // Copiar la lista de currentCards para evitar modificar la lista original
    players = MonopolyCard.playerCards;

    // Eliminar las cartas existentes de la lista original
    players.removeWhere((player) => widget.currentCards
        .any((existingPlayer) => player.number == existingPlayer.number));
  }

  bool comprobateData(NfcTag tag) {
    if (tag.data.containsKey('ndef')) {
      // Identificar el tipo de tecnología NFC
      final ndef = Ndef.from(tag);
      if (ndef != null) {
        final cachedMessage = ndef.cachedMessage;
        if (cachedMessage != null) {
          final resp = MonopolyCard.fromNdefMessage(cachedMessage);
          final hasData = widget.currentCards
              .where(
                (element) =>
                    element.number == resp.number &&
                    element.color == resp.color,
              )
              .toList();
          return hasData.isNotEmpty;
        }
      }
    }
    return false;
  }

  Future<void> writeToTag(NfcTag tag) async {
    final hasData = comprobateData(tag);
    if (!Platform.isAndroid) {
      return;
    }

    if (hasData) {
      BankerAlerts.alreadyRegisteredCard(context);
      return;
    }
    if (card == null) return;

    final tech = Ndef.from(tag);
    // final awa = MifareUltralight.from(tag);
    if (tech is Ndef) {
      if (!tech.isWritable) throw ('Tag is not ndef writable.');
      final test = WellknownTextRecord(languageCode: 'es', text: card!.number);
      final color =
          WellknownTextRecord(languageCode: 'es', text: card!.color.toHex());
      try {
        final message = NdefMessage([test.toNdef(), color.toNdef()]);
        await tech.write(message);
      } catch (e) {
        throw ('$e');
      }
      await NfcManager.instance.stopSession();
      setState(() {
        isNfc = false;
      });
      Navigator.of(context).pop(card);
      // return '[Ndef - Write] is completed.';
    }
    print('no ndef??');
  }

  onNfc() async {
    if (card == null) return;
    setState(() {
      isNfc = true;
    });
    NfcManager.instance
        .startSession(onDiscovered: (NfcTag tag) async => writeToTag(tag));
  }

  // TODO: ADD LISTENER SESION NFC

  @override
  void dispose() async {
    super.dispose();
    await NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
            height: 300,
            child: isNfc
                ? NfcLoadingAnimation(
                    color: card?.color,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Select a color for the card'),
                        DropdownButton<Color>(
                          value: card?.color,
                          items: [
                            ...players.map(
                              (e) => DropdownMenuItem<Color>(
                                value: e.color,
                                child: Text(
                                  e.colorName,
                                ),
                              ),
                            )
                          ],
                          onChanged: (Color? value) {
                            if (value != null) {
                              setState(() {
                                card = MonopolyCard.fromColor(value);
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: onNfc,
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.blue.shade500),
                            ))
                      ],
                    ),
                  )));
  }
}
