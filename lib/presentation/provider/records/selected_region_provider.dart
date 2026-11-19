import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Definir el StateNotifier para manejar el estado de selectedRegion
class SelectedRegionNotifier extends StateNotifier<String?> {
  SelectedRegionNotifier() : super(null); // Estado inicial: null (ninguna región seleccionada)

  // Método para alternar la selección de una región
  void toggleRegion(String? regionType) {
    state = state == regionType ? null : regionType;
  }
}

// 2. Crear el StateNotifierProvider
final selectedRegionProvider =
    StateNotifierProvider<SelectedRegionNotifier, String?>((ref) {
  return SelectedRegionNotifier();
});
