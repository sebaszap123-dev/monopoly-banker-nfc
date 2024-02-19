import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_keyboard.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

@RoutePage()
class SetupGameScreen extends StatelessWidget {
  const SetupGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MonopolyBankerTest();
  }
}

class MonopolyBankerTest extends StatefulWidget {
  const MonopolyBankerTest({Key? key}) : super(key: key);

  @override
  MonopolyBankerTestState createState() => MonopolyBankerTestState();
}

class MonopolyBankerTestState extends State<MonopolyBankerTest> {
  bool checkNfc = false;

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

  Future<String?> handleTag(NfcTag tag) async {
    final tech = Ndef.from(tag);

    if (tech == null) throw ('Tag is not ndef.');

    if (!tech.isWritable) throw ('Tag is not ndef writable.');
    final test = WellknownTextRecord(languageCode: 'es', text: 'M1900');
    try {
      final message = NdefMessage([test.toNdef()]);
      await tech.write(message);
    } on PlatformException catch (e) {
      throw (e.message ?? 'Some error has occurred.');
    }

    return '[Ndef - Write] is completed.';
  }

  void readNfcTag(NfcTag tag) {
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
        String test = '';
        if (cachedMessage != null) {
          for (var i in Iterable.generate(cachedMessage.records.length)) {
            final record = cachedMessage.records[i];
            final info = NdefRecordInfo.fromNdef(record);
            test += info.subtitle;
          }
          message = test;
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: MOSTRAR DATOS DEL JUGADOR
            // TODO: CREAR BASE DE DATOS DE JUGADORES
            // TODO: CUANDO SE SELECCIONE PAGAR A UN JUGADOR DEBE APARECER LA LISTA DE JUGADORES
            // jugador 1 -> jugador 2 (buscar ui bonita :3)
            // MONTO A PAGAR: M$ 200
            MaterialButton(
              color: Colors.amber,
              onPressed: () => _testFocus.unfocus(),
              child: Text('salir'),
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
