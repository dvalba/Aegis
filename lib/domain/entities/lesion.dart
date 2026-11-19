import 'package:isar/isar.dart';

import 'auto_diagnosis.dart';
import 'patient.dart';
import 'tagged_image.dart';

part 'lesion.g.dart';

@Collection()
class Lesion {
  Id isarId;

  late String clinicalDiagnosis;
  late String? histopathDiagnosis;
  late String location;
  late String phototype;
  late String? commentary;

  @Index()
  late String patientId;

  @Backlink(to: 'lesions')
  final patient = IsarLink<Patient>();

  @Index()
  late bool synced = false;
  late DateTime createdAt = DateTime.now();

  final images = IsarLinks<TaggedImage>();
  final autoDiagnoses = IsarLinks<AutoDiagnosis>();

  Lesion({
    Id? lesionId,
    required this.clinicalDiagnosis,
    this.histopathDiagnosis,
    required this.location,
    required this.phototype,
    this.commentary,
    required this.patientId,
    required this.createdAt,
    this.synced = false,
  }) : isarId = lesionId ?? Isar.autoIncrement;
}

