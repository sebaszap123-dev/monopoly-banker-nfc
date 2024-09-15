// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonopolyPlayerCollection on Isar {
  IsarCollection<MonopolyPlayer> get monopolyPlayers => this.collection();
}

const MonopolyPlayerSchema = CollectionSchema(
  name: r'MonopolyPlayer',
  id: 3880507704806458618,
  properties: {
    r'card': PropertySchema(
      id: 0,
      name: r'card',
      type: IsarType.object,
      target: r'MonopolyCardV2',
    ),
    r'money': PropertySchema(
      id: 1,
      name: r'money',
      type: IsarType.object,
      target: r'Money',
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'sessionId': PropertySchema(
      id: 3,
      name: r'sessionId',
      type: IsarType.long,
    )
  },
  estimateSize: _monopolyPlayerEstimateSize,
  serialize: _monopolyPlayerSerialize,
  deserialize: _monopolyPlayerDeserialize,
  deserializeProp: _monopolyPlayerDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'MonopolyCardV2': MonopolyCardV2Schema,
    r'Money': MoneySchema
  },
  getId: _monopolyPlayerGetId,
  getLinks: _monopolyPlayerGetLinks,
  attach: _monopolyPlayerAttach,
  version: '3.1.0+1',
);

int _monopolyPlayerEstimateSize(
  MonopolyPlayer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.card;
    if (value != null) {
      bytesCount += 3 +
          MonopolyCardV2Schema.estimateSize(
              value, allOffsets[MonopolyCardV2]!, allOffsets);
    }
  }
  bytesCount += 3 +
      MoneySchema.estimateSize(object.money, allOffsets[Money]!, allOffsets);
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _monopolyPlayerSerialize(
  MonopolyPlayer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<MonopolyCardV2>(
    offsets[0],
    allOffsets,
    MonopolyCardV2Schema.serialize,
    object.card,
  );
  writer.writeObject<Money>(
    offsets[1],
    allOffsets,
    MoneySchema.serialize,
    object.money,
  );
  writer.writeString(offsets[2], object.name);
  writer.writeLong(offsets[3], object.sessionId);
}

MonopolyPlayer _monopolyPlayerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonopolyPlayer();
  object.card = reader.readObjectOrNull<MonopolyCardV2>(
    offsets[0],
    MonopolyCardV2Schema.deserialize,
    allOffsets,
  );
  object.id = id;
  object.money = reader.readObjectOrNull<Money>(
        offsets[1],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.name = reader.readStringOrNull(offsets[2]);
  object.sessionId = reader.readLong(offsets[3]);
  return object;
}

P _monopolyPlayerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<MonopolyCardV2>(
        offset,
        MonopolyCardV2Schema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monopolyPlayerGetId(MonopolyPlayer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monopolyPlayerGetLinks(MonopolyPlayer object) {
  return [];
}

void _monopolyPlayerAttach(
    IsarCollection<dynamic> col, Id id, MonopolyPlayer object) {
  object.id = id;
}

extension MonopolyPlayerQueryWhereSort
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QWhere> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonopolyPlayerQueryWhere
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QWhereClause> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterWhereClause> idBetween(
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

extension MonopolyPlayerQueryFilter
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QFilterCondition> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      cardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'card',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      cardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'card',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      sessionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      sessionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      sessionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionId',
        value: value,
      ));
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      sessionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonopolyPlayerQueryObject
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QFilterCondition> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> card(
      FilterQuery<MonopolyCardV2> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'card');
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> money(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'money');
    });
  }
}

extension MonopolyPlayerQueryLinks
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QFilterCondition> {}

extension MonopolyPlayerQuerySortBy
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QSortBy> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> sortBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy>
      sortBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }
}

extension MonopolyPlayerQuerySortThenBy
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QSortThenBy> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy> thenBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterSortBy>
      thenBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }
}

extension MonopolyPlayerQueryWhereDistinct
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QDistinct> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QDistinct>
      distinctBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionId');
    });
  }
}

extension MonopolyPlayerQueryProperty
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QQueryProperty> {
  QueryBuilder<MonopolyPlayer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyCardV2?, QQueryOperations>
      cardProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'card');
    });
  }

  QueryBuilder<MonopolyPlayer, Money, QQueryOperations> moneyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'money');
    });
  }

  QueryBuilder<MonopolyPlayer, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MonopolyPlayer, int, QQueryOperations> sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionId');
    });
  }
}
