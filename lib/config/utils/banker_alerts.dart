import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:monopoly_banker/interface/widgets/pay_to_button.dart';
import 'package:nfc_manager/nfc_manager.dart';

enum CardManagerStatus { delete, cancel, name }

abstract class BankerAlerts {
  static BuildContext context = getIt<RouterCubit>().context;
  static unhandledError({String? error, BuildContext? myContext}) {
    ArtSweetAlert.show(
      context: myContext ?? context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Oops... An Error Occurred',
        confirmButtonText: 'Okay',
        text:
            'We encountered an error while processing your request:\n$error\nPlease try again later or contact support for assistance.',
      ),
    );
  }

  static noCardReaded({required int count}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'Missing $count card',
        confirmButtonText: 'Okay',
        text: 'We missing $count card(s) lets try again.',
      ),
    );
  }

  static noPlayersSelected() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'You need to select al least two players to play',
        confirmButtonText: 'Okay',
        text: 'Please selected to players in order to play the game.',
      ),
    );
  }

  static void showSuccessDeletedPlayers(int deletedUsersCount) {
    String message = 'Deleted $deletedUsersCount users.';
    if (deletedUsersCount == 0) {
      message = 'No session players to deleted';
    }
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: 'Success!',
        confirmButtonText: 'Okay',
        text: message,
      ),
    );
  }

  static void payedJ1toJ2({
    required double dinero,
    required MoneyValue value,
    required String playerPays,
    required String playerReceive,
  }) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "¡Pago exitoso!",
        customColumns: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.blue,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                playerPays,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_right_alt,
            color: Colors.green,
            size: 30,
          ),
          Row(
            children: [
              Text(
                "$dinero ${value == MoneyValue.millon ? 'M' : 'K'}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.person,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                playerReceive,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
        confirmButtonText: "Aceptar",
      ),
    );
  }

  static void payedToGroups({
    required double dinero,
    required MoneyValue value,
    required String jugador,
    required PayTo payto,
  }) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "¡Pago exitoso!",
        customColumns: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.blue,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                payto == PayTo.playerToPlayers
                    ? jugador
                    : 'Todos los jugadores',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_right_alt,
            color: Colors.green,
            size: 30,
          ),
          Row(
            children: [
              Text(
                "$dinero ${value == MoneyValue.millon ? 'M' : 'K'}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.person,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                payto == PayTo.playerToPlayers
                    ? 'Pagó a todos los jugadores!'
                    : 'Pagaron a $jugador',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
        confirmButtonText: "Aceptar",
      ),
    );
  }

  static void invalidAmount({required double amount, bool isBigger = true}) {
    String message;
    if (isBigger) {
      message =
          'The amount entered, $amount, is too large. Please enter a valid amount between 20k and 500M.';
    } else {
      message =
          'The amount entered, $amount, is too small. Please enter a valid amount between 20k and 500M.';
    }

    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: 'Sorry!',
        confirmButtonText: 'Okay',
        text: message,
      ),
    );
  }

  static void noMoneyToSubstract({required double amount}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: 'Sorry!',
        confirmButtonText: 'Okay',
        text: "You don't have enough founds or money",
      ),
    );
  }

  static void addMoneyToPay() {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.info,
          title: 'Sorry!',
          confirmButtonText: 'Okay',
          text: "Please add a amount to pay to a player",
        ));
  }

  static Future<PayTo?> chooseTransaction() async {
    return await ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.question,
            title: 'Choose a transaction',
            customColumns: PayTo.values
                .map((data) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: PayToButton(
                        payTo: data,
                        onTap: (PayTo value) =>
                            Navigator.of(context).pop(value),
                      ),
                    ))
                .toList(),
            onConfirm: () {
              Navigator.of(context).pop(null);
            }));
  }

  static void alreadyRegisteredCard() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Card Already Registered',
        confirmButtonText: 'Okay',
        text: 'This card is already registered. Please try with another card.',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<void> customMessageAlertSuccess({required String text}) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: 'Success',
        confirmButtonText: 'Okay',
        text: text,
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static void customMessageAlertFail({required String text}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: 'Error',
        confirmButtonText: 'Okay',
        text: text,
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<bool> endGame() async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        title: '¿Terminar partida?',
        confirmButtonText: 'Okay',
        text:
            'Si aceptas se terminara la partida y se mostrara el resumen de esta.',
        showCancelBtn: true,
      ),
    );
    if (resp != null && resp.isTapConfirmButton) {
      return true;
    }
    return false;
  }

  static Future<void> insufficientFundsPlayersX({
    required Map<String, double> players,
  }) async {
    String message = 'Estos jugadores no tienen saldo suficiente para pagar:\n';
    players.forEach((playerName, money) {
      message += '$playerName le faltan $money M';
    });

    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'Error',
        confirmButtonText: 'Okay',
        text: message,
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<MapEntry<CardManagerStatus, String?>> showAddPlayerAlert({
    String? oldName,
  }) async {
    final TextEditingController playerNameController =
        TextEditingController(text: oldName);

    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        dialogMainAxisSize: MainAxisSize.max,
        type: ArtSweetAlertType.question,
        title: 'Card manager',
        confirmButtonText: 'Accept',
        denyButtonColor: Colors.red,
        denyButtonText: 'Delete',
        customColumns: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              controller: playerNameController,
              decoration: InputDecoration(
                labelText: oldName ?? 'Player Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
        showCancelBtn: true,
      ),
    );

    if (resp == null) {
      // El usuario cierra la alerta
      return const MapEntry(CardManagerStatus.cancel, null);
    }
    if (resp.isTapCancelButton) {
      // El usuario cancela la acción
      return const MapEntry(CardManagerStatus.cancel, null);
    } else if (resp.isTapDenyButton) {
      // El usuario elige eliminar la tarjeta
      return const MapEntry(CardManagerStatus.delete, null);
    } else {
      // El usuario confirma la acción
      return MapEntry(CardManagerStatus.name, playerNameController.text);
    }
  }

  static Future<MonopolyCard?> readNfcDataCard({String? customText}) async {
    return await showDialog<MonopolyCard?>(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
                height: 300,
                child: ReadCardNfc(
                  customText: customText,
                )),
          );
        });
  }
}

