import 'package:isar/isar.dart';

import 'lesion.dart';

part 'patient.g.dart';

@Collection()
class Patient {
  Id isarId;

  @Index(unique: true)
  late String patientId;

  @Index()
  late int doctorId;

  late String name;
  late String lastName;
  late int age;
  late String sex;
  String? healthRecord;
  late bool synced;
  late DateTime createdAt;

  final lesions = IsarLinks<Lesion>();

  Patient({
    Id? pId,
    required this.patientId,
    required this.name,
    required this.lastName,
    required this.age,
    required this.sex,
    this.healthRecord,
    required this.createdAt,
    required this.doctorId,
    this.synced = false,
  }): isarId = pId ?? Isar.autoIncrement;
}




