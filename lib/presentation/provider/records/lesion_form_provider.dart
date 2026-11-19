import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../configs/dynamic_elements/dropdown_items.dart';
import 'package:collection/collection.dart';
import '../../../infrastructure/dtos/lesion_dto.dart';
import 'image_manager_provider.dart';

/// Estado del formulario de la lesión.
class LesionFormState {
  final bool isPosting; // Indica si se está enviando la lesión.
  final bool formPosted; // Indica si la lesión fue enviada.
  final bool isValid; // Indica si el formulario de la lesión es válido.
  final String? errorMessage; // Mensaje de error.

  final int? isarId;
  final String? clinicalDiagnosis; // Diagnóstico clínico.
  final String? histopathDiagnosis; // Diagnóstico histopatológico.
  final String? phototype; // Fototipo.
  final String? location; // Localización de la lesión.
  final bool isFace;
  final bool isFront;

  final String? notes; // Notas adicionales.

  LesionFormState({
    this.isarId,
    this.isPosting = false,
    this.formPosted = false,
    this.isValid = false,
    this.errorMessage,
    this.clinicalDiagnosis,
    this.histopathDiagnosis,
    this.location,
    this.isFace = false,
    this.isFront = true,
    this.phototype,
    this.notes,
  });

  LesionFormState copyWith({
    bool? isPosting,
    bool? formPosted,
    bool? isValid,
    String? errorMessage,
    int? isarId,
    String? clinicalDiagnosis,
    String? histopathDiagnosis,
    String? location,
    bool? isFace,
    bool? isFront,
    String? phototype,
    String? notes,
  }) {
    return LesionFormState(
      isPosting: isPosting ?? this.isPosting,
      formPosted: formPosted ?? this.formPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      isarId: isarId ?? this.isarId,
      clinicalDiagnosis: clinicalDiagnosis ?? this.clinicalDiagnosis,
      histopathDiagnosis: histopathDiagnosis ?? this.histopathDiagnosis,
      location: location ?? this.location,
      isFace: isFace ?? this.isFace,
      isFront: isFront ?? this.isFront,
      phototype: phototype ?? this.phototype,
      notes: notes ?? this.notes,
    );
  }
}

/// Notifier del formulario de la lesión.
class LesionFormNotifier extends StateNotifier<LesionFormState> {
  final ImagesNotifier imageNotifier;
  final Ref ref;

  LesionFormNotifier(this.imageNotifier, this.ref) : super(LesionFormState()) {
    // Escucha cambios en el proveedor de imágenes para validar el formulario
    ref.listen(imageManagerProvider, (previous, next) {
      if (previous == null ||
          next.hasDermatoscopicImage != previous.hasDermatoscopicImage) {
        _validateLesionForm(state);
      }
    });
  }

  /// Actualiza el campo de diagnóstico clínico.
  void updateClinicalDiagnosis(String? value) {
    _updateLesionState(clinicalDiagnosis: value);
  }

  /// Actualiza el campo de diagnóstico histopatológico.
  void updateHistopathDiagnosis(String? value) {
    _updateLesionState(histopathDiagnosis: value);
  }

  /// Actualiza el campo de localización de_updateLesionState la lesión.
  void updateLocation({String? location, bool? isFace, bool? isFront}) {
    _updateLesionState(location: location, isFace: isFace, isFront: isFront);
  }

  /// Actualiza el campo de fototipo.
  void updatePhototype(String? value) {
    _updateLesionState(phototype: value);
  }

  /// Actualiza el campo de notas adicionales.
  void updateNotes(String? value) {
    _updateLesionState(notes: value);
  }

  /// Crea un nuevo estado actualizando y validando los cambios en los campos.
  void _updateLesionState({
    String? clinicalDiagnosis,
    String? histopathDiagnosis,
    String? location,
    bool? isFace,
    bool? isFront,
    String? phototype,
    String? notes,
  }) {
    final newState = state.copyWith(
      clinicalDiagnosis: clinicalDiagnosis ?? state.clinicalDiagnosis,
      histopathDiagnosis: histopathDiagnosis ?? state.histopathDiagnosis,
      location: location ?? state.location,
      isFront: isFront ?? state.isFront,
      isFace: isFace ?? state.isFace,
      phototype: phototype ?? state.phototype,
      notes: notes ?? state.notes,
    );
    _validateLesionForm(newState);
  }

