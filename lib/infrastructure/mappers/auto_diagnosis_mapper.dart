import '../../domain/entities/auto_diagnosis.dart';
import '../dtos/auto_diagnosis_dto.dart';

class AutoDiagnosisMapper {

  // De entidad a DTO
  static AutoDiagnosisDTO toDTO(AutoDiagnosis autoDiagnosis) {
    return AutoDiagnosisDTO(
      isarId:autoDiagnosis.isarId,
      diagnosis: autoDiagnosis.diagnosis,
      probability: autoDiagnosis.probability,
      dateTime: autoDiagnosis.dateTime,
      modelTag: autoDiagnosis.modelTag,
    );
  }

  // De DTO a entidad
  static AutoDiagnosis fromDTO(AutoDiagnosisDTO autoDiagnosisDTO) {
    return autoDiagnosisDTO.toEntity();
  }
}
