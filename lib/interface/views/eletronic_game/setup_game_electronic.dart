// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/banker_electronic_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/nfc_card_dialog.dart';

class ElectronicGameSetup extends StatefulWidget {
  const ElectronicGameSetup({
    super.key,
  });

  @override
  State<ElectronicGameSetup> createState() => _ElectronicGameSetupState();
}

class _ElectronicGameSetupState extends State<ElectronicGameSetup> {
  Map<MonopolyCard, bool> cards = {};
  List<MonopolyPlayerX> players = [];
  bool isLoading = true;
  final GameVersions gameVersion = GameVersions.electronic;
  _initCards() async {
    final resp =
        await getIt<BankerElectronicService>().getAllMonopolyCards(gameVersion);
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
        await getIt<BankerElectronicService>().deleteMonopolyCard(card);
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

  bool get _canPlay {
    return players.length >= 2;
  }

  Color? color;

  void addNewCard() async {
    final resp = await showDialog<MonopolyCard>(
        context: context,
        builder: (context) {
          return NfcAddCards(
            context: context,
            version: gameVersion,
            validPlay: _canPlay,
            startGame: startGame,
            currentCards: cards.keys.map((key) => key).toList(),
          );
        });
    if (resp != null) {
      final id = await getIt<BankerElectronicService>().addMonopolyCard(resp);
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
    print(players);
    // throw Exception('stop here');
    if (players.isEmpty || players.length < 2) {
      BankerAlerts.noPlayersSelected();
      return;
    }
    getIt<MonopolyElectronicBloc>().add(StartGameEvent(players));
    getIt<RouterCubit>().state.push(const ElectronicGameRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MonopolyElectronicBloc, MonopolyElectronicState,
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
                    onPressed: () => getIt<BankerElectronicService>()
                        .deleteAllPlayers(gameVersion),
                  ),
                )
              ],
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
