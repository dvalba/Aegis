import '../../domain/entities/patient.dart';
import '../dtos/patient_dto.dart';
import 'lesion_mapper.dart';

class PatientMapper {
  // De entidad a DTO
  static PatientDTO toDTO(Patient patient) {
    return PatientDTO(
      isarId:patient.isarId,
      patientId: patient.patientId,
      name: patient.name,
      lastName: patient.lastName,
      age: patient.age,
      sex: patient.sex,
      healthRecord: patient.healthRecord,
      lesions: patient.lesions.map(LesionMapper.toDTO).toList(),
    );
  }

  // De DTO a entidad
  static Patient fromDTO(PatientDTO patientDTO, int doctorId) {
    return patientDTO.toEntity(doctorId);
  }

  // Convertir lista de entidades a lista de DTOs
  static List<PatientDTO> toDTOList(List<Patient> patients) {
    return patients.map(toDTO).toList();
  }
}
