// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import '../../configs/dynamic_elements/dropdown_items.dart';
import '../../domain/entities/tagged_image.dart';

class TaggedImageDTO {
  final int? isarId;
  final String imagePath;
  final ImageType tag;

  TaggedImageDTO({
    this.isarId,
    required this.imagePath,
    required this.tag,
  });

  // Método para convertir el DTO en una entidad TaggedImage de Isar
  TaggedImage toEntity() {
    return TaggedImage(
      imageId: isarId,
      imagePath: imagePath,
      tag: tag.name,
    );
  }

  // Getter para obtener el archivo a partir del imagePath
  File get imageFile =>
      File(imagePath); // Aquí usamos un getter para obtener el File
}
