import 'package:auto_route/auto_route.dart';
import 'package:monopoly_banker/config/router/monopoly_router.gr.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';

class GameGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // TODO: AGREGAR FORMA DE SABER SI ES ELECTRONICO O CLASIC Y AVISAR AL USER
    final hasGame = await getIt<MonopolyGamesStorage>().hasCurrentGames;

    if (!hasGame) {
      resolver.next(true);
    } else {
      final id = await getIt<MonopolyGamesStorage>().idSesion();
      if (id != null) {
        getIt<MonopolyElectronicBloc>().add(RestoreGameEvent(sessionId: id));
        resolver.redirect(const ElectronicGameRoute());
        return;
      }
      resolver.next(true);
    }
  }
}
