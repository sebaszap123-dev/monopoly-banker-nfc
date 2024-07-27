import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class GameGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = resolver.route.args as GameRouteArgs;
    // final gameVersion = routeArgs.version;
    if (args.startGame) {
      resolver.next(args.startGame);
      return;
    }

    switch (args.version) {
      case GameVersions.classic:
        // TODO: Handle this case
        // final classic =
        //     await getIt<MonopolyGamesStorage>().hasCurrentGamesClassic;
        resolver.next(true);
      case GameVersions.electronic:
        final countSessions = await getIt<BankerManagerService>()
            .getCountGameSession(args.version);
        if (countSessions >= 1) {
          final action = await BankerAlerts.recoveryLastSession(
              countSessions, args.version);
          if (action == null) {
            resolver.next(false);
            return;
          }
          switch (action) {
            case RecoveryAction.last:
              _handleLastSessionGame(resolver, args.version);
              break;
            case RecoveryAction.menu:
              final sessions = await getIt<BankerManagerService>()
                  .getGameSessions(args.version);
              if (sessions.isEmpty) {
                resolver.next(false);
                return;
              }
              resolver.redirect(GameSessionsRoute(version: args.version));
              break;
          }
          return;
        }
        resolver.next(true);
      case GameVersions.colima:
        // TODO: Handle this case.
        resolver.next(true);
    }
  }

  void _handleLastSessionGame(
      NavigationResolver resolver, GameVersions version) async {
    final id = await getIt<BankerManagerService>().getLastSession(version);
    if (id != -1) {
      getIt<MonopolyElectronicBloc>().add(RestoreGameEvent(sessionId: id));
      switch (version) {
        case GameVersions.classic:
          // TODO: Handle this case.
          resolver.next(false);
          break;
        case GameVersions.electronic:
          // TODO: Handle this case.
          resolver.redirect(const ElectronicGameRoute());
          break;
        case GameVersions.colima:
          // TODO: Handle this case.
          resolver.next(false);
      }
      return;
    }
    resolver.next(false);
    return;
  }
}
