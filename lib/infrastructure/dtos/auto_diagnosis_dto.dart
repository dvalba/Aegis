// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/auto_diagnosis.dart';

class AutoDiagnosisDTO {
  final int? isarId;
  final List<String> diagnosis;
  final List<double> probability;
  final DateTime dateTime;
  final String modelTag;

  AutoDiagnosisDTO({
    this.isarId,
    required this.diagnosis,
    required this.probability,
    required this.dateTime,
    required this.modelTag,
  });

  // Método para convertir el DTO en una entidad AutoDiagnosis de Isar
  AutoDiagnosis toEntity() {
    return AutoDiagnosis(
      adId: isarId,
      diagnosis: diagnosis,
      probability: probability,
      dateTime: dateTime,
      modelTag: modelTag,
    );
  }
}
