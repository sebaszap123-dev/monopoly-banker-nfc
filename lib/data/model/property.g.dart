// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHouseCollection on Isar {
  IsarCollection<House> get houses => this.collection();
}

const HouseSchema = CollectionSchema(
  name: r'House',
  id: 4171657115034592655,
  properties: {
    r'casa1': PropertySchema(
      id: 0,
      name: r'casa1',
      type: IsarType.object,
      target: r'Money',
    ),
    r'casa2': PropertySchema(
      id: 1,
      name: r'casa2',
      type: IsarType.object,
      target: r'Money',
    ),
    r'casa3': PropertySchema(
      id: 2,
      name: r'casa3',
      type: IsarType.object,
      target: r'Money',
    ),
    r'casa4': PropertySchema(
      id: 3,
      name: r'casa4',
      type: IsarType.object,
      target: r'Money',
    ),
    r'hotel': PropertySchema(
      id: 4,
      name: r'hotel',
      type: IsarType.object,
      target: r'Money',
    ),
    r'houseCost': PropertySchema(
      id: 5,
      name: r'houseCost',
      type: IsarType.object,
      target: r'Money',
    ),
    r'houses': PropertySchema(
      id: 6,
      name: r'houses',
      type: IsarType.long,
    ),
    r'isMortgage': PropertySchema(
      id: 7,
      name: r'isMortgage',
      type: IsarType.bool,
    ),
    r'mortgage': PropertySchema(
      id: 8,
      name: r'mortgage',
      type: IsarType.object,
      target: r'Money',
    ),
    r'propertyGroup': PropertySchema(
      id: 9,
      name: r'propertyGroup',
      type: IsarType.byte,
      enumMap: _HousepropertyGroupEnumValueMap,
    ),
    r'rent': PropertySchema(
      id: 10,
      name: r'rent',
      type: IsarType.object,
      target: r'Money',
    ),
    r'title': PropertySchema(
      id: 11,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _houseEstimateSize,
  serialize: _houseSerialize,
  deserialize: _houseDeserialize,
  deserializeProp: _houseDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _houseGetId,
  getLinks: _houseGetLinks,
  attach: _houseAttach,
  version: '3.1.0+1',
);

int _houseEstimateSize(
  House object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MoneySchema.estimateSize(object.casa1, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.casa2, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.casa3, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.casa4, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.hotel, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(
          object.houseCost, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.mortgage, allOffsets[Money]!, allOffsets);
  bytesCount +=
      3 + MoneySchema.estimateSize(object.rent, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _houseSerialize(
  House object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Money>(
    offsets[0],
    allOffsets,
    MoneySchema.serialize,
    object.casa1,
  );
  writer.writeObject<Money>(
    offsets[1],
    allOffsets,
    MoneySchema.serialize,
    object.casa2,
  );
  writer.writeObject<Money>(
    offsets[2],
    allOffsets,
    MoneySchema.serialize,
    object.casa3,
  );
  writer.writeObject<Money>(
    offsets[3],
    allOffsets,
    MoneySchema.serialize,
    object.casa4,
  );
  writer.writeObject<Money>(
    offsets[4],
    allOffsets,
    MoneySchema.serialize,
    object.hotel,
  );
  writer.writeObject<Money>(
    offsets[5],
    allOffsets,
    MoneySchema.serialize,
    object.houseCost,
  );
  writer.writeLong(offsets[6], object.houses);
  writer.writeBool(offsets[7], object.isMortgage);
  writer.writeObject<Money>(
    offsets[8],
    allOffsets,
    MoneySchema.serialize,
    object.mortgage,
  );
  writer.writeByte(offsets[9], object.propertyGroup.index);
  writer.writeObject<Money>(
    offsets[10],
    allOffsets,
    MoneySchema.serialize,
    object.rent,
  );
  writer.writeString(offsets[11], object.title);
}

House _houseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = House();
  object.casa1 = reader.readObjectOrNull<Money>(
        offsets[0],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.casa2 = reader.readObjectOrNull<Money>(
        offsets[1],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.casa3 = reader.readObjectOrNull<Money>(
        offsets[2],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.casa4 = reader.readObjectOrNull<Money>(
        offsets[3],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.hotel = reader.readObjectOrNull<Money>(
        offsets[4],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.houseCost = reader.readObjectOrNull<Money>(
        offsets[5],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.houses = reader.readLong(offsets[6]);
  object.id = id;
  object.isMortgage = reader.readBool(offsets[7]);
  object.mortgage = reader.readObjectOrNull<Money>(
        offsets[8],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.propertyGroup =
      _HousepropertyGroupValueEnumMap[reader.readByteOrNull(offsets[9])] ??
          PropertyType.coffee;
  object.rent = reader.readObjectOrNull<Money>(
        offsets[10],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.title = reader.readString(offsets[11]);
  return object;
}

P _houseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 1:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 2:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 3:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 4:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 5:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 9:
      return (_HousepropertyGroupValueEnumMap[reader.readByteOrNull(offset)] ??
          PropertyType.coffee) as P;
    case 10:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _HousepropertyGroupEnumValueMap = {
  'coffee': 0,
  'skyBlue': 1,
  'magenta': 2,
  'orange': 3,
  'red': 4,
  'yellow': 5,
  'green': 6,
  'blue': 7,
  'services': 8,
  'ferro': 9,
};
const _HousepropertyGroupValueEnumMap = {
  0: PropertyType.coffee,
  1: PropertyType.skyBlue,
  2: PropertyType.magenta,
  3: PropertyType.orange,
  4: PropertyType.red,
  5: PropertyType.yellow,
  6: PropertyType.green,
  7: PropertyType.blue,
  8: PropertyType.services,
  9: PropertyType.ferro,
};

Id _houseGetId(House object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _houseGetLinks(House object) {
  return [];
}

void _houseAttach(IsarCollection<dynamic> col, Id id, House object) {
  object.id = id;
}

extension HouseQueryWhereSort on QueryBuilder<House, House, QWhere> {
  QueryBuilder<House, House, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HouseQueryWhere on QueryBuilder<House, House, QWhereClause> {
  QueryBuilder<House, House, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<House, House, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<House, House, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<House, House, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<House, House, QAfterWhereClause> idBetween(
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

  QueryBuilder<House, House, QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<House, House, QAfterWhereClause> titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HouseQueryFilter on QueryBuilder<House, House, QFilterCondition> {
  QueryBuilder<House, House, QAfterFilterCondition> housesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'houses',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> housesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'houses',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> housesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'houses',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> housesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'houses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<House, House, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<House, House, QAfterFilterCondition> idBetween(
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

  QueryBuilder<House, House, QAfterFilterCondition> isMortgageEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMortgage',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> propertyGroupEqualTo(
      PropertyType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> propertyGroupGreaterThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> propertyGroupLessThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> propertyGroupBetween(
    PropertyType lower,
    PropertyType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propertyGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension HouseQueryObject on QueryBuilder<House, House, QFilterCondition> {
  QueryBuilder<House, House, QAfterFilterCondition> casa1(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'casa1');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> casa2(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'casa2');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> casa3(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'casa3');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> casa4(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'casa4');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> hotel(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'hotel');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> houseCost(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'houseCost');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> mortgage(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mortgage');
    });
  }

  QueryBuilder<House, House, QAfterFilterCondition> rent(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rent');
    });
  }
}

extension HouseQueryLinks on QueryBuilder<House, House, QFilterCondition> {}

extension HouseQuerySortBy on QueryBuilder<House, House, QSortBy> {
  QueryBuilder<House, House, QAfterSortBy> sortByHouses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'houses', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByHousesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'houses', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HouseQuerySortThenBy on QueryBuilder<House, House, QSortThenBy> {
  QueryBuilder<House, House, QAfterSortBy> thenByHouses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'houses', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByHousesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'houses', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<House, House, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HouseQueryWhereDistinct on QueryBuilder<House, House, QDistinct> {
  QueryBuilder<House, House, QDistinct> distinctByHouses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'houses');
    });
  }

  QueryBuilder<House, House, QDistinct> distinctByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMortgage');
    });
  }

  QueryBuilder<House, House, QDistinct> distinctByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propertyGroup');
    });
  }

  QueryBuilder<House, House, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension HouseQueryProperty on QueryBuilder<House, House, QQueryProperty> {
  QueryBuilder<House, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> casa1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'casa1');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> casa2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'casa2');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> casa3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'casa3');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> casa4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'casa4');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> hotelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotel');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> houseCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'houseCost');
    });
  }

  QueryBuilder<House, int, QQueryOperations> housesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'houses');
    });
  }

  QueryBuilder<House, bool, QQueryOperations> isMortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMortgage');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> mortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mortgage');
    });
  }

  QueryBuilder<House, PropertyType, QQueryOperations> propertyGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propertyGroup');
    });
  }

  QueryBuilder<House, Money, QQueryOperations> rentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rent');
    });
  }

  QueryBuilder<House, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanyServiceCollection on Isar {
  IsarCollection<CompanyService> get companyServices => this.collection();
}

