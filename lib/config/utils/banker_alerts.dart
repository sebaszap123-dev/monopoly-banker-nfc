import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/config/utils/widgets/read_card_nfc_dialog.dart';
import 'package:monopoly_banker/config/utils/widgets/read_card_nfc_v2.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/electronic_v2/monopoly_cards_v2.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/money.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/pay_to_button.dart';

enum CardManagerStatus { delete, cancel, name }

enum RecoveryAction { last, menu }

abstract class BankerAlerts {
  static BuildContext context = getIt<RouterCubit>().context;
  static unhandledError({String? error, BuildContext? myContext}) async {
    await ArtSweetAlert.show(
      context: myContext ?? context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Oops... An Error Occurred',
        confirmButtonText: 'Okay',
        text:
            'We encountered an error while processing your request:\n$error\nPlease try again later or contact support for assistance.',
      ),
    );
    getIt<RouterCubit>().state.push(HomeRoute());
  }

  static noCardReader({required int count}) {
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

  static invalidCardNumber() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Sucedio un error al leer tu tarjeta',
        confirmButtonText: 'Okay',
        text:
            'Parece que contiene un numero invalido para este juego, intenta de nuevo.',
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

  static noCardSelected() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'You need to select one card based on the color',
        confirmButtonText: 'Okay',
        text: 'Please selected one card to pair with NFC.',
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

  static Future<bool> deleteSessionGame(int deletedUsersCount) async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        // title: 'You are going to delete your game!',
        title: '¿Estas seguro de eliminar esta sesión?',
        confirmButtonText: 'Estoy seguro',
        showCancelBtn: true,
        text:
            'Si borras esta sesión los datos de los jugadores y todo lo relacionado será borrado',
      ),
    );

    if (resp != null && resp.isTapConfirmButton) {
      return true;
    }

    return false;
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

  static void payedJ1toJ2V2({
    required Money money,
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
                money.toString(),
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

  static void payedToGroupsV2({
    required Money money,
    required String player,
    required PayToAction payTo,
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
                payTo == PayTo.playerToPlayers ? player : 'Todos los jugadores',
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
                money.toString(),
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
                payTo == PayTo.playerToPlayers
                    ? 'Pagó a todos los jugadores!'
                    : 'Pagaron a $player',
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

  static void noMoneyToSubtract({required double amount}) {
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

  static Future<PayTo?> chooseTransactionV1() async {
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

  static Future<PayToAction?> chooseTransactionV2() async {
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
        title: 'Hey!',
        confirmButtonText: 'Okay',
        text: message,
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<void> insufficientFundsPlayersV2({
    required Map<String, Money> players,
  }) async {
    String message = 'Estos jugadores no tienen saldo suficiente para pagar:\n';
    players.forEach((playerName, money) {
      message += '$playerName le faltan ${money.toString()}';
    });

    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'Hey!',
        confirmButtonText: 'Okay',
        text: message,
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<RecoveryAction?> recoveryLastSession(
      int sessions, GameVersions version) async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        title: 'Recuperar última sesión',
        text: '¿Deseas recuperar tu última sesión?',
        customColumns: sessions == 1
            ? [
                MaterialButton(
                  onPressed: () => getIt<RouterCubit>()
                      .state
                      .popAndPush(GameRoute(version: version, isNewGame: true)),
                  child: SizedBox(
                    width: 150,
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'New game',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            : null,
        showCancelBtn: sessions > 1,
        confirmButtonText: 'Recuperar',
        cancelButtonText: 'Ver mis sesiones',
        cancelButtonColor: Colors.lightGreen,
      ),
    );
    if (resp == null) {
      return null;
    }
    if (resp.isTapConfirmButton) {
      return RecoveryAction.last;
    } else if (resp.isTapCancelButton) {
      return RecoveryAction.menu;
    }
    return null;
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

  static Future<MonopolyCardV2?> readNfcDataCardV2({String? customText}) async {
    return await showDialog<MonopolyCardV2?>(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
                height: 300,
                child: ReadCardNfcV2(
                  customText: customText,
                )),
          );
        });
  }
}
