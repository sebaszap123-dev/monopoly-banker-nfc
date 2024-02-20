import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_keyboard.dart';

@RoutePage()
class ElectronicGameScreen extends StatefulWidget {
  const ElectronicGameScreen({super.key});

  @override
  State<ElectronicGameScreen> createState() => _ElectronicGameScreenState();
}

class _ElectronicGameScreenState extends State<ElectronicGameScreen> {
  void getCurrentUser() async {
    final card = await BankerAlerts.readNfcDataCard();
    if (card != null) {
      getIt<MonopolyElectronicoBloc>().add(ChangeCurrentUser(card));
    }
  }

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonopolyElectronicoBloc, MonopolyElectronicoState>(
      builder: (context, state) {
        if (state.status == GameStatus.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade200,
              ),
            ),
          );
        }
        return Scaffold(
          body: state.status == GameStatus.transaction
              ? Center(
                  child: MonopolyCreditCard(
                    cardHeight: cardHeight,
                    color: state.currentPlayer!.color,
                    onTap: () {},
                    cardNumber: state.currentPlayer!.number,
                    displayName: state.currentPlayer!.namePlayer,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: getCurrentUser,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.circle,
                                  size: 200,
                                  color: Colors.blue.shade300,
                                )),
                            const Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                )),
                          ],
                        ))
                  ],
                ),
          bottomNavigationBar: const MonopolyTerminal(),
        );
      },
    );
  }
}

// class _GridviewTest extends StatelessWidget {
//   const _GridviewTest();

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         itemCount: 6,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 5,
//           childAspectRatio: 1.4,
//           crossAxisSpacing: 10,
//           mainAxisExtent: 120,
//         ),
//         itemBuilder: (context, index) {
//           return SizedBox(
//             height: 30,
//             child: Card(
//               clipBehavior: Clip.hardEdge,
//               color: Colors.blue.withOpacity(0.5),
//               child: const Stack(
//                 children: [Text('data')],
//               ),
//             ),
//           );
//         });
//   }
// }
