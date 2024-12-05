import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/session.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';

@RoutePage()
class EndGameElectronicV2 extends StatefulWidget {
  const EndGameElectronicV2(
      {super.key, required this.players, required this.session});
  final List<MonopolyPlayer> players;
  final GameSessions session;
  @override
  State<EndGameElectronicV2> createState() => _EndGameElectronicV2State();
}

class _EndGameElectronicV2State extends State<EndGameElectronicV2> {
  bool sessionDeleted = false;

  @override
  void initState() {
    widget.players.sort((a, b) => b.money.compareTo(a.money));
    super.initState();
  }

  void goHome() async {
    await getIt<ElectronicDatabaseV2>().deleteGameSession(widget.session.id);
    getIt<ElectronicGameV2Bloc>().add(EndGameEvent());
    getIt<RouterCubit>().goHome();
  }

  @override
  void dispose() {
    super.dispose();
    if (!sessionDeleted) {
      getIt<ElectronicDatabaseV2>().deleteGameSession(widget.session.id);
      getIt<ElectronicGameV2Bloc>().add(EndGameEvent());
      getIt<RouterCubit>().goHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de partida'),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: goHome,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ...widget.players.map((e) => Column(
                children: [
                  MonopolyCreditCard(
                    color: e.card!.color,
                    onTap: () {},
                    cardNumber: e.card!.number,
                    displayName: e.namePlayer,
                    isSelected: false,
                    transactions: false,
                  ),
                  Text('money: ${e.money}'),
                ],
              )),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
