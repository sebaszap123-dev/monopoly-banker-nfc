import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/game_session.dart';
import 'package:monopoly_banker/data/service/banker_electronic_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/session_slide_card.dart';

@RoutePage()
class GameSessionsScreen extends StatelessWidget {
  const GameSessionsScreen({super.key, required this.version});
  final GameVersions version;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game sessions'),
      ),
      // TODO: usar el bloc provider
      body: FutureBuilder<List<GameSession>>(
          future: getIt<BankerElectronicService>().getGameSessions(version),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              throw snapshot.error ?? 'Error getting game sessions';
            }
            if (snapshot.hasData &&
                snapshot.connectionState != ConnectionState.waiting) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: snapshot.data!.map((session) =>
                      // session.players.isEmpty
                      //     ? Container()
                      // :
                      SessionSlideCard(session: session)).toList(),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getIt<RouterCubit>()
            .state
            .push(GameRoute(version: version, isNewGame: true)),
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
