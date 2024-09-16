// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:monopoly_banker/config/utils/game_versions_support.dart'
    as _i10;
import 'package:monopoly_banker/data/model/player.dart' as _i8;
import 'package:monopoly_banker/data/model/session.dart' as _i9;
import 'package:monopoly_banker/interface/views/electronic_v2/end_game_v2.dart'
    as _i2;
import 'package:monopoly_banker/interface/views/eletronic_game/eletronic_game_screen.dart'
    as _i1;
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
    EndGameElectronicV2.name: (routeData) {
      final args = routeData.argsAs<EndGameElectronicV2Args>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EndGameElectronicV2(
          key: args.key,
          players: args.players,
          session: args.session,
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
          isNewGame: args.isNewGame,
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
/// [_i2.EndGameElectronicV2]
class EndGameElectronicV2 extends _i6.PageRouteInfo<EndGameElectronicV2Args> {
  EndGameElectronicV2({
    _i7.Key? key,
    required List<_i8.MonopolyPlayer> players,
    required _i9.GameSessions session,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          EndGameElectronicV2.name,
          args: EndGameElectronicV2Args(
            key: key,
            players: players,
            session: session,
          ),
          initialChildren: children,
        );

  static const String name = 'EndGameElectronicV2';

  static const _i6.PageInfo<EndGameElectronicV2Args> page =
      _i6.PageInfo<EndGameElectronicV2Args>(name);
}

class EndGameElectronicV2Args {
  const EndGameElectronicV2Args({
    this.key,
    required this.players,
    required this.session,
  });

  final _i7.Key? key;

  final List<_i8.MonopolyPlayer> players;

  final _i9.GameSessions session;

  @override
  String toString() {
    return 'EndGameElectronicV2Args{key: $key, players: $players, session: $session}';
  }
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i6.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i7.Key? key,
    required _i10.GameVersions version,
    bool isNewGame = false,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            version: version,
            isNewGame: isNewGame,
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
    this.isNewGame = false,
  });

  final _i7.Key? key;

  final _i10.GameVersions version;

  final bool isNewGame;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, version: $version, isNewGame: $isNewGame}';
  }
}

/// generated route for
/// [_i4.GameSessionsScreen]
class GameSessionsRoute extends _i6.PageRouteInfo<GameSessionsRouteArgs> {
  GameSessionsRoute({
    _i7.Key? key,
    required _i10.GameVersions version,
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

  final _i10.GameVersions version;

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
