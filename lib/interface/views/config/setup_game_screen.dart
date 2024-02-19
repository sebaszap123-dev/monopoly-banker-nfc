import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:monopoly_banker/interface/views/config/setup_game_electronic.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_credit_card.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_keyboard.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

@RoutePage()
class SetupGameScreen extends StatelessWidget {
  const SetupGameScreen({super.key, required this.versions});
  final GameVersions versions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(versions),
    );
  }

  Widget getScreen(GameVersions version) {
    switch (version) {
      case GameVersions.classic:
        return const MonopolyBankerTest();
      case GameVersions.electronico:
        return const SetupGameElectronic();
    }
  }
}

class MonopolyBankerTest extends StatefulWidget {
  const MonopolyBankerTest({Key? key}) : super(key: key);

  @override
  MonopolyBankerTestState createState() => MonopolyBankerTestState();
}

class MonopolyBankerTestState extends State<MonopolyBankerTest> {
  bool checkNfc = false;

  NfcTag? myTag;

  void toggleNfc() async {
    // Check availability
    if (checkNfc) {
      NfcManager.instance.stopSession();
    }
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          readNfcTag(tag);
        },
        onError: (error) async {
          print('error:');
          print(error.message);
        },
      );
    }
    setState(() {
      checkNfc = !checkNfc;
    });
  }

  String? message;
  String? tech;
  String? identificador;
  MonopolyPlayer? card;
  Future<void> writeToTag(NfcTag? tag) async {
    if (tag == null) return;

    final tech = Ndef.from(tag);

    if (tech == null) throw ('Tag is not ndef.');

    if (!tech.isWritable) throw ('Tag is not ndef writable.');
    final test =
        WellknownTextRecord(languageCode: 'es', text: '2267 5924 2688 0068');
    final color =
        WellknownTextRecord(languageCode: 'es', text: Colors.red.toHex());
    try {
      final message = NdefMessage([test.toNdef(), color.toNdef()]);
      await tech.write(message);
    } on PlatformException catch (e) {
      throw (e.message ?? 'Some error has occurred.');
    } catch (e) {
      throw ('$e');
    }

    // return '[Ndef - Write] is completed.';
  }

  void readNfcTag(NfcTag? tag) {
    if (tag == null) return;
    if (tag.data.containsKey('nfca')) {
      tech = 'Tipo de tecnología NFC: NfcA';
      identificador =
          'Identificador: ${NfcA.from(tag)!.identifier.toHexString()}';
      // Agrega más información específica de NfcA si es necesario
    } else if (tag.data.containsKey('nfcb')) {
      tech = ('Tipo de tecnología NFC: NfcB');
      identificador =
          ('Identificador: ${NfcB.from(tag)!.identifier.toHexString()}');
      // Agrega más información específica de NfcB si es necesario
    } else if (tag.data.containsKey('nfcf')) {
      tech = ('Tipo de tecnología NFC: NfcF');
      // Agrega más información específica de NfcF si es necesario
    } else if (tag.data.containsKey('nfcv')) {
      tech = ('Tipo de tecnología NFC: NfcV');
      // Agrega más información específica de NfcV si es necesario
    } else if (tag.data.containsKey('isodep')) {
      tech = ('Tipo de tecnología NFC: IsoDep');
      // Agrega más información específica de IsoDep si es necesario
    } else if (tag.data.containsKey('mifareclassic')) {
      tech = ('Tipo de tecnología NFC: MifareClassic');
      // Agrega más información específica de MifareClassic si es necesario
    } else if (tag.data.containsKey('mifareultralight')) {
      tech = ('Tipo de tecnología NFC: MifareUltralight');
      // Agrega más información específica de MifareUltralight si es necesario
    } else if (tag.data.containsKey('ndef')) {
      tech = ('Tipo de tecnología NFC: Ndef');
      // Agrega más información específica de Ndef si es necesario
    } else if (tag.data.containsKey('ndefformatable')) {
      tech = ('Tipo de tecnología NFC: NdefFormatable');
      // Agrega más información específica de NdefFormatable si es necesario
    }

    // Si hay registros NDEF, imprime su contenido
    if (tag.data.containsKey('ndef')) {
      // Identificar el tipo de tecnología NFC
      final ndef = Ndef.from(tag);
      if (ndef != null) {
        final cachedMessage = ndef.cachedMessage;
        if (cachedMessage != null) {
          final resp = MonopolyPlayer.fromNdefMessage(cachedMessage);
          setState(() {
            card = resp;
          });
        }
      }
    }
    setState(() {});
  }

  final FocusNode _testFocus = FocusNode();
  final TextEditingController notifier = TextEditingController(text: '0');

  @override
  void initState() {
    notifier.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: MOSTRAR DATOS DEL JUGADOR
            // TODO: CREAR BASE DE DATOS DE JUGADORES
            // TODO: CUANDO SE SELECCIONE PAGAR A UN JUGADOR DEBE APARECER LA LISTA DE JUGADORES
            // jugador 1 -> jugador 2 (buscar ui bonita :3)
            // MONTO A PAGAR: M$ 200
            MaterialButton(
              color: Colors.amber,
              onPressed: () => _testFocus.unfocus(),
              child: const Text('salir'),
            ),
            MaterialButton(
              color: Colors.amber,
              onPressed: () => readNfcTag(myTag),
              child: const Text('Read'),
            ),
            MaterialButton(
              color: Colors.amber,
              onPressed: () => writeToTag(myTag),
              child: const Text('Write'),
            ),
            if (card != null)
              MonopolyCreditCard(
                cardNumber: card!.number,
                cardHeight: 200,
                color: card!.color,
                onTap: () {},
              ),
            Text('NFC: $checkNfc'),
            Text('message: $message'),
            Text('TECH: $tech'),
            Text('ID: $identificador'),
            Text(notifier.text),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleNfc,
        child: const Icon(Icons.nfc),
      ),
      bottomNavigationBar: const MonopolyTerminal(),
    );
  }
}
