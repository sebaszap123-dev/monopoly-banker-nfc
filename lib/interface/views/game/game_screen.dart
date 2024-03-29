import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/interface/views/game/setup_game_electronic.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.version});
  final GameVersions version;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(version),
    );
  }

  Widget getScreen(GameVersions version) {
    switch (version) {
      case GameVersions.classic:
        return const ClassicGameSetup();
      case GameVersions.electronico:
        return const EletronicGameSetup();
    }
  }
}

class ClassicGameSetup extends StatelessWidget {
  const ClassicGameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Cooming soon')),
    );
  }
}

/// Example NFC
// class MonopolyBankerTest extends StatefulWidget {
//   const MonopolyBankerTest({Key? key}) : super(key: key);

//   @override
//   MonopolyBankerTestState createState() => MonopolyBankerTestState();
// }

// class MonopolyBankerTestState extends State<MonopolyBankerTest> {
//   bool checkNfc = false;

//   NfcTag? myTag;

//   void toggleNfc() async {
//     // Check availability
//     if (checkNfc) {
//       getIt<NfcManager>().stopSession();
//     }
//     bool isAvailable = await getIt<NfcManager>().isAvailable();
//     if (isAvailable) {
//       getIt<NfcManager>().startSession(
//         onDiscovered: (NfcTag tag) async {
//           readNfcTag(tag);
//         },
//         onError: (error) async {
//           print('error:');
//           print(error.message);
//         },
//       );
//     }
//     setState(() {
//       checkNfc = !checkNfc;
//     });
//   }

//   String? message;
//   String? tech;
//   String? identificador;
//   MonopolyPlayerX? card;

//   void readNfcTag(NfcTag? tag) {
//     if (tag == null) return;
//     if (tag.data.containsKey('nfca')) {
//       tech = 'Tipo de tecnología NFC: NfcA';
//       identificador =
//           'Identificador: ${NfcA.from(tag)!.identifier.toHexString()}';
//       // Agrega más información específica de NfcA si es necesario
//     } else if (tag.data.containsKey('nfcb')) {
//       tech = ('Tipo de tecnología NFC: NfcB');
//       identificador =
//           ('Identificador: ${NfcB.from(tag)!.identifier.toHexString()}');
//       // Agrega más información específica de NfcB si es necesario
//     } else if (tag.data.containsKey('nfcf')) {
//       tech = ('Tipo de tecnología NFC: NfcF');
//       // Agrega más información específica de NfcF si es necesario
//     } else if (tag.data.containsKey('nfcv')) {
//       tech = ('Tipo de tecnología NFC: NfcV');
//       // Agrega más información específica de NfcV si es necesario
//     } else if (tag.data.containsKey('isodep')) {
//       tech = ('Tipo de tecnología NFC: IsoDep');
//       // Agrega más información específica de IsoDep si es necesario
//     } else if (tag.data.containsKey('mifareclassic')) {
//       tech = ('Tipo de tecnología NFC: MifareClassic');
//       // Agrega más información específica de MifareClassic si es necesario
//     } else if (tag.data.containsKey('mifareultralight')) {
//       tech = ('Tipo de tecnología NFC: MifareUltralight');
//       // Agrega más información específica de MifareUltralight si es necesario
//     } else if (tag.data.containsKey('ndef')) {
//       tech = ('Tipo de tecnología NFC: Ndef');
//       // Agrega más información específica de Ndef si es necesario
//     } else if (tag.data.containsKey('ndefformatable')) {
//       tech = ('Tipo de tecnología NFC: NdefFormatable');
//       // Agrega más información específica de NdefFormatable si es necesario
//     }

//     // Si hay registros NDEF, imprime su contenido
//     if (tag.data.containsKey('ndef')) {
//       // Identificar el tipo de tecnología NFC
//       final ndef = Ndef.from(tag);
//       if (ndef != null) {
//         final cachedMessage = ndef.cachedMessage;
//         if (cachedMessage != null) {
//           // final resp = MonopolyPlayerX.fromNdefMessage(cachedMessage);
//         }
//       }
//     }
//     setState(() {});
//   }

//   final FocusNode _testFocus = FocusNode();
//   final TextEditingController notifier = TextEditingController(text: '0');

//   @override
//   void initState() {
//     notifier.addListener(() => setState(() {}));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Material App Bar'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialButton(
//               color: Colors.amber,
//               onPressed: () => _testFocus.unfocus(),
//               child: const Text('salir'),
//             ),
//             MaterialButton(
//               color: Colors.amber,
//               onPressed: () => readNfcTag(myTag),
//               child: const Text('Read'),
//             ),
//             if (card != null)
//               MonopolyCreditCard(
//                 cardNumber: card!.number,
//                 cardHeight: 200,
//                 color: card!.color,
//                 onTap: () {},
//               ),
//             Text('NFC: $checkNfc'),
//             Text('message: $message'),
//             Text('TECH: $tech'),
//             Text('ID: $identificador'),
//             Text(notifier.text),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: toggleNfc,
//         child: const Icon(Icons.nfc),
//       ),
//       bottomNavigationBar: const MonopolyTerminal(),
//     );
//   }
// }
