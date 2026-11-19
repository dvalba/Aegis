import '../../domain/entities/lesion.dart';
import '../dtos/lesion_dto.dart';
import 'auto_diagnosis_mapper.dart';
import 'tagged_image_mapper.dart';

class LesionMapper {
  // De entidad a DTO
  static LesionDTO toDTO(Lesion lesion) {
    final location = getLocation(lesion.location);
    return LesionDTO(
      isarId: lesion.isarId,
      patientId: lesion.patientId,
      clinicalDiagnosis: lesion.clinicalDiagnosis,
      histopathDiagnosis: lesion.histopathDiagnosis,
      location: location.location,
      isFace: location.isFace,
      isFront: location.isFront,
      phototype: lesion.phototype,
      commentary: lesion.commentary,
      autoDiagnoses: lesion.autoDiagnoses
          .map((autoDiagnosis) => AutoDiagnosisMapper.toDTO(autoDiagnosis))
          .toList(),
      images:
          lesion.images.map((image) => TaggedImageMapper.toDTO(image)).toList(),
    );
  }

  static ({bool isFace, bool isFront, String location}) getLocation(
      String tagLocation) {
    if (tagLocation.startsWith('face_')) {
      return (
        isFace: true,
        isFront: false,
        location: tagLocation.replaceFirst('face_', ''),
      );
    } else if (tagLocation.startsWith('front_body_')) {
      return (
        isFace: false,
        isFront: true,
        location: tagLocation.replaceFirst('front_body_', ''),
      );
    } else if (tagLocation.startsWith('back_body_')) {
      return (
        isFace: false,
        isFront: false,
        location: tagLocation.replaceFirst('back_body_', ''),
      );
    } else {
      throw ArgumentError('Invalid tagLocation format');
    }
  }

  // De DTO a entidad
  static Lesion fromDTO(LesionDTO lesionDTO) {
    final lesion = lesionDTO.toEntity();
    return lesion;
  }
}
