import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service/banker_preferences.dart';
import 'package:monopoly_banker/data/service/game_sessions_service.dart';
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
        // TODO: IMPLEMENT
        // final classic =
        //     await getIt<MonopolyGamesStorage>().hasCurrentGamesClassic;
        resolver.next(true);
      case GameVersions.electronic:
        final hasSessions = await getIt<BankerPreferences>().hasSessions;
        if (hasSessions) {
          final action = await BankerAlerts.recoveryLastSession();
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
                // TODO: HANDLE BANKER ALERT
                getIt<BankerPreferences>().updateSessions(false);
                resolver.next(false);
                throw Exception('Sessions can not be empty please report this');
              }
              // if (getIt<GameSessionsService>().disposed) {
              //   getIt.registerSingleton(GameSessionsService());
              // }
              getIt<GameSessionsService>().update(sessions);
              resolver.redirect(GameSessionsRoute(version: args.version));
              break;
          }
          return;
        }
        resolver.next(true);
      // TODO: Handle this case.
      case GameVersions.colima:
        resolver.next(true);
    }
  }

  void _handleLastSessionGame(
      NavigationResolver resolver, GameVersions version) async {
    final id = await getIt<BankerManagerService>().getLastSession(version);
    if (id != -1) {
      getIt<MonopolyElectronicBloc>().add(RestoreGameEvent(sessionId: id));
      resolver.redirect(const ElectronicGameRoute());
      return;
    }
    resolver.next(false);
    return;
  }
}
