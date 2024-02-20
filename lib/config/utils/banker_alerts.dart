import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
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
        onConfirm: () {
          getIt<RouterCubit>().popDialogs();
        },
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
        onConfirm: () {
          // Perform any action upon confirmation (if needed)
          // For example, close the alert or navigate to another screen.
          Navigator.of(context).pop();
        },
      ),
    );
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

  static Future<MonopolyCard?> readNfcDataCard() async {
    return await showDialog<MonopolyCard?>(
        context: context,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(height: 300, child: ReadCardNfc()),
          );
        });
  }
}

class ReadCardNfc extends StatefulWidget {
  const ReadCardNfc({super.key});

  @override
  State<ReadCardNfc> createState() => _ReadCardNfcState();
}

class _ReadCardNfcState extends State<ReadCardNfc> {
  @override
  void initState() {
    super.initState();
    readDataCard();
  }

  @override
  void dispose() async {
    super.dispose();
    await NfcManager.instance.stopSession();
  }

  MonopolyCard? cardPlayer;
  String? errorScanning;

  void readDataCard() {
    NfcManager.instance.startSession(onDiscovered: (tag) async {
      if (tag.data.containsKey('ndef')) {
        // Identificar el tipo de tecnología NFC
        final ndef = Ndef.from(tag);
        if (ndef != null) {
          final cachedMessage = ndef.cachedMessage;
          if (cachedMessage != null) {
            final resp = MonopolyCard.fromNdefMessage(cachedMessage);
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
        if (errorScanning != null) Text(errorScanning!),
        const NfcLoadingAnimation(),
      ],
    );
  }
}
