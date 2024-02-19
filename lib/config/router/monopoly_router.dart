// PACKAGES
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ROUTER AUTO_GENERATE
import 'monopoly_router.gr.dart';

@AutoRouterConfig()
class MonopolyRouter extends $MonopolyRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SetupGameRoute.page),
        AutoRoute(page: AddCardsRoute.page),
        AutoRoute(page: GameRoute.page),
      ];
}

class RouterCubit extends Cubit<MonopolyRouter> {
  RouterCubit() : super(MonopolyRouter());

  BuildContext get context => state.navigatorKey.currentContext!;

  void popDialogs() {
    if (state.canPop()) {
      Navigator.of(context).pop();
    } else {
      try {
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
      }
    }
  }
}
