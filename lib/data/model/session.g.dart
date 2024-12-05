// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGameSessionsCollection on Isar {
  IsarCollection<GameSessions> get gameSessions => this.collection();
}

const GameSessionsSchema = CollectionSchema(
  name: r'GameSessions',
  id: 4801948484918931928,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'playtime': PropertySchema(
      id: 1,
      name: r'playtime',
      type: IsarType.long,
    ),
    r'restoredAt': PropertySchema(
      id: 2,
      name: r'restoredAt',
      type: IsarType.dateTime,
    ),
    r'updateAt': PropertySchema(
      id: 3,
      name: r'updateAt',
      type: IsarType.dateTime,
    ),
    r'version': PropertySchema(
      id: 4,
      name: r'version',
      type: IsarType.byte,
      enumMap: _GameSessionsversionEnumValueMap,
    )
  },
  estimateSize: _gameSessionsEstimateSize,
  serialize: _gameSessionsSerialize,
  deserialize: _gameSessionsDeserialize,
  deserializeProp: _gameSessionsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'players': LinkSchema(
      id: -7655197275569420805,
      name: r'players',
      target: r'MonopolyPlayer',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _gameSessionsGetId,
  getLinks: _gameSessionsGetLinks,
  attach: _gameSessionsAttach,
  version: '3.1.0+1',
);

int _gameSessionsEstimateSize(
  GameSessions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _gameSessionsSerialize(
  GameSessions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.playtime);
  writer.writeDateTime(offsets[2], object.restoredAt);
  writer.writeDateTime(offsets[3], object.updateAt);
  writer.writeByte(offsets[4], object.version.index);
}

GameSessions _gameSessionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameSessions();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.playtime = reader.readLong(offsets[1]);
  object.restoredAt = reader.readDateTimeOrNull(offsets[2]);
  object.updateAt = reader.readDateTime(offsets[3]);
  object.version =
      _GameSessionsversionValueEnumMap[reader.readByteOrNull(offsets[4])] ??
          GameVersions.classic;
  return object;
}

P _gameSessionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (_GameSessionsversionValueEnumMap[reader.readByteOrNull(offset)] ??
          GameVersions.classic) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GameSessionsversionEnumValueMap = {
  'classic': 0,
  'electronic': 1,
};
const _GameSessionsversionValueEnumMap = {
  0: GameVersions.classic,
  1: GameVersions.electronic,
};

Id _gameSessionsGetId(GameSessions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gameSessionsGetLinks(GameSessions object) {
  return [object.players];
}

void _gameSessionsAttach(
    IsarCollection<dynamic> col, Id id, GameSessions object) {
  object.id = id;
  object.players
      .attach(col, col.isar.collection<MonopolyPlayer>(), r'players', id);
}

extension GameSessionsQueryWhereSort
    on QueryBuilder<GameSessions, GameSessions, QWhere> {
  QueryBuilder<GameSessions, GameSessions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GameSessionsQueryWhere
    on QueryBuilder<GameSessions, GameSessions, QWhereClause> {
  QueryBuilder<GameSessions, GameSessions, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GameSessionsQueryFilter
    on QueryBuilder<GameSessions, GameSessions, QFilterCondition> {
  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playtimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playtimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playtimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playtimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playtime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'restoredAt',
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'restoredAt',
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restoredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restoredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restoredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      restoredAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restoredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      updateAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      updateAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      updateAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      updateAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      versionEqualTo(GameVersions value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      versionGreaterThan(
    GameVersions value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      versionLessThan(
    GameVersions value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      versionBetween(
    GameVersions lower,
    GameVersions upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GameSessionsQueryObject
    on QueryBuilder<GameSessions, GameSessions, QFilterCondition> {}

extension GameSessionsQueryLinks
    on QueryBuilder<GameSessions, GameSessions, QFilterCondition> {
  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition> players(
      FilterQuery<MonopolyPlayer> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, true, length, true);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, 0, true);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, false, 999999, true);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, length, include);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, include, 999999, true);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterFilterCondition>
      playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'players', lower, includeLower, upper, includeUpper);
    });
  }
}

extension GameSessionsQuerySortBy
    on QueryBuilder<GameSessions, GameSessions, QSortBy> {
  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByPlaytimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByRestoredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restoredAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy>
      sortByRestoredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restoredAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension GameSessionsQuerySortThenBy
    on QueryBuilder<GameSessions, GameSessions, QSortThenBy> {
  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByPlaytimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByRestoredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restoredAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy>
      thenByRestoredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restoredAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<GameSessions, GameSessions, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension GameSessionsQueryWhereDistinct
    on QueryBuilder<GameSessions, GameSessions, QDistinct> {
  QueryBuilder<GameSessions, GameSessions, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GameSessions, GameSessions, QDistinct> distinctByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playtime');
    });
  }

  QueryBuilder<GameSessions, GameSessions, QDistinct> distinctByRestoredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restoredAt');
    });
  }

  QueryBuilder<GameSessions, GameSessions, QDistinct> distinctByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt');
    });
  }

  QueryBuilder<GameSessions, GameSessions, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension GameSessionsQueryProperty
    on QueryBuilder<GameSessions, GameSessions, QQueryProperty> {
  QueryBuilder<GameSessions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GameSessions, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GameSessions, int, QQueryOperations> playtimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playtime');
    });
  }

  QueryBuilder<GameSessions, DateTime?, QQueryOperations> restoredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restoredAt');
    });
  }

  QueryBuilder<GameSessions, DateTime, QQueryOperations> updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }

  QueryBuilder<GameSessions, GameVersions, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
