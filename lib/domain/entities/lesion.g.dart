// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLesionCollection on Isar {
  IsarCollection<Lesion> get lesions => this.collection();
}

const LesionSchema = CollectionSchema(
  name: r'Lesion',
  id: 2531699883481010755,
  properties: {
    r'clinicalDiagnosis': PropertySchema(
      id: 0,
      name: r'clinicalDiagnosis',
      type: IsarType.string,
    ),
    r'commentary': PropertySchema(
      id: 1,
      name: r'commentary',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'histopathDiagnosis': PropertySchema(
      id: 3,
      name: r'histopathDiagnosis',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 4,
      name: r'location',
      type: IsarType.string,
    ),
    r'patientId': PropertySchema(
      id: 5,
      name: r'patientId',
      type: IsarType.string,
    ),
    r'phototype': PropertySchema(
      id: 6,
      name: r'phototype',
      type: IsarType.string,
    ),
    r'synced': PropertySchema(
      id: 7,
      name: r'synced',
      type: IsarType.bool,
    )
  },
  estimateSize: _lesionEstimateSize,
  serialize: _lesionSerialize,
  deserialize: _lesionDeserialize,
  deserializeProp: _lesionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'patientId': IndexSchema(
      id: 403389457658259617,
      name: r'patientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'patientId',
          type: IndexType.hash,
          caseSensitive: true,
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
  links: {
    r'patient': LinkSchema(
      id: -2416370001002520864,
      name: r'patient',
      target: r'Patient',
      single: true,
      linkName: r'lesions',
    ),
    r'images': LinkSchema(
      id: 6882143038205396852,
      name: r'images',
      target: r'TaggedImage',
      single: false,
    ),
    r'autoDiagnoses': LinkSchema(
      id: 2818750836245101555,
      name: r'autoDiagnoses',
      target: r'AutoDiagnosis',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _lesionGetId,
  getLinks: _lesionGetLinks,
  attach: _lesionAttach,
  version: '3.1.8',
);

int _lesionEstimateSize(
  Lesion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clinicalDiagnosis.length * 3;
  {
    final value = object.commentary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.histopathDiagnosis;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.location.length * 3;
  bytesCount += 3 + object.patientId.length * 3;
  bytesCount += 3 + object.phototype.length * 3;
  return bytesCount;
}

void _lesionSerialize(
  Lesion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clinicalDiagnosis);
  writer.writeString(offsets[1], object.commentary);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.histopathDiagnosis);
  writer.writeString(offsets[4], object.location);
  writer.writeString(offsets[5], object.patientId);
  writer.writeString(offsets[6], object.phototype);
  writer.writeBool(offsets[7], object.synced);
}

Lesion _lesionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lesion(
    clinicalDiagnosis: reader.readString(offsets[0]),
    commentary: reader.readStringOrNull(offsets[1]),
    createdAt: reader.readDateTime(offsets[2]),
    histopathDiagnosis: reader.readStringOrNull(offsets[3]),
    location: reader.readString(offsets[4]),
    patientId: reader.readString(offsets[5]),
    phototype: reader.readString(offsets[6]),
    synced: reader.readBoolOrNull(offsets[7]) ?? false,
  );
  object.isarId = id;
  return object;
}

P _lesionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lesionGetId(Lesion object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _lesionGetLinks(Lesion object) {
  return [object.patient, object.images, object.autoDiagnoses];
}

void _lesionAttach(IsarCollection<dynamic> col, Id id, Lesion object) {
  object.isarId = id;
  object.patient.attach(col, col.isar.collection<Patient>(), r'patient', id);
  object.images.attach(col, col.isar.collection<TaggedImage>(), r'images', id);
  object.autoDiagnoses
      .attach(col, col.isar.collection<AutoDiagnosis>(), r'autoDiagnoses', id);
}

extension LesionQueryWhereSort on QueryBuilder<Lesion, Lesion, QWhere> {
  QueryBuilder<Lesion, Lesion, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhere> anySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'synced'),
      );
    });
  }
}

