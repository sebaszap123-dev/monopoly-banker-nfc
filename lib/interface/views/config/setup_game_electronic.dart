import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';

class SetupGameElectronic extends StatefulWidget {
  const SetupGameElectronic({
    super.key,
  });

  @override
  State<SetupGameElectronic> createState() => _SetupGameElectronicState();
}

class _SetupGameElectronicState extends State<SetupGameElectronic> {
  Map<MonopolyCards, bool> players = {};

  void addPlayer() {
    showBottomSheet(
        context: context,
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Player',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ajusta el radio según lo necesites
                    ),
                  ),
                ),
                const Row(children: []),
              ],
            ),
          );
        });
  }

  Color? color;

  void addNewCard() async {
    final resp = await showDialog<MonopolyCards>(
        context: context,
        builder: (_) {
          return _NfcAddCards(
            currentCards: players.keys.map((key) => key).toList(),
          );
        });
    if (resp != null) {
      players[resp] = false;
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
          onPressed: addNewCard,
          child: const Icon(Icons.nfc_rounded),
        ),
        body: players.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 50),
                  ...players.entries.map((e) => MonopolyCreditCard(
                        cardHeight: cardHeight,
                        isSelected: e.value,
                        color: e.key.color,
                        cardNumber: e.key.number,
                        onTap: () {
                          players[e.key] = !e.value;
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
  final List<MonopolyCards> currentCards;
  @override
  State<_NfcAddCards> createState() => _NfcAddCardsState();
}

class _NfcAddCardsState extends State<_NfcAddCards> {
  bool isNfc = false;
  MonopolyCards? card;

  List<MonopolyCards> players = [];

  @override
  void initState() {
    super.initState();
    // Copiar la lista de currentCards para evitar modificar la lista original
    players = MonopolyCards.playerCards;

    // Eliminar las cartas existentes de la lista original
    players.removeWhere((player) => widget.currentCards
        .any((existingPlayer) => player.number == existingPlayer.number));
  }

  onNfc() async {
    setState(() {
      isNfc = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop<MonopolyCards>(card);
  }

  // TODO: ADD LISTENER SESION NFC

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
            height: 300,
            child: isNfc
                ? const NfcLoadingAnimation()
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
                                card = MonopolyCards.fromColor(value);
                                players.remove(card);
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
