import 'package:aegis/domain/repositories/medical_report_repository.dart';
import 'package:flutter/foundation.dart';
import '../domain/entities/tagged_image.dart';
import '../infrastructure/dtos/patient_dto.dart';
import '../infrastructure/mappers/patient_mapper.dart';
import '../infrastructure/mappers/lesion_mapper.dart';
import '../infrastructure/mappers/auto_diagnosis_mapper.dart';
import '../infrastructure/mappers/tagged_image_mapper.dart';

class RecordsService {
  final MedicalReportRepository patientRepository;

  RecordsService({required this.patientRepository});

  /// Crea y guarda un nuevo paciente en el repositorio.
  /// Este método guarda el paciente, sus lesiones, diagnósticos automáticos y
  /// las imágenes etiquetadas asociadas.
  Future<void> savePatient(PatientDTO patientDTO, int doctorId) async {
    try {
      // Mapear el DTO a la entidad Patient (sin relaciones aún cargadas).
      final patient = PatientMapper.fromDTO(patientDTO, doctorId);

      // Guardar el paciente básico.
      await patientRepository.savePatient(patient);

      // Iterar por cada lesión contenida en el DTO del paciente.
      for (final lesionDTO in patientDTO.lesions) {
        // Mapear la DTO de la lesión a la entidad Lesion.
        final lesion = LesionMapper.fromDTO(lesionDTO);

        // Guardar la lesión asociándola al paciente y obtener su ID.
        final lesionId = await patientRepository.addLesionToPatient(
            patient.patientId, lesion);

        // Guardar los diagnósticos automáticos de la lesión.
        for (final autoDiagnosisDTO in lesionDTO.autoDiagnoses) {
          final autoDiagnosis = AutoDiagnosisMapper.fromDTO(autoDiagnosisDTO);
          await patientRepository.addAutoDiagnosisToLesion(
              lesionId, autoDiagnosis);
        }

        // Guardar las imágenes etiquetadas asociadas a la lesión.
        for (final taggedImageDTO in lesionDTO.images) {
          final taggedImage = TaggedImageMapper.fromDTO(taggedImageDTO);
          await patientRepository.addTaggedImageToLesion(lesionId, taggedImage);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al guardar paciente: $e');
      }
      rethrow;
    }
  }

  /// Obtiene una lista de pacientes con paginación.
  Future<List<PatientDTO>> getAllPatients({
    bool onlyUnsynced = false,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final patients = await patientRepository.getAllPatients(
        onlyUnsynced: onlyUnsynced,
        offset: offset,
        limit: limit,
      );
      return PatientMapper.toDTOList(patients);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener pacientes: $e');
      }
      rethrow;
    }
  }

