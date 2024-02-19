// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:monopoly_banker/interface/views/add_cards_screen.dart' as _i1;
import 'package:monopoly_banker/interface/views/game_screen.dart' as _i2;
import 'package:monopoly_banker/interface/views/home_screen.dart' as _i3;
import 'package:monopoly_banker/interface/views/setup_game_screen.dart' as _i4;

abstract class $MonopolyRouter extends _i5.RootStackRouter {
  $MonopolyRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AddCardsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCardsScreen(),
      );
    },
    GameRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GameScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    SetupGameRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SetupGameScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddCardsScreen]
class AddCardsRoute extends _i5.PageRouteInfo<void> {
  const AddCardsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AddCardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCardsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GameScreen]
class GameRoute extends _i5.PageRouteInfo<void> {
  const GameRoute({List<_i5.PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SetupGameScreen]
class SetupGameRoute extends _i5.PageRouteInfo<void> {
  const SetupGameRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SetupGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetupGameRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
