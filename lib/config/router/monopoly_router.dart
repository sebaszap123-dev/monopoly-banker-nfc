// PACKAGES
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/guards/game_guard.dart';
// ROUTER AUTO_GENERATE
import 'monopoly_router.gr.dart';

@AutoRouterConfig()
class MonopolyRouter extends $MonopolyRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: GameRoute.page, guards: [GameGuard()]),
        AutoRoute(page: ElectronicGameRoute.page),
        AutoRoute(page: EndGameMonopolyX.page),
        AutoRoute(page: GameSessionsRoute.page),
      ];
}

class RouterCubit extends Cubit<MonopolyRouter> {
  RouterCubit() : super(MonopolyRouter());

  BuildContext get context => state.navigatorKey.currentContext!;

  void goHome() => state.replace(const HomeRoute());

  void popDialogs() {
    if (state.canPop()) {
      Navigator.of(context).pop();
    } else {
      try {
        Navigator.of(context).pop();
      } catch (e) {
        // TODO: HANDLE ERROR AND NOTIFY NO USER
        print(e);
      }
    }
  }
}