  /// Obtiene un paciente a partir de su patientId.
  Future<PatientDTO?> getPatient(String patientId) async {
    try {
      final patient = await patientRepository.getPatient(patientId);
      return PatientMapper.toDTO(patient);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener paciente con ID $patientId: $e');
      }
      rethrow;
    }
  }

  Future<void> updatePatient(PatientDTO patientDTO, int doctorId) async {
    try {
      // Mapear el DTO a la entidad Patient (sin relaciones aún cargadas).
      final patient = PatientMapper.fromDTO(patientDTO, doctorId);

      // Verificar que el paciente exista y actualizarlo en la base de datos.
      await patientRepository.updatePatient(patient);

      // Iterar por cada lesión contenida en el DTO del paciente.
      for (final lesionDTO in patientDTO.lesions) {
        // Mapear la DTO de la lesión a la entidad Lesion.
        final lesion = LesionMapper.fromDTO(lesionDTO);

        // Verificar si la lesión ya existe.
        final existingLesion =
            await patientRepository.findLesionById(lesion.isarId);
        int lesionId;
        if (existingLesion != null) {
          // Si la lesión existe, actualizar sus datos.
          await patientRepository.updateLesion(lesion);
          lesionId = existingLesion.isarId;

          // Actualizar diagnósticos automáticos existentes o agregar nuevos.
          for (final autoDiagnosisDTO in lesionDTO.autoDiagnoses) {
            final autoDiagnosis = AutoDiagnosisMapper.fromDTO(autoDiagnosisDTO);
            final existingAutoDiagnosis = await patientRepository
                .findAutoDiagnosisById(autoDiagnosis.isarId);
            if (existingAutoDiagnosis != null) {
              await patientRepository.updateAutoDiagnosis(autoDiagnosis);
            } else {
              await patientRepository.addAutoDiagnosisToLesion(
                  lesionId, autoDiagnosis);
            }
          }

          // Obtener todas las imágenes etiquetadas de la lesión.
          List<TaggedImage> allTaggedImages =
              await patientRepository.getTaggedImagesByLesionId(lesionId);

          // Crear un conjunto de IDs de imágenes en el DTO para una comparación rápida.
          Set<int> dtoImageIds = lesionDTO.images
              .map((img) => img.isarId)
              .whereType<int>() // Filtra los valores null
              .toSet();

          // Eliminar imágenes que no están en el DTO.
          for (final taggedImage in allTaggedImages) {
            if (!dtoImageIds.contains(taggedImage.isarId)) {
              await patientRepository.deleteTaggedImage(taggedImage.isarId);
            }
          }

          for (final taggedImageDTO in lesionDTO.images) {
            final taggedImage = TaggedImageMapper.fromDTO(taggedImageDTO);
            final existingTaggedImage =
                await patientRepository.findTaggedImageById(taggedImage.isarId);
            if (existingTaggedImage != null) {
              taggedImage.lesionId = existingTaggedImage.lesionId;
              await patientRepository.updateTaggedImage(taggedImage);
            } else {
              await patientRepository.addTaggedImageToLesion(
                  lesionId, taggedImage);
            }
          }
        } else {
          // Si la lesión no existe, guardarla como una nueva lesión.
          lesionId = await patientRepository.addLesionToPatient(
              patient.patientId, lesion);

          // Guardar los diagnósticos automáticos de la nueva lesión.
          for (final autoDiagnosisDTO in lesionDTO.autoDiagnoses) {
            final autoDiagnosis = AutoDiagnosisMapper.fromDTO(autoDiagnosisDTO);
            await patientRepository.addAutoDiagnosisToLesion(
                lesionId, autoDiagnosis);
          }

          // Guardar las imágenes etiquetadas asociadas a la nueva lesión.
          for (final taggedImageDTO in lesionDTO.images) {
            final taggedImage = TaggedImageMapper.fromDTO(taggedImageDTO);
            await patientRepository.addTaggedImageToLesion(
                lesionId, taggedImage);
          }
        }
      }
    } catch (e) {
      throw Exception('Error al actualizar o guardar paciente: $e');
    }
  }

  /// Marca un paciente como sincronizado.
  Future<void> markAsSynced(String patientId) async {
    try {
      await patientRepository.markAsSynced(patientId);
    } catch (e) {
      throw Exception('Error al marcar paciente como sincronizado: $e');
    }
  }

  /// Elimina un paciente a partir de su patientId.
  Future<void> deletePatient(String patientId) async {
    try {
      await patientRepository.deletePatient(patientId);
    } catch (e) {
      throw Exception('Error al eliminar paciente con ID $patientId: $e');
    }
  }

  Future<void> deleteLesion(int lesionId) async {
    try {
      await patientRepository.deleteLesion(lesionId);
    } catch (e) {
      throw Exception('Error al eliminar lesion con ID $lesionId: $e');
    }
  }

  Future<PatientDTO?> getPatientById(String patientId) async {
    try {
      final patient = await patientRepository.getPatient(patientId);
      return PatientMapper.toDTO(patient);
    } catch (e) {
      throw Exception('Error al obtener paciente con ID $patientId: $e');
    }
  }
}
