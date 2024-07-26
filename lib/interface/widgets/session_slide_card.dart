import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/model/game_session.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class SessionSlideCard extends StatelessWidget {
  const SessionSlideCard(
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
      color: Colors.blueGrey,
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.5,
          // dismissible: DismissiblePane(onDismissed: () => print('ola')),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(25),
              onPressed: (_) => alertDeletionOfSession(session.id),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.5,
          // dismissible: DismissiblePane(onDismissed: () => print('ola')),
          children: [
            SlidableAction(
              // flex: 4,
              borderRadius: BorderRadius.circular(25),
              // TODO: ADD PLAY GAME (RESTORE GAME)
              onPressed: (_) => getIt<MonopolyElectronicBloc>()
                  .add(RestoreGameEvent(sessionId: session.id!)),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.play_arrow_rounded,
              label: 'Play',
            ),
          ],
        ),
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
          ],
        ),
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
