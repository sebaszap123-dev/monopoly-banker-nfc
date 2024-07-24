import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/config/utils/game_versions_support.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class GameGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = resolver.route.args as GameRouteArgs;
    // final gameVersion = routeArgs.version;
    switch (args.version) {
      case GameVersions.classic:
        // final classic =
        //     await getIt<MonopolyGamesStorage>().hasCurrentGamesClassic;
        resolver.next(true);
      case GameVersions.electronic:
        final electronic =
            await getIt<MonopolyGamesStorage>().hasCurrentGamesElectronic;
        if (electronic) {
          // TODO: JALAR LAS SESIONES EXISTENTES Y USARLAS PARA MOSTRARLAS Y QUE DECIDA CUAL QUIERE USAR (REDIRIGIR A OTRA PANTALLA DE SELECCIONAR PARTIDA)
          final id = await getIt<MonopolyGamesStorage>().idSession();
          if (id != null) {
            getIt<MonopolyElectronicBloc>()
                .add(RestoreGameEvent(sessionId: id));
            resolver.redirect(const ElectronicGameRoute());
          }
        }
        resolver.next(true);
      // TODO: Handle this case.
      case GameVersions.colima:
        resolver.next(true);
    }
  }
}
