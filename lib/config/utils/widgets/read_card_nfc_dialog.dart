import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/monopoly_cards.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/nfc_loading_animation.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
    initSession();
  }

  Future<void> initSession() async {
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
