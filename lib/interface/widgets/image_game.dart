import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';

class ImageGame extends StatelessWidget {
  const ImageGame({super.key, required this.version});
  final GameVersions version;
  @override
  Widget build(BuildContext context) {
    return Image.asset(_getImageVersion(version), fit: BoxFit.cover);
  }

  String _getImageVersion(GameVersions version) {
    switch (version) {
      case GameVersions.classic:
        return BankerImages.monopolyClassic;
      case GameVersions.electronic:
        return BankerImages.monopolyElectronic;
      case GameVersions.electronicv2:
        // TODO: Change Image.
        return BankerImages.monopolyElectronic;
    }
  }
}
