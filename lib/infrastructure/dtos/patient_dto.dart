import '../../domain/entities/patient.dart';
import 'lesion_dto.dart';

class PatientDTO {
  final int? isarId;
  final String patientId;
  final String name;
  final String lastName;
  final int age;
  final String sex;
  final String? healthRecord;
  final List<LesionDTO> lesions;

  PatientDTO({
    this.isarId,
    required this.patientId,
    required this.name,
    required this.lastName,
    required this.age,
    required this.sex,
    this.healthRecord,
    required this.lesions,
  });

  // Método para convertir el DTO en una entidad Patient de Isar
  Patient toEntity(int doctorId) {
    final patient = Patient(
      pId : isarId,
      patientId: patientId,
      name: name,
      lastName: lastName,
      age: age,
      sex: sex,
      healthRecord: healthRecord,
      createdAt: DateTime.now(),
      doctorId: doctorId,
    );

    // Agregar las lesiones al paciente
    for (var lesionDTO in lesions) {
      final lesion = lesionDTO.toEntity();
      lesion.patientId = patient.patientId;
      patient.lesions.add(lesion);
    }

    return patient;
  }
}
