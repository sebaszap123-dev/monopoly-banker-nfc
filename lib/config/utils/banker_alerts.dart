import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/service_locator.dart';

abstract class BankerAlerts {
  static BuildContext context = getIt<RouterCubit>().context;
  static unhandleErros({String? error}) {
    ArtSweetAlert.show(
      context: context,
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

  static void alreadyRegisteredCard(BuildContext context) {
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
}
