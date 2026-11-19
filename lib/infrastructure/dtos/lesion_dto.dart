// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/lesion.dart';
import 'auto_diagnosis_dto.dart';
import 'tagged_image_dto.dart';

class LesionDTO {
  final int? isarId;
  final String? patientId;
  final String clinicalDiagnosis;
  final String? histopathDiagnosis;
  final String location;
  final bool isFace;
  final bool isFront;
  final String phototype;
  final String? commentary;
  final List<AutoDiagnosisDTO> autoDiagnoses;
  final List<TaggedImageDTO> images;

  LesionDTO({
    this.isarId,
    this.patientId,
    required this.clinicalDiagnosis,
    this.histopathDiagnosis,
    required this.location,
    required this.isFace,
    required this.isFront,
    required this.phototype,
    this.commentary,
    required this.autoDiagnoses,
    required this.images,
  });

  String getTagLocation(bool isFace, bool isFront, String location) {
    return isFace
        ? 'face_$location'
        : isFront
            ? 'front_body_$location'
            : 'back_body_$location';
  }

  // Método para convertir el DTO en una entidad Lesion de Isar
  Lesion toEntity() {
    final tagLocarion = getTagLocation(isFace, isFront, location);
    final lesion = Lesion(
      lesionId: isarId,
      clinicalDiagnosis: clinicalDiagnosis,
      histopathDiagnosis: histopathDiagnosis,
      location: tagLocarion,
      phototype: phototype,
      commentary: commentary,
      patientId: patientId ?? '',
      createdAt: DateTime.now(),
    );

    // Agregar AutoDiagnósticos a la lesión
    for (var autoDiagnosisDTO in autoDiagnoses) {
      final autoDiagnosis = autoDiagnosisDTO.toEntity();
      lesion.autoDiagnoses.add(autoDiagnosis);
    }

    // Agregar imágenes a la lesión
    for (var imageDTO in images) {
      final image = imageDTO.toEntity();
      lesion.images.add(image);
    }

    return lesion;
  }
}