  /// Valida el estado del formulario de la lesión y actualiza el estado con el resultado de la validación.
  void _validateLesionForm(LesionFormState lesionFormState) {
    final validation = _getLesionFormValidation(lesionFormState);
    state = lesionFormState.copyWith(
      isValid: validation.isValid,
      errorMessage: validation.errorMessage,
    );
  }

  /// Retorna el resultado de la validación comprobando que los campos obligatorios no estén vacíos
  /// y que se haya añadido al menos una imagen dermatoscópica.
  ({bool isValid, String? errorMessage}) _getLesionFormValidation(
      LesionFormState lesionFormState) {
    final isValid = _isNotNullOrEmpty(lesionFormState.clinicalDiagnosis) &&
        _isNotNullOrEmpty(lesionFormState.location) &&
        _isNotNullOrEmpty(lesionFormState.phototype);

    if (!isValid) {
      return (
        isValid: false,
        errorMessage: 'Verifique los campos de la lesión',
      );
    }

    final hasImages = imageNotifier.state.hasDermatoscopicImage;

    if (!hasImages) {
      return (
        isValid: false,
        errorMessage: 'Debe añadir al menos una imagen dermatoscópica',
      );
    }

    return (isValid: true, errorMessage: null);
  }

  /// Función auxiliar para comprobar si una cadena no es nula ni vacía.
  bool _isNotNullOrEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  void editLesion(LesionDTO lesionData) {
    //TODO: Es probable que se deba llevar el ISAR ID
    state = LesionFormState().copyWith(
      isarId: lesionData.isarId,
      clinicalDiagnosis: lesionData.clinicalDiagnosis,
      histopathDiagnosis: lesionData.histopathDiagnosis,
      location: lesionData.location,
      isFace: lesionData.isFace,
      isFront: lesionData.isFront,
      phototype: lesionData.phototype,
      notes: lesionData.commentary,
    );

    imageNotifier.loadImages(lesionData.images);
  }

  Future<LesionDTO?> createLesion({bool isEdited = false}) async {
    // Comprueba si el formulario es válido.
    if (!state.isValid) {
      // Si el formulario no ha sido enviado aún, valida el formulario para actualizar el estado.
      if (!state.formPosted) {
        _validateLesionForm(state);
      }
      // Actualiza el estado para indicar que hay un error y que el formulario ya fue enviado.
      state = state.copyWith(isPosting: false, formPosted: true);
      // Retorna null si el formulario es inválido.
      return null;
    }

    // Marca que se está enviando la lesión.
    state = state.copyWith(isPosting: true);


    final dermatoscopicImage = imageNotifier.state.images.firstWhereOrNull(
        (taggedImage) => taggedImage.tag == ImageType.dermatoscopic);

    if (dermatoscopicImage == null) {
      state = state.copyWith(
        isPosting: false,
        errorMessage:
            'No se encontró ninguna imagen dermatoscópica. Por favor, añada una.',
      );
      return null;
    }

    // Crea los datos de la lesión utilizando los valores del formulario y las imágenes.
    // Las auto-diagnósticas por IA se generan en el backend al procesar la lesión.
    final lesionData = LesionDTO(
      isarId: state.isarId,
      clinicalDiagnosis: state.clinicalDiagnosis!,
      histopathDiagnosis: state.histopathDiagnosis,
      location: state.location!,
      isFace: state.isFace,
      isFront: state.isFront,
      phototype: state.phototype!,
      commentary: state.notes,
      images: imageNotifier.state.images,
      autoDiagnoses: [],
    );

    // Actualiza el estado para indicar que se ha terminado el envío.
    state = state.copyWith(isPosting: false);

    // Retorna los datos de la lesión creada.
    return lesionData;
  }

  void clearForm() {
    state = LesionFormState();
    imageNotifier.clearSelectedImages();
  }
}

final lesionFormProvider =
    StateNotifierProvider<LesionFormNotifier, LesionFormState>((ref) {
  final imageNotifier = ref.watch(imageManagerProvider.notifier);
  return LesionFormNotifier(imageNotifier, ref);
});
