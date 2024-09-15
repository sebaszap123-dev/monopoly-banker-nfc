import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/interface/views/electronic_v2/electronic_game_setup_v2.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/setup_game_electronic.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.version, this.isNewGame = false});
  final GameVersions version;

  /// Used for guard route
  final bool isNewGame;
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
      case GameVersions.electronic:
        return const ElectronicGameSetup();
      case GameVersions.electronicv2:
        return const ElectronicGameSetupV2();
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
