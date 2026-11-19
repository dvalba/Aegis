import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../configs/dynamic_elements/dropdown_items.dart';
import '../../../infrastructure/dtos/tagged_image_dto.dart';

class ImagesState {
  final List<TaggedImageDTO> images; // Lista de imágenes con su tag
  final bool isPickingImage;

  ImagesState({this.images = const [], this.isPickingImage = false});

  bool get hasDermatoscopicImage {
    return images
        .any((taggedImage) => taggedImage.tag == ImageType.dermatoscopic);
  }

  ImagesState copyWith({List<TaggedImageDTO>? images, bool? isPickingImage}) {
    return ImagesState(
      images: images ?? this.images,
      isPickingImage: isPickingImage ?? this.isPickingImage,
    );
  }
}

class ImagesNotifier extends StateNotifier<ImagesState> {
  final ImagePicker _picker = ImagePicker();

  ImagesNotifier() : super(ImagesState());

  // Método para seleccionar una o varias imágenes (generalizado para galería o cámara)
  Future<void> _pickImage(ImageSource source, ImageType tag) async {
    if (state.isPickingImage) return;

    state = state.copyWith(isPickingImage: true);

    try {
      if (source == ImageSource.gallery) {
        // Permitir selección múltiple solo desde la galería
        final pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          final newImages = pickedFiles
              .map((file) => TaggedImageDTO(imagePath: file.path, tag: tag))
              .toList();
          state = state.copyWith(
            images: [...state.images, ...newImages],
          );
        }
      } else {
        // Captura
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          final newImage = TaggedImageDTO(
            imagePath: pickedFile.path,
            tag: tag,
          );
          state = state.copyWith(
            images: [...state.images, newImage],
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    } finally {
      state = state.copyWith(isPickingImage: false);
    }
  }

  // Método público para seleccionar una imagen desde la galería con un tag
  Future<void> pickImageFromGallery(ImageType type) async {
    await _pickImage(ImageSource.gallery, type);
  }

  // Método público para tomar una foto con la cámara con un tag
  Future<void> pickImageFromCamera(ImageType type) async {
    await _pickImage(ImageSource.camera, type);
  }

  void loadImages(List<TaggedImageDTO> images) {
    state = state.copyWith(images: images);
  }

  // Método para eliminar una imagen específica de la lista
  void removeImage(String imagePath) {
    final updatedImages = state.images
        .where((taggedImage) => taggedImage.imagePath != imagePath)
        .toList();
    state = state.copyWith(images: updatedImages);
  }

  void clearSelectedImages() {
    state = ImagesState();
  }

  Future<void> cropImage(String imagePath) async {
    try {
      // Usa image_cropper para recortar la imagen
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar imagen',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
            resetAspectRatioEnabled: true,
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        final updatedImages = [...state.images];

        // Buscamos el índice de la imagen en la lista
        final index = updatedImages
            .indexWhere((taggedImage) => taggedImage.imagePath == imagePath);

        if (index != -1) {
          // Si la imagen está en la lista, la actualizamos
          updatedImages[index] = TaggedImageDTO(
              imagePath: croppedFile.path, tag: state.images[index].tag);
        } else {
          // Si la imagen no está en la lista, lanzamos una excepción
          throw Exception('La imagen no está en la lista para ser actualizada');
        }

        // Actualizamos el estado con la lista de imágenes
        state = state.copyWith(images: updatedImages);
      }
    } catch (e) {
      // Capturamos cualquier error y mostramos un mensaje informativo
      if (kDebugMode) {
        print('Error al recortar la imagen: $e');
      }
      // Aquí puedes también manejar la excepción como prefieras,
      // por ejemplo, mostrar un diálogo de error o enviar el error a un servicio de monitoreo.
    }
  }
}


final imageManagerProvider =
    StateNotifierProvider<ImagesNotifier, ImagesState>((ref) {
  return ImagesNotifier();
});
