import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/model/session.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(
      {super.key,
      required this.session,
      required this.hasMore,
      required this.deleteSession});
  final GameSessions session;
  final bool hasMore;
  final void Function(int) deleteSession;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: '#E9E3B4'.toColor(),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          SizedBox(height: 10),
          Center(child: Text(session.id.toString())),
          SizedBox(height: 5),
          ...session.players
              .map((player) => ListTile(
                    title: Text(player.namePlayer),
                    iconColor: player.card!.color,
                    leading: Icon(Icons.person),
                  ))
              .toList(),
          Row(
            children: [
              IconButton(
                onPressed: () => alertDeletionOfSession(session.id),
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
              IconButton(
                onPressed: () async {
                  getIt<ElectronicGameV2Bloc>()
                      .add(RestoreGameEvent(sessionId: session.id));
                  getIt<RouterCubit>().state.push(const ElectronicGameRoute());
                  return;
                },
                icon: Icon(Icons.restore),
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }

  void alertDeletionOfSession(int? id) async {
    if (id == null) {
      return;
    }
    final response = await BankerAlerts.deleteSessionGame(id);
    print(response);
    if (response) {
      getIt<ElectronicDatabaseV2>().deleteGameSession(session.id);
      deleteSession(id);
    }
  }
}
