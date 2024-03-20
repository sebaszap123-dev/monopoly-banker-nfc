// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:monopoly_banker/config/utils/game_versions_support.dart' as _i8;
import 'package:monopoly_banker/data/model/monopoly_player.dart' as _i7;
import 'package:monopoly_banker/interface/views/game/eletronic_game_screen.dart'
    as _i1;
import 'package:monopoly_banker/interface/views/game/end_game.dart' as _i2;
import 'package:monopoly_banker/interface/views/game/game_screen.dart' as _i3;
import 'package:monopoly_banker/interface/views/home_screen.dart' as _i4;

abstract class $MonopolyRouter extends _i5.RootStackRouter {
  $MonopolyRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ElectronicGameRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ElectronicGameScreen(),
      );
    },
    EndGameMonopolyX.name: (routeData) {
      final args = routeData.argsAs<EndGameMonopolyXArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EndGameMonopolyX(
          key: args.key,
          players: args.players,
        ),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameScreen(
          key: args.key,
          version: args.version,
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
/// [_i1.ElectronicGameScreen]
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
/// [_i2.EndGameMonopolyX]
class EndGameMonopolyX extends _i5.PageRouteInfo<EndGameMonopolyXArgs> {
  EndGameMonopolyX({
    _i6.Key? key,
    required List<_i7.MonopolyPlayerX> players,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          EndGameMonopolyX.name,
          args: EndGameMonopolyXArgs(
            key: key,
            players: players,
          ),
          initialChildren: children,
        );

  static const String name = 'EndGameMonopolyX';

  static const _i5.PageInfo<EndGameMonopolyXArgs> page =
      _i5.PageInfo<EndGameMonopolyXArgs>(name);
}

class EndGameMonopolyXArgs {
  const EndGameMonopolyXArgs({
    this.key,
    required this.players,
  });

  final _i6.Key? key;

  final List<_i7.MonopolyPlayerX> players;

  @override
  String toString() {
    return 'EndGameMonopolyXArgs{key: $key, players: $players}';
  }
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i5.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i6.Key? key,
    required _i8.GameVersions version,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            version: version,
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
    required this.version,
  });

  final _i6.Key? key;

  final _i8.GameVersions version;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, version: $version}';
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
