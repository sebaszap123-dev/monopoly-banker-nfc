// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/game_appbar.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/loading_screen.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/properties_list_screen.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/transaction_screen.dart';
import 'package:monopoly_banker/interface/widgets/animated_icon_button.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_terminal.dart';

@RoutePage()
class ElectronicGameScreen extends StatefulWidget {
  const ElectronicGameScreen({super.key});

  @override
  State<ElectronicGameScreen> createState() => _ElectronicGameScreenState();
}

class _ElectronicGameScreenState extends State<ElectronicGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showProperties = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectronicGameV2Bloc, ElectronicState>(
      builder: (context, blocState) {
        if (blocState.status == GameStatus.loading) {
          return const LoadingScreen();
        }

        return Scaffold(
          appBar: GameAppBar(
            onBackupPressed: () => getIt<ElectronicGameV2Bloc>()
                .add(BackupGameEvent(appPaused: false)),
            onEndGamePressed: () async {
              final end = await BankerAlerts.endGame();
              if (end) {
                getIt<RouterCubit>().state.push(EndGameElectronicV2(
                    players: blocState.players,
                    session: blocState.gameSession!));
              }
            },
          ),
          body: blocState.status == GameStatus.transaction
              ? TransactionScreen(
                  currentPlayer: blocState.currentPlayer!,
                  isTransactionInProgress:
                      blocState.status == GameStatus.transaction,
                  transactionMessage: blocState.messageTransaction,
                  controller: _controller,
                  animation: _animation,
                  maxWidth: MediaQuery.of(context).size.width,
                  gameTransaction: blocState.gameTransaction,
                )
              : showProperties
                  ? PropertiesListScreen(
                      propertiesToSell: blocState.propertiesToSell,
                      onTap: () {
                        setState(() {
                          showProperties = !showProperties;
                        });
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedIconButton(
                          onPressed: () => getIt<ElectronicGameV2Bloc>()
                              .add(UpdatePlayerEvent()),
                          colorsPlayers: [
                            ...blocState.players.map((e) => e.card!.color)
                          ],
                        ),
                        MaterialButton(
                          onPressed: () =>
                              setState(() => showProperties = !showProperties),
                          child: Icon(Icons.house,
                              size: 50, color: Colors.lightBlue),
                        ),
                      ],
                    ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () => _showTerminal(context),
            child: const Icon(Icons.keyboard),
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
  }

  void _showTerminal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const MonopolyTerminal(),
    );
  }
}
