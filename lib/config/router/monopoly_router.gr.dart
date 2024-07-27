// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:monopoly_banker/config/utils/game_versions_support.dart' as _i9;
import 'package:monopoly_banker/data/model/monopoly_player.dart' as _i8;
import 'package:monopoly_banker/interface/views/eletronic_game/eletronic_game_screen.dart'
    as _i1;
import 'package:monopoly_banker/interface/views/eletronic_game/end_game.dart'
    as _i2;
import 'package:monopoly_banker/interface/views/eletronic_game/game_screen.dart'
    as _i3;
import 'package:monopoly_banker/interface/views/eletronic_game/session_games_screen.dart'
    as _i4;
import 'package:monopoly_banker/interface/views/home_screen.dart' as _i5;

abstract class $MonopolyRouter extends _i6.RootStackRouter {
  $MonopolyRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ElectronicGameRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ElectronicGameScreen(),
      );
    },
    EndGameMonopolyX.name: (routeData) {
      final args = routeData.argsAs<EndGameMonopolyXArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EndGameMonopolyX(
          key: args.key,
          players: args.players,
          sessionId: args.sessionId,
        ),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameScreen(
          key: args.key,
          version: args.version,
          isNewGame: args.startGame,
        ),
      );
    },
    GameSessionsRoute.name: (routeData) {
      final args = routeData.argsAs<GameSessionsRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.GameSessionsScreen(
          key: args.key,
          version: args.version,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ElectronicGameScreen]
class ElectronicGameRoute extends _i6.PageRouteInfo<void> {
  const ElectronicGameRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ElectronicGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'ElectronicGameRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EndGameMonopolyX]
class EndGameMonopolyX extends _i6.PageRouteInfo<EndGameMonopolyXArgs> {
  EndGameMonopolyX({
    _i7.Key? key,
    required List<_i8.MonopolyPlayerX> players,
    required int sessionId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          EndGameMonopolyX.name,
          args: EndGameMonopolyXArgs(
            key: key,
            players: players,
            sessionId: sessionId,
          ),
          initialChildren: children,
        );

  static const String name = 'EndGameMonopolyX';

  static const _i6.PageInfo<EndGameMonopolyXArgs> page =
      _i6.PageInfo<EndGameMonopolyXArgs>(name);
}

class EndGameMonopolyXArgs {
  const EndGameMonopolyXArgs({
    this.key,
    required this.players,
    required this.sessionId,
  });

  final _i7.Key? key;

  final List<_i8.MonopolyPlayerX> players;

  final int sessionId;

  @override
  String toString() {
    return 'EndGameMonopolyXArgs{key: $key, players: $players, sessionId: $sessionId}';
  }
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i6.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i7.Key? key,
    required _i9.GameVersions version,
    bool startGame = false,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            version: version,
            startGame: startGame,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i6.PageInfo<GameRouteArgs> page =
      _i6.PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.version,
    this.startGame = false,
  });

  final _i7.Key? key;

  final _i9.GameVersions version;

  final bool startGame;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, version: $version, isNewGame: $startGame}';
  }
}

/// generated route for
/// [_i4.GameSessionsScreen]
class GameSessionsRoute extends _i6.PageRouteInfo<GameSessionsRouteArgs> {
  GameSessionsRoute({
    _i7.Key? key,
    required _i9.GameVersions version,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          GameSessionsRoute.name,
          args: GameSessionsRouteArgs(
            key: key,
            version: version,
          ),
          initialChildren: children,
        );

  static const String name = 'GameSessionsRoute';

  static const _i6.PageInfo<GameSessionsRouteArgs> page =
      _i6.PageInfo<GameSessionsRouteArgs>(name);
}

class GameSessionsRouteArgs {
  const GameSessionsRouteArgs({
    this.key,
    required this.version,
  });

  final _i7.Key? key;

  final _i9.GameVersions version;

  @override
  String toString() {
    return 'GameSessionsRouteArgs{key: $key, version: $version}';
  }
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