class ReadCardNfc extends StatefulWidget {
  const ReadCardNfc({Key? key, this.customText}) : super(key: key);
  final String? customText;

  @override
  State<ReadCardNfc> createState() => _ReadCardNfcState();
}

class _ReadCardNfcState extends State<ReadCardNfc> {
  MonopolyCard? cardPlayer;
  bool hasError = false;
  String error = '';
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    initSesion();
  }

  Future<void> initSesion() async {
    try {
      await getIt<NfcManager>().startSession(onError: (nfcError) async {
        setState(() {
          hasError = true;
          error = nfcError.message;
        });
      }, onDiscovered: (tag) async {
        if (hasData && !hasError) return;
        if (tag.data.containsKey('ndef')) {
          final ndef = Ndef.from(tag);
          if (ndef != null) {
            final cachedMessage = ndef.cachedMessage;
            if (cachedMessage != null) {
              final resp = MonopolyCard.fromNdefMessage(cachedMessage);
              setState(() {
                cardPlayer = resp;
                hasData = true;
              });
            }
          } else {
            setState(() {
              hasError = true;
              error = 'Try again please';
            });
          }
        }
      });
    } catch (e) {
      setState(() {
        hasError = true;
        error = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    getIt<NfcManager>().stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasError && !hasData) {
      return NfcLoadingAnimation(
        customText: widget.customText,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 15),
        if (hasError) ...[
          Text(error),
          ElevatedButton(
            onPressed: () {
              setState(() {
                hasError = false;
              });
            },
            child: const Text('Reintentar'),
          ),
        ],
        if (!hasError && hasData) ...[
          Text(
              'Tarjeta leída: ${cardPlayer?.number}'), // Mostrar la información de la tarjeta leída
          ElevatedButton(
            onPressed: () async {
              await getIt<NfcManager>().stopSession();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(cardPlayer);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ],
    );
  }
}
