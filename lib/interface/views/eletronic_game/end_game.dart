import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';

@RoutePage()
class EndGameMonopolyX extends StatefulWidget {
  const EndGameMonopolyX(
      {super.key, required this.players, required this.sessionId});
  final List<MonopolyPlayerX> players;
  final int sessionId;
  @override
  State<EndGameMonopolyX> createState() => _EndGameMonopolyXState();
}

class _EndGameMonopolyXState extends State<EndGameMonopolyX> {
  bool sessionDeleted = false;

  @override
  void initState() {
    widget.players.sort((a, b) => b.money.compareTo(a.money));
    super.initState();
  }

  void goHome() async {
    sessionDeleted =
        await getIt<BankerManagerService>().deleteSession(widget.sessionId);
    getIt<MonopolyElectronicBloc>().add(EndGameEvent());
    getIt<RouterCubit>().goHome();
  }

  @override
  void dispose() {
    super.dispose();
    if (!sessionDeleted) {
      getIt<BankerManagerService>().deleteSession(widget.sessionId);
      getIt<MonopolyElectronicBloc>().add(EndGameEvent());
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
                    color: e.color,
                    onTap: () {},
                    cardNumber: e.number,
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