extension LesionQueryWhere on QueryBuilder<Lesion, Lesion, QWhereClause> {
  QueryBuilder<Lesion, Lesion, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> patientIdEqualTo(
      String patientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'patientId',
        value: [patientId],
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> patientIdNotEqualTo(
      String patientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [],
              upper: [patientId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [patientId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [patientId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'patientId',
              lower: [],
              upper: [patientId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> syncedEqualTo(bool synced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'synced',
        value: [synced],
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterWhereClause> syncedNotEqualTo(
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

extension LesionQueryFilter on QueryBuilder<Lesion, Lesion, QFilterCondition> {
  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      clinicalDiagnosisGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clinicalDiagnosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      clinicalDiagnosisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clinicalDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> clinicalDiagnosisMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clinicalDiagnosis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      clinicalDiagnosisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinicalDiagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      clinicalDiagnosisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clinicalDiagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commentary',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commentary',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commentary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commentary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commentary',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> commentaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commentary',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'histopathDiagnosis',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'histopathDiagnosis',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> histopathDiagnosisEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> histopathDiagnosisBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'histopathDiagnosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'histopathDiagnosis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> histopathDiagnosisMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'histopathDiagnosis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'histopathDiagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      histopathDiagnosisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'histopathDiagnosis',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'patientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phototype',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phototype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phototype',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phototype',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> phototypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phototype',
        value: '',
      ));
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }
}

extension LesionQueryObject on QueryBuilder<Lesion, Lesion, QFilterCondition> {}

extension LesionQueryLinks on QueryBuilder<Lesion, Lesion, QFilterCondition> {
  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patient(
      FilterQuery<Patient> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'patient');
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> patientIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'patient', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> images(
      FilterQuery<TaggedImage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'images');
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'images', length, true, length, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'images', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'images', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'images', 0, true, length, include);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'images', length, include, 999999, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> imagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'images', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> autoDiagnoses(
      FilterQuery<AutoDiagnosis> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'autoDiagnoses');
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      autoDiagnosesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'autoDiagnoses', length, true, length, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition> autoDiagnosesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'autoDiagnoses', 0, true, 0, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      autoDiagnosesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'autoDiagnoses', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      autoDiagnosesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'autoDiagnoses', 0, true, length, include);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      autoDiagnosesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'autoDiagnoses', length, include, 999999, true);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterFilterCondition>
      autoDiagnosesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'autoDiagnoses', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LesionQuerySortBy on QueryBuilder<Lesion, Lesion, QSortBy> {
  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByClinicalDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicalDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByClinicalDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicalDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByCommentary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentary', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByCommentaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentary', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByHistopathDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'histopathDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByHistopathDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'histopathDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByPhototype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phototype', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortByPhototypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phototype', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LesionQuerySortThenBy on QueryBuilder<Lesion, Lesion, QSortThenBy> {
  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByClinicalDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicalDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByClinicalDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicalDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByCommentary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentary', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByCommentaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentary', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByHistopathDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'histopathDiagnosis', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByHistopathDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'histopathDiagnosis', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByPhototype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phototype', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenByPhototypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phototype', Sort.desc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lesion, Lesion, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LesionQueryWhereDistinct on QueryBuilder<Lesion, Lesion, QDistinct> {
  QueryBuilder<Lesion, Lesion, QDistinct> distinctByClinicalDiagnosis(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clinicalDiagnosis',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByCommentary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commentary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByHistopathDiagnosis(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'histopathDiagnosis',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByPatientId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctByPhototype(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phototype', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lesion, Lesion, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }
}

extension LesionQueryProperty on QueryBuilder<Lesion, Lesion, QQueryProperty> {
  QueryBuilder<Lesion, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Lesion, String, QQueryOperations> clinicalDiagnosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clinicalDiagnosis');
    });
  }

  QueryBuilder<Lesion, String?, QQueryOperations> commentaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commentary');
    });
  }

  QueryBuilder<Lesion, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Lesion, String?, QQueryOperations> histopathDiagnosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'histopathDiagnosis');
    });
  }

  QueryBuilder<Lesion, String, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<Lesion, String, QQueryOperations> patientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patientId');
    });
  }

  QueryBuilder<Lesion, String, QQueryOperations> phototypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phototype');
    });
  }

  QueryBuilder<Lesion, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }
}
