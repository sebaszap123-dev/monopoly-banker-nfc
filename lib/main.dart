import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(const MonopolyBanker());

class MonopolyBanker extends StatelessWidget {
  const MonopolyBanker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const NFCMonopolyManager(),
      ),
    );
  }
}

class NFCMonopolyManager extends StatefulWidget {
  const NFCMonopolyManager({super.key});

  @override
  State<NFCMonopolyManager> createState() => _NFCMonopolyManagerState();
}

class _NFCMonopolyManagerState extends State<NFCMonopolyManager> {
  void checkNfc() async {
    // Check availability
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      // Start Session
      print('Started sesion');
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          // Do something with an NfcTag instance.
          print(tag.data);
        },
        onError: (error) async {
          print(error.message);
        },
      );
      await Future.delayed(const Duration(seconds: 30));
      // Stop Session
      NfcManager.instance.stopSession();
      print('Stop session');
    }
    print(isAvailable);
  }

  @override
  void initState() {
    checkNfc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text('Hola mundo'),
    );
  }
}
