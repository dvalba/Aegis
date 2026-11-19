// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_diagnosis.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAutoDiagnosisCollection on Isar {
  IsarCollection<AutoDiagnosis> get autoDiagnosis => this.collection();
}

const AutoDiagnosisSchema = CollectionSchema(
  name: r'AutoDiagnosis',
  id: -2885587011148830925,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'diagnosis': PropertySchema(
      id: 1,
      name: r'diagnosis',
      type: IsarType.stringList,
    ),
    r'lesionId': PropertySchema(
      id: 2,
      name: r'lesionId',
      type: IsarType.long,
    ),
    r'modelTag': PropertySchema(
      id: 3,
      name: r'modelTag',
      type: IsarType.string,
    ),
    r'probability': PropertySchema(
      id: 4,
      name: r'probability',
      type: IsarType.doubleList,
    )
  },
  estimateSize: _autoDiagnosisEstimateSize,
  serialize: _autoDiagnosisSerialize,
  deserialize: _autoDiagnosisDeserialize,
  deserializeProp: _autoDiagnosisDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _autoDiagnosisGetId,
  getLinks: _autoDiagnosisGetLinks,
  attach: _autoDiagnosisAttach,
  version: '3.1.8',
);

int _autoDiagnosisEstimateSize(
  AutoDiagnosis object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.diagnosis.length * 3;
  {
    for (var i = 0; i < object.diagnosis.length; i++) {
      final value = object.diagnosis[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.modelTag.length * 3;
  bytesCount += 3 + object.probability.length * 8;
  return bytesCount;
}

void _autoDiagnosisSerialize(
  AutoDiagnosis object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeStringList(offsets[1], object.diagnosis);
  writer.writeLong(offsets[2], object.lesionId);
  writer.writeString(offsets[3], object.modelTag);
  writer.writeDoubleList(offsets[4], object.probability);
}

AutoDiagnosis _autoDiagnosisDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AutoDiagnosis(
    dateTime: reader.readDateTime(offsets[0]),
    diagnosis: reader.readStringList(offsets[1]) ?? [],
    modelTag: reader.readString(offsets[3]),
    probability: reader.readDoubleList(offsets[4]) ?? [],
  );
  object.isarId = id;
  object.lesionId = reader.readLong(offsets[2]);
  return object;
}

P _autoDiagnosisDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDoubleList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _autoDiagnosisGetId(AutoDiagnosis object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _autoDiagnosisGetLinks(AutoDiagnosis object) {
  return [];
}

void _autoDiagnosisAttach(
    IsarCollection<dynamic> col, Id id, AutoDiagnosis object) {
  object.isarId = id;
}

extension AutoDiagnosisQueryWhereSort
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QWhere> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhere> anyLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lesionId'),
      );
    });
  }
}

extension AutoDiagnosisQueryWhere
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QWhereClause> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause> lesionIdEqualTo(
      int lesionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lesionId',
        value: [lesionId],
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause>
      lesionIdNotEqualTo(int lesionId) {
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause>
      lesionIdGreaterThan(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause>
      lesionIdLessThan(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterWhereClause> lesionIdBetween(
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
}

extension AutoDiagnosisQueryFilter
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QFilterCondition> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagnosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diagnosis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      diagnosisLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diagnosis',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      lesionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lesionId',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      lesionIdBetween(
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

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelTag',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      modelTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelTag',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'probability',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterFilterCondition>
      probabilityLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'probability',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AutoDiagnosisQueryObject
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QFilterCondition> {}

extension AutoDiagnosisQueryLinks
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QFilterCondition> {}

extension AutoDiagnosisQuerySortBy
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QSortBy> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> sortByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      sortByLesionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.desc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> sortByModelTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelTag', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      sortByModelTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelTag', Sort.desc);
    });
  }
}

extension AutoDiagnosisQuerySortThenBy
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QSortThenBy> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> thenByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      thenByLesionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lesionId', Sort.desc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy> thenByModelTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelTag', Sort.asc);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QAfterSortBy>
      thenByModelTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelTag', Sort.desc);
    });
  }
}

extension AutoDiagnosisQueryWhereDistinct
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct> {
  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct> distinctByDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnosis');
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct> distinctByLesionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lesionId');
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct> distinctByModelTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelTag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AutoDiagnosis, AutoDiagnosis, QDistinct>
      distinctByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'probability');
    });
  }
}

extension AutoDiagnosisQueryProperty
    on QueryBuilder<AutoDiagnosis, AutoDiagnosis, QQueryProperty> {
  QueryBuilder<AutoDiagnosis, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AutoDiagnosis, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<AutoDiagnosis, List<String>, QQueryOperations>
      diagnosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnosis');
    });
  }

  QueryBuilder<AutoDiagnosis, int, QQueryOperations> lesionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lesionId');
    });
  }

  QueryBuilder<AutoDiagnosis, String, QQueryOperations> modelTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelTag');
    });
  }

  QueryBuilder<AutoDiagnosis, List<double>, QQueryOperations>
      probabilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'probability');
    });
  }
}
