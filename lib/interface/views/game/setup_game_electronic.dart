// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

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
    if (resp.isNotEmpty) {
      for (var card in resp) {
        cards[card] = false;
      }
    }
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

  void onTapCard(MapEntry<MonopolyCard, bool> entry) async {
    final matchingPlayers =
        players.where((player) => player.number == entry.key.number).toList();
    final action = matchingPlayers.isNotEmpty
        ? await BankerAlerts.showAddPlayerAlert(
            oldName: matchingPlayers[0].namePlayer)
        : await BankerAlerts.showAddPlayerAlert();

    if (action.key == CardManagerStatus.cancel) return;

    if (action.key == CardManagerStatus.delete) {
      deleteCard(entry.key);
      return;
    }

    final playerName = action.value;
    if (playerName != null) {
      if (matchingPlayers.isNotEmpty) {
        final index = players.indexOf(matchingPlayers[0]);
        players[index] = matchingPlayers[0].copyWith(namePlayer: playerName);
      } else {
        players.add(MonopolyPlayerX.fromCard(entry.key, playerName));
      }
      cards.remove(entry.key);
      final updatedCard = entry.key.copyWith(displayName: playerName);
      cards[updatedCard] = true;
    } else {
      cards[entry.key] = !entry.value;
    }

    setState(() {});
  }

  bool get _maxPlayers {
    return cards.length == 6;
  }

  Color? color;

  void addNewCard() async {
    final resp = await showDialog<MonopolyCard>(
        context: context,
        builder: (context) {
          return _NfcAddCards(
            context: context,
            currentCards: cards.keys.map((key) => key).toList(),
          );
        });
    if (resp != null) {
      final id = await getIt<MonopolyElectronicService>().addMonopolyCard(resp);
      if (id == -1) {
        return;
      }
      final card = resp.copyWith(id: id);
      cards[card] = false;
      setState(() {});
    }
  }

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  void startGame() {
    getIt<MonopolyElectronicoBloc>().add(StartGameEvent(players));
    getIt<RouterCubit>().state.push(const ElectronicGameRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MonopolyElectronicoBloc, MonopolyElectronicoState,
        GameStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, state) {
        if (state == GameStatus.loading) {
          return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade200));
        }
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              title: const Text('Choose players'),
              backgroundColor: Colors.grey.shade100,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(
                      // Icons.restore,
                      Icons.cleaning_services_rounded,
                      color: Colors.blue.shade200,
                      size: 30,
                    ),
                    onPressed:
                        getIt<MonopolyElectronicService>().deleteAllPlayers,
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: !_maxPlayers ? addNewCard : startGame,
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
                            displayName: e.key.displayName,
                            onTap: () => onTapCard(e),
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
      },
    );
  }
}

class _NfcAddCards extends StatefulWidget {
  const _NfcAddCards({
    required this.currentCards,
    required this.context,
  });
  final List<MonopolyCard> currentCards;
  final BuildContext context;
  @override
  State<_NfcAddCards> createState() => _NfcAddCardsState();
}

class _NfcAddCardsState extends State<_NfcAddCards> {
  bool isNfc = false;
  MonopolyCard? card;
  NdefStatus? status;

  List<MonopolyCard> cards = [];

  @override
  void initState() {
    super.initState();
    // Copiar la lista de currentCards para evitar modificar la lista original
    cards = MonopolyCard.playerCards;

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
        print(status);

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
    if (card == null) return;
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
                        const Text('Select a color for the card'),
                        DropdownButton<Color>(
                          value: card?.color,
                          items: [
                            ...cards.map(
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
