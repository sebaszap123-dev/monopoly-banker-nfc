import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/eletronic_v1/game_session.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(
      {super.key,
      required this.session,
      required this.hasMore,
      required this.deleteSession});
  final GameSession session;
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
                    title: Text(player.namePlayer ?? 'No name'),
                    iconColor: player.color,
                    leading: Icon(Icons.person),
                  ))
              .toList(),
          Row(
            children: [
              IconButton(
                onPressed: () => alertDeletionOfSession(session.id),
                icon: Icon(Icons.delete),
                color: Colors.red,
              )
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
    if (response) {
      final deleted = await getIt<BankerManagerService>().deleteSession(id);
      if (deleted) {
        deleteSession(id);
      }
    }
  }
}