const CompanyServiceSchema = CollectionSchema(
  name: r'CompanyService',
  id: 8065321481123777007,
  properties: {
    r'isMortgage': PropertySchema(
      id: 0,
      name: r'isMortgage',
      type: IsarType.bool,
    ),
    r'isRentMultipliedBy10': PropertySchema(
      id: 1,
      name: r'isRentMultipliedBy10',
      type: IsarType.bool,
    ),
    r'mortgage': PropertySchema(
      id: 2,
      name: r'mortgage',
      type: IsarType.object,
      target: r'Money',
    ),
    r'propertyGroup': PropertySchema(
      id: 3,
      name: r'propertyGroup',
      type: IsarType.byte,
      enumMap: _CompanyServicepropertyGroupEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _companyServiceEstimateSize,
  serialize: _companyServiceSerialize,
  deserialize: _companyServiceDeserialize,
  deserializeProp: _companyServiceDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _companyServiceGetId,
  getLinks: _companyServiceGetLinks,
  attach: _companyServiceAttach,
  version: '3.1.0+1',
);

int _companyServiceEstimateSize(
  CompanyService object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MoneySchema.estimateSize(object.mortgage, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _companyServiceSerialize(
  CompanyService object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isMortgage);
  writer.writeBool(offsets[1], object.isRentMultipliedBy10);
  writer.writeObject<Money>(
    offsets[2],
    allOffsets,
    MoneySchema.serialize,
    object.mortgage,
  );
  writer.writeByte(offsets[3], object.propertyGroup.index);
  writer.writeString(offsets[4], object.title);
}

CompanyService _companyServiceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompanyService();
  object.id = id;
  object.isMortgage = reader.readBool(offsets[0]);
  object.isRentMultipliedBy10 = reader.readBool(offsets[1]);
  object.mortgage = reader.readObjectOrNull<Money>(
        offsets[2],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.propertyGroup = _CompanyServicepropertyGroupValueEnumMap[
          reader.readByteOrNull(offsets[3])] ??
      PropertyType.coffee;
  object.title = reader.readString(offsets[4]);
  return object;
}

P _companyServiceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 3:
      return (_CompanyServicepropertyGroupValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PropertyType.coffee) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CompanyServicepropertyGroupEnumValueMap = {
  'coffee': 0,
  'skyBlue': 1,
  'magenta': 2,
  'orange': 3,
  'red': 4,
  'yellow': 5,
  'green': 6,
  'blue': 7,
  'services': 8,
  'ferro': 9,
};
const _CompanyServicepropertyGroupValueEnumMap = {
  0: PropertyType.coffee,
  1: PropertyType.skyBlue,
  2: PropertyType.magenta,
  3: PropertyType.orange,
  4: PropertyType.red,
  5: PropertyType.yellow,
  6: PropertyType.green,
  7: PropertyType.blue,
  8: PropertyType.services,
  9: PropertyType.ferro,
};

Id _companyServiceGetId(CompanyService object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companyServiceGetLinks(CompanyService object) {
  return [];
}

void _companyServiceAttach(
    IsarCollection<dynamic> col, Id id, CompanyService object) {
  object.id = id;
}

extension CompanyServiceQueryWhereSort
    on QueryBuilder<CompanyService, CompanyService, QWhere> {
  QueryBuilder<CompanyService, CompanyService, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompanyServiceQueryWhere
    on QueryBuilder<CompanyService, CompanyService, QWhereClause> {
  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> idBetween(
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

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause> titleEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterWhereClause>
      titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CompanyServiceQueryFilter
    on QueryBuilder<CompanyService, CompanyService, QFilterCondition> {
  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
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

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
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

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      isMortgageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMortgage',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      isRentMultipliedBy10EqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRentMultipliedBy10',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      propertyGroupEqualTo(PropertyType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      propertyGroupGreaterThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      propertyGroupLessThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      propertyGroupBetween(
    PropertyType lower,
    PropertyType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propertyGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension CompanyServiceQueryObject
    on QueryBuilder<CompanyService, CompanyService, QFilterCondition> {
  QueryBuilder<CompanyService, CompanyService, QAfterFilterCondition> mortgage(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mortgage');
    });
  }
}

extension CompanyServiceQueryLinks
    on QueryBuilder<CompanyService, CompanyService, QFilterCondition> {}

extension CompanyServiceQuerySortBy
    on QueryBuilder<CompanyService, CompanyService, QSortBy> {
  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByIsRentMultipliedBy10() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRentMultipliedBy10', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByIsRentMultipliedBy10Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRentMultipliedBy10', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      sortByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CompanyServiceQuerySortThenBy
    on QueryBuilder<CompanyService, CompanyService, QSortThenBy> {
  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByIsRentMultipliedBy10() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRentMultipliedBy10', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByIsRentMultipliedBy10Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRentMultipliedBy10', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy>
      thenByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CompanyService, CompanyService, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CompanyServiceQueryWhereDistinct
    on QueryBuilder<CompanyService, CompanyService, QDistinct> {
  QueryBuilder<CompanyService, CompanyService, QDistinct>
      distinctByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMortgage');
    });
  }

  QueryBuilder<CompanyService, CompanyService, QDistinct>
      distinctByIsRentMultipliedBy10() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRentMultipliedBy10');
    });
  }

  QueryBuilder<CompanyService, CompanyService, QDistinct>
      distinctByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propertyGroup');
    });
  }

  QueryBuilder<CompanyService, CompanyService, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension CompanyServiceQueryProperty
    on QueryBuilder<CompanyService, CompanyService, QQueryProperty> {
  QueryBuilder<CompanyService, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompanyService, bool, QQueryOperations> isMortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMortgage');
    });
  }

  QueryBuilder<CompanyService, bool, QQueryOperations>
      isRentMultipliedBy10Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRentMultipliedBy10');
    });
  }

  QueryBuilder<CompanyService, Money, QQueryOperations> mortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mortgage');
    });
  }

  QueryBuilder<CompanyService, PropertyType, QQueryOperations>
      propertyGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propertyGroup');
    });
  }

  QueryBuilder<CompanyService, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRailWayCollection on Isar {
  IsarCollection<RailWay> get railWays => this.collection();
}

