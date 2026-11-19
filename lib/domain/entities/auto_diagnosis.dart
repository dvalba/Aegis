import 'package:isar/isar.dart';

part 'auto_diagnosis.g.dart';

@Collection()
class AutoDiagnosis {
  Id isarId;

  @Index()
  late int lesionId;
  late List<String> diagnosis;
  late List<double> probability;
  late DateTime dateTime;
  late String modelTag;

  AutoDiagnosis({
    Id? adId,
    required this.diagnosis,
    required this.probability,
    required this.dateTime,
    required this.modelTag,
  }): isarId = adId ?? Isar.autoIncrement;
}

