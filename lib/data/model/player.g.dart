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
    )
  },
  estimateSize: _monopolyPlayerEstimateSize,
  serialize: _monopolyPlayerSerialize,
  deserialize: _monopolyPlayerDeserialize,
  deserializeProp: _monopolyPlayerDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'houses': LinkSchema(
      id: -2829006424917851982,
      name: r'houses',
      target: r'House',
      single: false,
    ),
    r'services': LinkSchema(
      id: -7299397816333744861,
      name: r'services',
      target: r'CompanyService',
      single: false,
    ),
    r'railways': LinkSchema(
      id: 3891478909261479859,
      name: r'railways',
      target: r'RailWay',
      single: false,
    )
  },
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monopolyPlayerGetId(MonopolyPlayer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monopolyPlayerGetLinks(MonopolyPlayer object) {
  return [object.houses, object.services, object.railways];
}

void _monopolyPlayerAttach(
    IsarCollection<dynamic> col, Id id, MonopolyPlayer object) {
  object.id = id;
  object.houses.attach(col, col.isar.collection<House>(), r'houses', id);
  object.services
      .attach(col, col.isar.collection<CompanyService>(), r'services', id);
  object.railways.attach(col, col.isar.collection<RailWay>(), r'railways', id);
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
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QFilterCondition> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> houses(
      FilterQuery<House> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'houses');
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'houses', length, true, length, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'houses', 0, true, 0, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'houses', 0, false, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'houses', 0, true, length, include);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'houses', length, include, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      housesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'houses', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> services(
      FilterQuery<CompanyService> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'services');
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'services', length, true, length, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'services', 0, true, 0, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'services', 0, false, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'services', 0, true, length, include);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'services', length, include, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      servicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'services', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition> railways(
      FilterQuery<RailWay> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'railways');
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'railways', length, true, length, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'railways', 0, true, 0, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'railways', 0, false, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'railways', 0, true, length, include);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'railways', length, include, 999999, true);
    });
  }

  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QAfterFilterCondition>
      railwaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'railways', lower, includeLower, upper, includeUpper);
    });
  }
}

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
}

extension MonopolyPlayerQueryWhereDistinct
    on QueryBuilder<MonopolyPlayer, MonopolyPlayer, QDistinct> {
  QueryBuilder<MonopolyPlayer, MonopolyPlayer, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
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
}
