import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/electronic_game_body.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/loading_screen.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_terminal.dart';

@RoutePage()
class ElectronicGameScreen extends StatefulWidget {
  const ElectronicGameScreen({super.key});

  @override
  State<ElectronicGameScreen> createState() => _ElectronicGameScreenState();
}

class _ElectronicGameScreenState extends State<ElectronicGameScreen> {
  bool showProperties = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectronicGameV2Bloc, ElectronicState>(
      builder: (context, blocState) {
        if (blocState.status == GameStatus.loading) {
          return const LoadingScreen();
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                getIt<ElectronicGameV2Bloc>()
                    .add(BackupGameEvent(appPaused: false, exitGame: false));
                getIt<RouterCubit>().state.push(HomeRoute());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.backup),
                onPressed: () => getIt<ElectronicGameV2Bloc>()
                    .add(BackupGameEvent(appPaused: false, exitGame: false)),
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  final end = await BankerAlerts.endGame();
                  if (end) {
                    getIt<RouterCubit>().state.push(EndGameElectronicV2(
                          players: blocState.players,
                          session: blocState.gameSession!,
                        ));
                  }
                },
              ),
            ],
          ),
          body: ElectronicGameBody(
            blocState: blocState,
            showProperties: showProperties,
            onToggleProperties: (value) {
              setState(() {
                showProperties = value;
              });
            },
          ),
          floatingActionButton: FloatingActionButton(
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
