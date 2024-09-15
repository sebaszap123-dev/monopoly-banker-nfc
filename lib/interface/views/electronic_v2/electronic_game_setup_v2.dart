// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/service/electronic_v2/cards_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';

class ElectronicGameSetupV2 extends StatefulWidget {
  const ElectronicGameSetupV2({super.key});

  @override
  State<ElectronicGameSetupV2> createState() => _ElectronicGameSetupV2State();
}

class _ElectronicGameSetupV2State extends State<ElectronicGameSetupV2> {
  List<MonopolyCardV2> cards = [];
  List<MonopolyPlayer> players = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  Future<void> _initCards() async {
    cards = await CardsManagerService.getRegisteredCards();
    setState(() {
      isLoading = false;
    });
  }

  void deleteCard(MonopolyCardV2 card) async {
    // Implementar lógica para eliminar la carta
    setState(() {
      cards.remove(card);
    });
  }

  void onTapCard(MonopolyCardV2 card) async {
    // Implementar lógica para manejar el tap en la carta
  }

  void startGame() {
    if (players.isEmpty || players.length < 2) {
      // Mostrar alerta de error
      return;
    }
    // Iniciar el juego
    getIt<ElectronicGameV2>().add(StartGameEvent(players));
    getIt<RouterCubit>().state.push(const ElectronicGameRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose players')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cards.isNotEmpty
              ? ListView(
                  children: cards
                      .map((card) => MonopolyCreditCard(
                            // ... propiedades de MonopolyCreditCard
                            onTap: () => onTapCard(card), color: card.color,
                            cardNumber: card.number,
                          ))
                      .toList(),
                )
              : const Center(child: Text('No players registered')),
    );
  }
}
