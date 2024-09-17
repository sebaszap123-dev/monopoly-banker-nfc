import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
// import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class GameGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = resolver.route.args as GameRouteArgs;
    // final gameVersion = routeArgs.version;
    if (args.isNewGame) {
      resolver.next(args.isNewGame);
      return;
    }

    switch (args.version) {
      case GameVersions.classic:
        // TODO: Handle this case
        resolver.next(true);
      case GameVersions.electronic:
        final countSessions =
            await getIt<ElectronicDatabaseV2>().countSessions();
        if (countSessions >= 1) {
          final action = await BankerAlerts.recoveryLastSession(
              countSessions, args.version);
          if (action == null) {
            resolver.next(false);
            return;
          }
          switch (action) {
            case RecoveryAction.last:
              _handleLastSessionGameV2(resolver, args.version);
              break;
            case RecoveryAction.menu:
              resolver.redirect(GameSessionsRoute(version: args.version));
              break;
          }
          return;
        }
        resolver.next(true);
      case GameVersions.electronic:
        resolver.next(false);
    }
  }

  void _handleLastSessionGameV2(
      NavigationResolver resolver, GameVersions version) async {
    final session = await getIt<ElectronicDatabaseV2>().lastSession();
    if (session != null) {
      getIt<ElectronicGameV2Bloc>()
          .add(RestoreGameEvent(sessionId: session.id));
      resolver.redirect(const ElectronicGameRoute());
      return;
    }
    resolver.next(false);
    return;
  }
}
