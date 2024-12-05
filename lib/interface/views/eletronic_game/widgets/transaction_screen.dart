import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/player.dart';
import 'package:monopoly_banker/data/model/property.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/property_card.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';

class TransactionScreen extends StatelessWidget {
  final MonopolyPlayer currentPlayer;
  final bool isTransactionInProgress;
  final String transactionMessage;
  final double maxWidth;
  final GameTransaction gameTransaction;
  TransactionScreen({
    super.key,
    required this.currentPlayer,
    required this.isTransactionInProgress,
    required this.transactionMessage,
    required this.maxWidth,
    required this.gameTransaction,
  }) {
    print(isTransactionInProgress);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle statusCards = GoogleFonts.robotoMono(
      color: Colors.white,
      fontSize: 22,
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MonopolyCreditCard(
              color: currentPlayer.card!.color,
              onTap: () => finishTurn(),
              cardNumber: currentPlayer.card!.number,
              displayName: currentPlayer.namePlayer,
              transactions: isTransactionInProgress,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              constraints:
                  BoxConstraints(maxWidth: maxWidth, minWidth: maxWidth),
              width: double.infinity, // Ajusta el ancho al máximo disponible
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Money:',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Text(currentPlayer.money.toString(),
                            style: statusCards),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  if (isTransactionInProgress) ...[
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: getTransactionColor(gameTransaction),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(transactionMessage, style: statusCards),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...properties(currentPlayer).map(
              (element) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: PropertyCard(
                  property: element,
                  isOwnedByUser: true,
                  onMortgage: () => getIt<ElectronicGameV2Bloc>()
                      .add(MortgageProperty(element)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Property> properties(MonopolyPlayer player) {
    return [...player.houses, ...player.services, ...player.railways];
  }

  void finishTurn() =>
      getIt<ElectronicGameV2Bloc>().add(FinishTurnPlayerEvent());

  Color? getTransactionColor(GameTransaction transaction) {
    switch (transaction) {
      case GameTransaction.exit:
      case GameTransaction.add:
      case GameTransaction.buy_property:
      case GameTransaction.transfer_properties:
        return Colors.green;
      case GameTransaction.subtract:
        return Colors.red;
      case GameTransaction.paying:
        return Colors.amberAccent;
      default:
        return null;
    }
  }
}