const RailWaySchema = CollectionSchema(
  name: r'RailWay',
  id: -2879410480986986948,
  properties: {
    r'isMortgage': PropertySchema(
      id: 0,
      name: r'isMortgage',
      type: IsarType.bool,
    ),
    r'mortgage': PropertySchema(
      id: 1,
      name: r'mortgage',
      type: IsarType.object,
      target: r'Money',
    ),
    r'own2': PropertySchema(
      id: 2,
      name: r'own2',
      type: IsarType.object,
      target: r'Money',
    ),
    r'own3': PropertySchema(
      id: 3,
      name: r'own3',
      type: IsarType.object,
      target: r'Money',
    ),
    r'own4': PropertySchema(
      id: 4,
      name: r'own4',
      type: IsarType.object,
      target: r'Money',
    ),
    r'propertyGroup': PropertySchema(
      id: 5,
      name: r'propertyGroup',
      type: IsarType.byte,
      enumMap: _RailWaypropertyGroupEnumValueMap,
    ),
    r'rent': PropertySchema(
      id: 6,
      name: r'rent',
      type: IsarType.object,
      target: r'Money',
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _railWayEstimateSize,
  serialize: _railWaySerialize,
  deserialize: _railWayDeserialize,
  deserializeProp: _railWayDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _railWayGetId,
  getLinks: _railWayGetLinks,
  attach: _railWayAttach,
  version: '3.1.0+1',
);

int _railWayEstimateSize(
  RailWay object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MoneySchema.estimateSize(object.mortgage, allOffsets[Money]!, allOffsets);
  bytesCount +=
      3 + MoneySchema.estimateSize(object.own2, allOffsets[Money]!, allOffsets);
  bytesCount +=
      3 + MoneySchema.estimateSize(object.own3, allOffsets[Money]!, allOffsets);
  bytesCount +=
      3 + MoneySchema.estimateSize(object.own4, allOffsets[Money]!, allOffsets);
  bytesCount +=
      3 + MoneySchema.estimateSize(object.rent, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _railWaySerialize(
  RailWay object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isMortgage);
  writer.writeObject<Money>(
    offsets[1],
    allOffsets,
    MoneySchema.serialize,
    object.mortgage,
  );
  writer.writeObject<Money>(
    offsets[2],
    allOffsets,
    MoneySchema.serialize,
    object.own2,
  );
  writer.writeObject<Money>(
    offsets[3],
    allOffsets,
    MoneySchema.serialize,
    object.own3,
  );
  writer.writeObject<Money>(
    offsets[4],
    allOffsets,
    MoneySchema.serialize,
    object.own4,
  );
  writer.writeByte(offsets[5], object.propertyGroup.index);
  writer.writeObject<Money>(
    offsets[6],
    allOffsets,
    MoneySchema.serialize,
    object.rent,
  );
  writer.writeString(offsets[7], object.title);
}

RailWay _railWayDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RailWay();
  object.id = id;
  object.isMortgage = reader.readBool(offsets[0]);
  object.mortgage = reader.readObjectOrNull<Money>(
        offsets[1],
        MoneySchema.deserialize,
        allOffsets,
      ) ??
      Money();
  object.propertyGroup =
      _RailWaypropertyGroupValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          PropertyType.coffee;
  object.title = reader.readString(offsets[7]);
  return object;
}

P _railWayDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 2:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 3:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 4:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 5:
      return (_RailWaypropertyGroupValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PropertyType.coffee) as P;
    case 6:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RailWaypropertyGroupEnumValueMap = {
  'coffee': 0,
  'skyBlue': 1,
  'magenta': 2,
  'orange': 3,
  'red': 4,
  'yellow': 5,
  'green': 6,
  'blue': 7,
  'services': 8,
  'ferro': 9,
};
const _RailWaypropertyGroupValueEnumMap = {
  0: PropertyType.coffee,
  1: PropertyType.skyBlue,
  2: PropertyType.magenta,
  3: PropertyType.orange,
  4: PropertyType.red,
  5: PropertyType.yellow,
  6: PropertyType.green,
  7: PropertyType.blue,
  8: PropertyType.services,
  9: PropertyType.ferro,
};

Id _railWayGetId(RailWay object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _railWayGetLinks(RailWay object) {
  return [];
}

void _railWayAttach(IsarCollection<dynamic> col, Id id, RailWay object) {
  object.id = id;
}

extension RailWayQueryWhereSort on QueryBuilder<RailWay, RailWay, QWhere> {
  QueryBuilder<RailWay, RailWay, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RailWayQueryWhere on QueryBuilder<RailWay, RailWay, QWhereClause> {
  QueryBuilder<RailWay, RailWay, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> idBetween(
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

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterWhereClause> titleNotEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RailWayQueryFilter
    on QueryBuilder<RailWay, RailWay, QFilterCondition> {
  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> isMortgageEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMortgage',
        value: value,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> propertyGroupEqualTo(
      PropertyType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition>
      propertyGroupGreaterThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> propertyGroupLessThan(
    PropertyType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propertyGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> propertyGroupBetween(
    PropertyType lower,
    PropertyType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propertyGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension RailWayQueryObject
    on QueryBuilder<RailWay, RailWay, QFilterCondition> {
  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> mortgage(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mortgage');
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> own2(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'own2');
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> own3(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'own3');
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> own4(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'own4');
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterFilterCondition> rent(
      FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rent');
    });
  }
}

extension RailWayQueryLinks
    on QueryBuilder<RailWay, RailWay, QFilterCondition> {}

extension RailWayQuerySortBy on QueryBuilder<RailWay, RailWay, QSortBy> {
  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RailWayQuerySortThenBy
    on QueryBuilder<RailWay, RailWay, QSortThenBy> {
  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByIsMortgageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMortgage', Sort.desc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByPropertyGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propertyGroup', Sort.desc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RailWay, RailWay, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RailWayQueryWhereDistinct
    on QueryBuilder<RailWay, RailWay, QDistinct> {
  QueryBuilder<RailWay, RailWay, QDistinct> distinctByIsMortgage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMortgage');
    });
  }

  QueryBuilder<RailWay, RailWay, QDistinct> distinctByPropertyGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propertyGroup');
    });
  }

  QueryBuilder<RailWay, RailWay, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension RailWayQueryProperty
    on QueryBuilder<RailWay, RailWay, QQueryProperty> {
  QueryBuilder<RailWay, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RailWay, bool, QQueryOperations> isMortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMortgage');
    });
  }

  QueryBuilder<RailWay, Money, QQueryOperations> mortgageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mortgage');
    });
  }

  QueryBuilder<RailWay, Money, QQueryOperations> own2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'own2');
    });
  }

  QueryBuilder<RailWay, Money, QQueryOperations> own3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'own3');
    });
  }

  QueryBuilder<RailWay, Money, QQueryOperations> own4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'own4');
    });
  }

  QueryBuilder<RailWay, PropertyType, QQueryOperations>
      propertyGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propertyGroup');
    });
  }

  QueryBuilder<RailWay, Money, QQueryOperations> rentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rent');
    });
  }

  QueryBuilder<RailWay, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
