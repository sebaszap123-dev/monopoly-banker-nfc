import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';
import 'package:monopoly_banker/config/utils/banker_textstyle.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/image_game.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        flexibleSpace: const FlexibleHomeBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.gamepad),
                  title: Text(
                    'Game versions',
                    style: BankerTextStyle.subtitle,
                  ),
                ),
                SizedBox(
                  height: GameVersions.values.length >= 2
                      ? 150
                      : 300, // Establece una altura fija para el GridView
                  child: GridView.builder(
                    itemCount: GameVersions.values.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => getIt<RouterCubit>()
                          .state
                          .push(GameRoute(version: GameVersions.values[index])),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.red,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ImageGame(
                              version: GameVersions.values[index],
                            )),
                            Positioned(
                              bottom: 10,
                              left: 20,
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    GameVersions.values[index].name
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.featured_play_list),
                  title: Text(
                    'Future features',
                    style: BankerTextStyle.subtitle,
                  ),
                ),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('Cuming soon 7w7'))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class FlexibleHomeBar extends StatelessWidget {
  const FlexibleHomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.blue.shade100.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(BankerImages.topbar, fit: BoxFit.cover)),
          const BankerBlurDefault(),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              'Monopoly NFC',
              style: BankerTextStyle.homeTitle,
            ),
          ),
        ],
      ),
    );
  }
}

class BankerBlurDefault extends StatelessWidget {
  const BankerBlurDefault({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1.5,
          sigmaY: 0.5,
          tileMode: TileMode.decal,
        ),
        child: Container(
          color: color ?? Colors.blue.shade500.withOpacity(0.5),
        ),
      ),
    );
  }
}
