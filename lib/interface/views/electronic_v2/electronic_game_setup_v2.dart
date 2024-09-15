// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/service/electronic_v2/cards_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/nfc_add_card_v2.dart';

class ElectronicGameSetupV2 extends StatefulWidget {
  const ElectronicGameSetupV2({
    super.key,
  });

  @override
  State<ElectronicGameSetupV2> createState() => _ElectronicGameSetupState();
}

class _ElectronicGameSetupState extends State<ElectronicGameSetupV2> {
  Map<MonopolyCardV2, bool> cards = {};
  List<MonopolyPlayer> players = [];
  bool isLoading = true;
  final GameVersions gameVersion = GameVersions.electronicv2;
  _initCards() async {
    final resp = await CardsManagerService.getRegisteredCards();
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

  void deleteCard(MonopolyCardV2 card) async {
    throw UnimplementedError();
    // final resp = await getIt<BankerManagerService>().deleteMonopolyCard(card);
    // if (resp != 0) {
    //   cards.remove(card);
    // }
    // setState(() {});
  }

  void onTapCard(MapEntry<MonopolyCardV2, bool> entry) async {
    throw UnimplementedError();

    // final matchingPlayers = players
    //     .where((player) => player.card!.number == entry.key.number)
    //     .toList();
    // final action = matchingPlayers.isNotEmpty
    //     ? await BankerAlerts.showAddPlayerAlert(
    //         oldName: matchingPlayers[0].namePlayer)
    //     : await BankerAlerts.showAddPlayerAlert();

    // if (action.key == CardManagerStatus.cancel) return;

    // if (action.key == CardManagerStatus.delete) {
    //   deleteCard(entry.key);
    //   return;
    // }

    // final playerName = action.value;
    // if (playerName != null) {
    //   if (matchingPlayers.isNotEmpty) {
    //     final index = players.indexOf(matchingPlayers[0]);
    //     players[index] = matchingPlayers[0]..name = playerName;
    //   } else {
    //     players.add(MonopolyPlayer.fromCard(entry.key, playerName));
    //   }
    //   cards.remove(entry.key);
    //   final updatedCard = entry.key.copyWith(displayName: playerName);
    //   cards[updatedCard] = true;
    // } else {
    //   cards[entry.key] = !entry.value;
    // }

    // setState(() {});
  }

  bool get _maxPlayers {
    return cards.length == 6;
  }

  bool get _canPlay {
    return players.length >= 2;
  }

  void addNewCard() async {
    final resp = await showDialog<MonopolyCardV2>(
        context: context,
        builder: (context) {
          return NfcAddCardV2(
            context: context,
            version: gameVersion,
            validPlay: _canPlay,
            startGame: startGame,
            currentCards: cards.keys.map((key) => key).toList(),
          );
        });
    if (resp != null) {
      await CardsManagerService.addCard(resp);
      cards[resp] = false;
      setState(() {});
    }
  }

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  void startGame() {
    if (players.isEmpty || players.length < 2) {
      BankerAlerts.noPlayersSelected();
      return;
    }
    getIt<ElectronicGameV2Bloc>().add(StartGameEvent(players));
    BankerAlerts.unhandledError(
        error: "No implemented yet go to a game v2", myContext: context);
    getIt<RouterCubit>().state.push(const ElectronicGameRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ElectronicGameV2Bloc, ElectronicState, GameStatus>(
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
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'NFC-GAME',
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
