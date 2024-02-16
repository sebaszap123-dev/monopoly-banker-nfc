// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:monopoly_banker/interface/views/game_screen.dart' as _i1;

abstract class $MonopolyRouter extends _i2.RootStackRouter {
  $MonopolyRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    GameRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.GameScreen(),
      );
    }
  };
}

/// generated route for
/// [_i1.GameScreen]
class GameRoute extends _i2.PageRouteInfo<void> {
  const GameRoute({List<_i2.PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
