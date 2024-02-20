// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:monopoly_banker/config/utils/game_versions_support.dart' as _i7;
import 'package:monopoly_banker/interface/views/add_cards_screen.dart' as _i1;
import 'package:monopoly_banker/interface/views/config/eletronic_game_screen.dart'
    as _i2;
import 'package:monopoly_banker/interface/views/config/game_screen.dart' as _i3;
import 'package:monopoly_banker/interface/views/home_screen.dart' as _i4;

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
    ElectronicGameRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ElectronicGameScreen(),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameScreen(
          key: args.key,
          versions: args.versions,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
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
/// [_i2.ElectronicGameScreen]
class ElectronicGameRoute extends _i5.PageRouteInfo<void> {
  const ElectronicGameRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ElectronicGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'ElectronicGameRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i5.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i6.Key? key,
    required _i7.GameVersions versions,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            versions: versions,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i5.PageInfo<GameRouteArgs> page =
      _i5.PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.versions,
  });

  final _i6.Key? key;

  final _i7.GameVersions versions;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, versions: $versions}';
  }
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
