import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/game_session.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/session_card.dart';

@RoutePage()
class GameSessionsScreen extends StatefulWidget {
  const GameSessionsScreen({super.key, required this.version});
  final GameVersions version;

  @override
  State<GameSessionsScreen> createState() => _GameSessionsScreenState();
}

class _GameSessionsScreenState extends State<GameSessionsScreen> {
  late StreamController<List<GameSession>> _streamController;

  bool disposed = false;

  void deleteSession(List<GameSession> sessions, int id) async {
    sessions.removeWhere((session) => session.id == id);
    _streamController.add(sessions);
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<GameSession>>();
    getIt<BankerManagerService>()
        .getGameSessions(widget.version)
        .then((value) => _streamController.add(value));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game sessions'),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw snapshot.error ?? 'Error getting game sessions';
          }
          if ((snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active)) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map((session) =>
                          // session.players.isEmpty
                          //     ? Container()
                          // :
                          SessionCard(
                            session: session,
                            hasMore: snapshot.data?.isNotEmpty ?? false,
                            deleteSession: (int sessionId) {
                              final myList = snapshot.data;
                              if (myList == null) {
                                return;
                              }
                              final deleted = myList.remove(session);
                              if (deleted) {
                                _streamController.add(myList);
                                // ? TODO: REDIRIGIR AL HOME SI ESTA VACIO
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
