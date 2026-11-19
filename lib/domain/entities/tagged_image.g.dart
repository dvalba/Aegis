// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagged_image.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaggedImageCollection on Isar {
  IsarCollection<TaggedImage> get taggedImages => this.collection();
}

const TaggedImageSchema = CollectionSchema(
  name: r'TaggedImage',
  id: 1021534715000932030,
  properties: {
    r'imagePath': PropertySchema(
      id: 0,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'lesionId': PropertySchema(
      id: 1,
      name: r'lesionId',
      type: IsarType.long,
    ),
    r'synced': PropertySchema(
      id: 2,
      name: r'synced',
      type: IsarType.bool,
    ),
    r'tag': PropertySchema(
      id: 3,
      name: r'tag',
      type: IsarType.string,
    )
  },
  estimateSize: _taggedImageEstimateSize,
  serialize: _taggedImageSerialize,
  deserialize: _taggedImageDeserialize,
  deserializeProp: _taggedImageDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'lesionId': IndexSchema(
      id: 2385636612293826770,
      name: r'lesionId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lesionId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'synced': IndexSchema(
      id: -4832663256418428922,
      name: r'synced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'synced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _taggedImageGetId,
  getLinks: _taggedImageGetLinks,
  attach: _taggedImageAttach,
  version: '3.1.8',
);

int _taggedImageEstimateSize(
  TaggedImage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.tag.length * 3;
  return bytesCount;
}

void _taggedImageSerialize(
  TaggedImage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imagePath);
  writer.writeLong(offsets[1], object.lesionId);
  writer.writeBool(offsets[2], object.synced);
  writer.writeString(offsets[3], object.tag);
}

TaggedImage _taggedImageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaggedImage(
    imagePath: reader.readString(offsets[0]),
    synced: reader.readBoolOrNull(offsets[2]) ?? false,
    tag: reader.readString(offsets[3]),
  );
  object.isarId = id;
  object.lesionId = reader.readLong(offsets[1]);
  return object;
}

P _taggedImageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taggedImageGetId(TaggedImage object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _taggedImageGetLinks(TaggedImage object) {
  return [];
}

void _taggedImageAttach(
    IsarCollection<dynamic> col, Id id, TaggedImage object) {
  object.isarId = id;
}

extension TaggedImageQueryWhereSort
    on QueryBuilder<TaggedImage, TaggedImage, QWhere> {
  QueryBuilder<TaggedImage, TaggedImage, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhere> anyLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lesionId'),
      );
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhere> anySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'synced'),
      );
    });
  }
}

extension TaggedImageQueryWhere
    on QueryBuilder<TaggedImage, TaggedImage, QWhereClause> {
  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> lesionIdEqualTo(
      int lesionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lesionId',
        value: [lesionId],
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> lesionIdNotEqualTo(
      int lesionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lesionId',
              lower: [],
              upper: [lesionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lesionId',
              lower: [lesionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lesionId',
              lower: [lesionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lesionId',
              lower: [],
              upper: [lesionId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> lesionIdGreaterThan(
    int lesionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lesionId',
        lower: [lesionId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> lesionIdLessThan(
    int lesionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lesionId',
        lower: [],
        upper: [lesionId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> lesionIdBetween(
    int lowerLesionId,
    int upperLesionId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lesionId',
        lower: [lowerLesionId],
        includeLower: includeLower,
        upper: [upperLesionId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> syncedEqualTo(
      bool synced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'synced',
        value: [synced],
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterWhereClause> syncedNotEqualTo(
      bool synced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [],
              upper: [synced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [synced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [synced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [],
              upper: [synced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TaggedImageQueryFilter
    on QueryBuilder<TaggedImage, TaggedImage, QFilterCondition> {
  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> lesionIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lesionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      lesionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lesionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      lesionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lesionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> lesionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lesionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition> tagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterFilterCondition>
      tagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tag',
        value: '',
      ));
    });
  }
}

extension TaggedImageQueryObject
    on QueryBuilder<TaggedImage, TaggedImage, QFilterCondition> {}

extension TaggedImageQueryLinks
    on QueryBuilder<TaggedImage, TaggedImage, QFilterCondition> {}

extension TaggedImageQuerySortBy
    on QueryBuilder<TaggedImage, TaggedImage, QSortBy> {
  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByLesionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> sortByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }
}

extension TaggedImageQuerySortThenBy
    on QueryBuilder<TaggedImage, TaggedImage, QSortThenBy> {
  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByLesionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QAfterSortBy> thenByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }
}

extension TaggedImageQueryWhereDistinct
    on QueryBuilder<TaggedImage, TaggedImage, QDistinct> {
  QueryBuilder<TaggedImage, TaggedImage, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QDistinct> distinctByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lesionId');
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }

  QueryBuilder<TaggedImage, TaggedImage, QDistinct> distinctByTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tag', caseSensitive: caseSensitive);
    });
  }
}

extension TaggedImageQueryProperty
    on QueryBuilder<TaggedImage, TaggedImage, QQueryProperty> {
  QueryBuilder<TaggedImage, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<TaggedImage, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<TaggedImage, int, QQueryOperations> lesionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lesionId');
    });
  }

  QueryBuilder<TaggedImage, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }

  QueryBuilder<TaggedImage, String, QQueryOperations> tagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tag');
    });
  }
}
