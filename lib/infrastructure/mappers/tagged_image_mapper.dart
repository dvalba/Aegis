import '../../configs/dynamic_elements/dropdown_items.dart';
import '../../domain/entities/tagged_image.dart';
import '../dtos/tagged_image_dto.dart';

class TaggedImageMapper {
  // De entidad a DTO
  static TaggedImageDTO toDTO(TaggedImage taggedImage) {
    return TaggedImageDTO(
      isarId: taggedImage.isarId,
      imagePath: taggedImage.imagePath,
      tag: ImageType.values
          .firstWhere((element) => element.name == taggedImage.tag),
    );
  }

  // De DTO a entidad
  static TaggedImage fromDTO(TaggedImageDTO taggedImageDTO) {
    return taggedImageDTO.toEntity();
  }
}
