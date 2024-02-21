import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:monopoly_banker/interface/widgets/pay_to_button.dart';
import 'package:nfc_manager/nfc_manager.dart';

abstract class BankerAlerts {
  static BuildContext context = getIt<RouterCubit>().context;
  static unhandleErros({String? error, BuildContext? myContext}) {
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

  static void showSuccessDeletedPlayers(int deletedUsersCount) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: 'Success!',
        confirmButtonText: 'Okay',
        text: 'Deleted $deletedUsersCount users.',
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
              .map((data) => PayToButton(
                    payTo: data,
                    onTap: (PayTo value) => Navigator.of(context).pop(value),
                  ))
              .toList(),
        ));
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

  static Future<void> insufficientFundsPlayers(
      {required String players}) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: 'Error',
        confirmButtonText: 'Okay',
        text:
            'Estos jugadores no tienen el saldo suficiente para pagar: $players',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<String?> showAddPlayerAlert({String? oldName}) async {
    final TextEditingController playerNameController =
        TextEditingController(text: oldName);

    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        title: oldName != null ? 'Edit Player' : 'Add Player',
        confirmButtonText: 'Accept',
        customColumns: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              controller: playerNameController,
              decoration: InputDecoration(
                labelText: 'Player Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40)
        ],
        showCancelBtn: true,
      ),
    );

    if (resp == null || !resp.isTapConfirmButton) {
      // El usuario cancela la acción o cierra la alerta
      return null;
    } else {
      // El usuario confirma la acción
      return playerNameController.text;
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
  const ReadCardNfc({super.key, this.customText});
  final String? customText;
  @override
  State<ReadCardNfc> createState() => _ReadCardNfcState();
}

class _ReadCardNfcState extends State<ReadCardNfc> {
  @override
  void initState() {
    super.initState();
    readDataCard();
  }

  MonopolyCard? cardPlayer;
  String? errorScanning;

  void readDataCard() async {
    await NfcManager.instance.startSession(onError: (error) async {
      errorScanning = error.message;
    }, onDiscovered: (tag) async {
      if (tag.data.containsKey('ndef')) {
        // Identificar el tipo de tecnología NFC
        final ndef = Ndef.from(tag);
        if (ndef != null) {
          final cachedMessage = ndef.cachedMessage;
          if (cachedMessage != null) {
            final resp = MonopolyCard.fromNdefMessage(cachedMessage);
            await NfcManager.instance.stopSession();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(resp);
          }
        } else {
          errorScanning = 'Try again please';
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.customText != null) Text(widget.customText!),
        const SizedBox(height: 10),
        if (errorScanning != null) Text(errorScanning!),
        const NfcLoadingAnimation(),
      ],
    );
  }
}
