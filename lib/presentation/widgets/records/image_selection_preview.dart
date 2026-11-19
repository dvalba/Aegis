import 'package:flutter/material.dart';

import '../../../configs/dynamic_elements/dropdown_items.dart';
import '../../../infrastructure/dtos/tagged_image_dto.dart';
import 'circular_badge.dart';
import '../shared/buttom/circular_icon_botton.dart';

class ImageSelectionPreview extends StatelessWidget {
  final List<TaggedImageDTO> images;
  final Function(String) onRemoveImage;
  final Function(String) onCropperImage;

  const ImageSelectionPreview({
    super.key,
    required this.images,
    required this.onRemoveImage,
    required this.onCropperImage,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox(); // No muestra nada si no hay imágenes seleccionadas
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final imageType = images[index].tag;
          final image = images[index];

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Ajusta el valor para más o menos redondeo
                  child: Image.file(
                    image.imageFile,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: CircularIconButton(
                    icon: Icons.delete_sharp,
                    tooltip: 'Deselect image',
                    onPressed: () => onRemoveImage(image.imagePath),
                    iconColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                    iconSize: 32.0,
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: CircularIconButton(
                    icon: Icons.edit,
                    tooltip: 'Edit image',
                    onPressed: () => onCropperImage(image.imagePath),
                    iconColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                    iconSize: 32.0,
                  ),
                ),
                Positioned(
                  top: 5, // Distancia desde el borde superior
                  right: 5,
                  child: CircularBadge(
                    label: (index + 1).toString(),
                    size: 32,
                  ),
                  // Distancia desde el borde derecho
                ),
                Positioned(
                  bottom: 5, // Distancia desde el borde superior
                  left: 5,
                  child: CircularBadge(
                    label: imageType == ImageType.dermatoscopic ? "D" : "C",
                    size: 32,
                  ),
                  // Distancia desde el borde derecho
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
