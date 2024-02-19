import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/ndfe_record_info.dart';
import 'package:monopoly_banker/data/model/record.dart';
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

class SetupGameElectronic extends StatefulWidget {
  const SetupGameElectronic({
    super.key,
  });

  @override
  State<SetupGameElectronic> createState() => _SetupGameElectronicState();
}

class _SetupGameElectronicState extends State<SetupGameElectronic> {
  Map<Color, bool> players = {};

  void addPlayer() {
    showBottomSheet(
        context: context,
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Player',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ajusta el radio según lo necesites
                    ),
                  ),
                ),
                const Row(children: []),
              ],
            ),
          );
        });
  }

  Color? color;

  void addNewCard() async {
    final resp = await showDialog<Color>(
        context: context,
        builder: (_) {
          return const NfcCardDialog();
        });
    if (resp != null) {
      players[resp] = false;
      setState(() {});
    }
  }

  double get cardHeight {
    return MediaQuery.of(context).size.height * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Choose cards for each player'),
          backgroundColor: Colors.grey.shade100,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewCard,
          child: const Icon(Icons.add),
        ),
        body: players.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 50),
                  ...players.entries.map((e) => MonopolyCreditCard(
                        cardHeight: cardHeight,
                        isSelected: e.value,
                        color: e.key,
                        onTap: () {
                          players[e.key] = !e.value;
                          setState(() {});
                        },
                      ))
                ],
              )
            : const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No players register',
                          style: TextStyle(fontSize: 40)),
                      Icon(Icons.gamepad_rounded, size: 180),
                    ]),
              ));
  }
}

class NfcCardDialog extends StatefulWidget {
  const NfcCardDialog({
    super.key,
  });

  @override
  State<NfcCardDialog> createState() => _NfcCardDialogState();
}

class _NfcCardDialogState extends State<NfcCardDialog> {
  final Map<String, Color> defaultColors = {
    'azul cielo': Colors.blue.shade200,
    'Verde': Colors.green.shade500,
    'Azul': Colors.blue.shade900,
    'Rojo': Colors.red.shade800,
    'Morado': Colors.purpleAccent.shade700,
  };
  bool isNfc = false;
  Color? color;

  onNfc() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop<Color>(color);
  }

  // TODO: ADD LISTENER SESION NFC

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
            height: 300,
            child: isNfc
                ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: LoadingAnimationWidget.beat(
                          color: Colors.blue.shade300,
                          size: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Hold your phone near the NFC tag',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Select a color for the card'),
                        DropdownButton<Color>(
                          value: color,
                          items: [
                            ...defaultColors.entries.map(
                              (e) => DropdownMenuItem<Color>(
                                value: e.value,
                                child: Text(
                                  e.key,
                                ),
                              ),
                            )
                          ],
                          onChanged: (Color? value) {
                            setState(() {
                              color = value;
                            });
                            onNfc();
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isNfc = true;
                              });
                            },
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.blue.shade500),
                            ))
                      ],
                    ),
                  )));
  }
}

class MonopolyCreditCard extends StatelessWidget {
  const MonopolyCreditCard({
    super.key,
    required this.cardHeight,
    this.isSelected = false,
    required this.color,
    required this.onTap,
  });

  final double cardHeight;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: cardHeight, minHeight: cardHeight),
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          margin: const EdgeInsets.all(12),
          color: color,
          // Establecer el borde según si está seleccionado o no
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Ajusta el radio según lo necesites
            side: BorderSide(
              color: isSelected ? Colors.yellowAccent : Colors.transparent,
              width: 4.0, // Ajusta el grosor del borde según lo necesites
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Image.asset(
                  BankerImages.bannerCard,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                bottom: 50,
                left: 20,
                child: Text(
                  '1234 5678 9123 4567',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    Text(
                      '01/35',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '12/35',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              child: const Text('salir'),
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
