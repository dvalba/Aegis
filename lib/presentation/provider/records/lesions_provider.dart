import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aegis/infrastructure/dtos/lesion_dto.dart';
import 'lesion_form_provider.dart';

class LesionState {
  final List<LesionDTO> lesions;

  LesionState({
    this.lesions = const [],
  });

  LesionState copyWith({
    List<LesionDTO>? lesions,
  }) {
    return LesionState(
      lesions: lesions ?? this.lesions,
    );
  }

  // Método para verificar si hay lesiones
  bool hasLesion() {
    if (lesions.isEmpty) {
      // Si no hay lesiones, podemos asignar un mensaje de error
      return false;
    }
    return true;
  }
}

class LesionNotifier extends StateNotifier<LesionState> {
  final LesionFormNotifier lesionFormNotifier;

  LesionNotifier(this.lesionFormNotifier) : super(LesionState());

  Future<({bool isValid, String? errorMessage, LesionDTO? lesion})>
      submitLesion() async {
    try {
      // Intenta crear la lesión usando los datos del formulario.
      final newLesion = await lesionFormNotifier.createLesion();

      // Si newLesion es nula, el formulario es inválido y se devuelve el estado actual de validación.
      if (newLesion == null) {
        return (
          isValid: lesionFormNotifier.state.isValid,
          errorMessage: lesionFormNotifier.state.errorMessage,
          lesion: null,
        );
      }

      // Actualizamos el estado con la nueva lesión añadida a la lista.
      state = state.copyWith(lesions: [...state.lesions, newLesion]);

      // Aquí deberías usar un servicio para enviar la nueva lesión al backend o base de datos.
      // Ejemplo: await lesionService.submitLesion(newLesion);

      // Limpiamos el formulario después de enviar la lesión.
      lesionFormNotifier.clearForm();

      // Retornamos el estado de la operación, incluyendo la nueva lesión.
      return (isValid: true, errorMessage: null, lesion: newLesion);
    } catch (e) {
      // En caso de error inesperado, devolvemos un mensaje de error.
      return (
        isValid: false,
        errorMessage: 'Error inesperado al enviar la lesión.',
        lesion: null,
      );
    }
  }

  Future<({bool isValid, String? errorMessage, LesionDTO? lesion})>
      updateLesionAt(int index) async {
    try {
      // Intenta crear la lesión actualizada usando los datos del formulario.
      final updatedLesion = await lesionFormNotifier.createLesion();

      // Si la lesión actualizada es nula, se devuelve un estado inválido con el mensaje de error correspondiente.
      if (updatedLesion == null) {
        return (
          isValid: lesionFormNotifier.state.isValid,
          errorMessage: lesionFormNotifier.state.errorMessage,
          lesion: null
        );
      }

      // Verificamos que el índice sea válido
      if (index < 0 || index >= state.lesions.length) {
        return (
          isValid: false,
          errorMessage:
              'Índice fuera de rango al intentar actualizar la lesión.',
          lesion: null
        );
      }

      // Aquí deberías usar un servicio para actualizar la lesión en el backend o base de datos
      // Ejemplo de servicio: await lesionService.updateLesion(updatedLesion);

      // Actualizamos la lista de lesiones con la lesión modificada en la posición correspondiente.
      final updatedLesions = List.of(state.lesions);
      updatedLesions[index] = updatedLesion;

      // Actualizamos el estado con la lista de lesiones modificada.
      state = state.copyWith(lesions: updatedLesions);

      // Limpiamos el formulario después de la actualización.
      lesionFormNotifier.clearForm();

      // Retornamos la operación con los datos actualizados de la lesión.
      return (isValid: true, errorMessage: null, lesion: updatedLesion);
    } catch (e) {
      // En caso de error inesperado, devolvemos un mensaje de error.
      return (
        isValid: false,
        errorMessage: 'Error inesperado al actualizar la lesión.',
        lesion: null
      );
    }
  }

  void loadLesions(List<LesionDTO> lesions) {
    state = state.copyWith(lesions: lesions);
  }

  void clearForm() {
    state = LesionState(); // Resetea la lista de lesiones
    lesionFormNotifier.clearForm(); // Limpia el formulario de la lesión
  }
}

final lesionProvider =
    StateNotifierProvider<LesionNotifier, LesionState>((ref) {
  final lesionFormNotifier = ref.watch(lesionFormProvider.notifier);
  return LesionNotifier(lesionFormNotifier);
});
