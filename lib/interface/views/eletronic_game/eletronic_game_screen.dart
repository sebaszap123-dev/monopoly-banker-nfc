import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/animated_icon_button.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_keyboard.dart';

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

  void getCurrentUser() =>
      getIt<MonopolyElectronicBloc>().add(UpdatePlayerEvent());

  void finishTurn() =>
      getIt<MonopolyElectronicBloc>().add(FinishTurnPlayerEvent());

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  final TextStyle statuscards = GoogleFonts.robotoMono(
    color: Colors.white,
    fontSize: 22,
  );

  final borderRadius = const BorderRadius.all(Radius.circular(12));

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
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    getIt<MonopolyElectronicBloc>().add(BackupGame(appPaused: true));
    super.dispose();
  }

  double get _maxWidth {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonopolyElectronicBloc, MonopolyElectronicState>(
      builder: (context, blocState) {
        if (blocState.status == GameStatus.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade200,
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => getIt<MonopolyElectronicBloc>()
                  .add(BackupGame(appPaused: false)),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final end = await BankerAlerts.endGame();
                    if (end) {
                      getIt<RouterCubit>()
                          .state
                          .push(EndGameMonopolyX(players: blocState.players));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Colors.red,
                    ),
                    child: const Text(
                      'End game',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
          body: blocState.status == GameStatus.transaction
              ? Center(
                  child: Column(
                    children: [
                      MonopolyCreditCard(
                        cardHeight: cardHeight,
                        color: blocState.currentPlayer!.color,
                        onTap: finishTurn,
                        cardNumber: blocState.currentPlayer!.number,
                        displayName: blocState.currentPlayer!.namePlayer,
                        transactions:
                            blocState.status == GameStatus.transaction,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        constraints: BoxConstraints(
                            maxWidth: _maxWidth, minWidth: _maxWidth),
                        width: 50,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: borderRadius),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Money:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(width: 10),
                                    Text(
                                        blocState.currentPlayer!.money
                                            .toStringAsFixed(2),
                                        style: statuscards),
                                    const SizedBox(width: 2.5),
                                    Text('M',
                                        style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(flex: 1),
                            BlocSelector<MonopolyElectronicBloc,
                                MonopolyElectronicState, GameTransaction>(
                              selector: (playerTransactionState) {
                                return playerTransactionState.gameTransaction;
                              },
                              builder: (context, state) {
                                if (state != GameTransaction.none) {
                                  _controller.reset();
                                  _controller.forward();
                                  return Flexible(
                                    flex: 6,
                                    child: FadeTransition(
                                      opacity: _animation,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: switch (
                                              blocState.gameTransaction) {
                                            GameTransaction.none => null,
                                            GameTransaction.salida =>
                                              Colors.green,
                                            GameTransaction.add => Colors.green,
                                            GameTransaction.substract =>
                                              Colors.red,
                                            GameTransaction.paying =>
                                              Colors.amberAccent,
                                          },
                                          borderRadius: borderRadius,
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Text(
                                            blocState.messageTransaction,
                                            style: statuscards),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedIconButton(
                      onPressed: getCurrentUser,
                      colorsPlayers: [...blocState.players.map((e) => e.color)],
                    )
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
