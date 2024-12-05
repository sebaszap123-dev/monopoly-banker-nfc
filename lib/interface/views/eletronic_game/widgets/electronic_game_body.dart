import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/deals_screen.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/properties_list_screen.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/transaction_screen.dart';
import 'package:monopoly_banker/interface/widgets/animated_icon_button.dart';

class ElectronicGameBody extends StatelessWidget {
  final ElectronicState blocState;
  final bool showProperties;
  final ValueChanged<bool> onToggleProperties;

  const ElectronicGameBody({
    Key? key,
    required this.blocState,
    required this.showProperties,
    required this.onToggleProperties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blocState.status == GameStatus.transaction) {
      if (blocState.gameTransaction == GameTransaction.transfer_properties) {
        return DealsScreen();
      } else {
        return TransactionScreen(
          currentPlayer: blocState.currentPlayer!,
          isTransactionInProgress: true,
          transactionMessage: blocState.messageTransaction,
          maxWidth: MediaQuery.of(context).size.width,
          gameTransaction: blocState.gameTransaction,
        );
      }
    } else if (showProperties) {
      return PropertiesListScreen(
        propertiesToSell: blocState.propertiesToSell,
        onTap: () => onToggleProperties(!showProperties),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedIconButton(
            onPressed: () =>
                getIt<ElectronicGameV2Bloc>().add(UpdatePlayerEvent()),
            colorsPlayers: blocState.players.map((e) => e.card!.color).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () => onToggleProperties(!showProperties),
                child:
                    const Icon(Icons.house, size: 50, color: Colors.lightBlue),
              ),
              MaterialButton(
                onPressed: () =>
                    getIt<ElectronicGameV2Bloc>().add(ChangeProperties()),
                child: const Icon(Icons.change_circle,
                    size: 50, color: Colors.orange),
              ),
            ],
          ),
        ],
      );
    }
  }
}
