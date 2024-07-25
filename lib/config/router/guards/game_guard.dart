import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
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
        final electronic =
            await getIt<MonopolyGamesStorage>().hasCurrentGamesElectronic;
        if (electronic) {
          final action = await BankerAlerts.recoveryLastSession();
          if (action == null) {
            resolver.next(false);
            return;
          }
          switch (action) {
            case RecoveryAction.last:
              _handleLastSessionGame(resolver);
              break;
            case RecoveryAction.menu:
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

  void _handleLastSessionGame(NavigationResolver resolver) async {
    final id = await getIt<MonopolyGamesStorage>().idSession();
    if (id != null) {
      getIt<MonopolyElectronicBloc>()
          .add(RestoreGameEvent(sessionId: int.parse(id)));
      resolver.redirect(const ElectronicGameRoute());
      return;
    }
  }
}
