import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/service/banker_preferences.dart';
import 'package:monopoly_banker/data/service/game_sessions_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/session_slide_card.dart';

@RoutePage()
class GameSessionsScreen extends StatefulWidget {
  const GameSessionsScreen({super.key, required this.version});
  final GameVersions version;

  @override
  State<GameSessionsScreen> createState() => _GameSessionsScreenState();
}

class _GameSessionsScreenState extends State<GameSessionsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   getIt.registerSingleton(GameSessionsService());
  // }

  @override
  void dispose() async {
    getIt<GameSessionsService>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game sessions'),
      ),
      body: StreamBuilder(
        stream: getIt<GameSessionsService>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw snapshot.error ?? 'Error getting game sessions';
          }
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map((session) =>
                          // session.players.isEmpty
                          //     ? Container()
                          // :
                          SessionSlideCard(
                            session: session,
                            hasMore: snapshot.data?.isNotEmpty ?? false,
                            deleteSession: (int sessionId) {
                              final myList = snapshot.data;
                              if (myList == null) {
                                return;
                              }
                              final deleted = myList.remove(session);
                              if (deleted) {
                                getIt<GameSessionsService>().update(myList);
                                getIt<BankerPreferences>()
                                    .updateSessions(myList.isNotEmpty);
                              }
                            },
                          ))
                      .toList(),
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getIt<RouterCubit>()
            .state
            .push(GameRoute(version: widget.version, isNewGame: true)),
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
