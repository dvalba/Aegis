import 'package:flutter/material.dart';
import '../../../../configs/dynamic_elements/dropdown_items.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String label;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final Map<String, String>? translatorTags;
  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    this.translatorTags,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _validateValue(value, items), // Verifica si el valor es válido
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  translatorTags?[item] ?? item,
                ),
              ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Verifica si el valor es válido, si no, devuelve null
  static String? _validateValue(String? value, List<String> items) {
    return (value != null && items.contains(value)) ? value : null;
  }

  // Private validator function
  static String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido';
    }
    return null;
  }

  // Factory for "Sexo" dropdown
  factory CustomDropdown.sex({
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return CustomDropdown(
      value: _validateValue(value, const ['Masculino', 'Femenino']),
      items: const ['Masculino', 'Femenino'],
      label: "Sexo",
      onChanged: onChanged,
      validator: _requiredValidator,
    );
  }

  // Factory for "Diagnóstico" dropdown
  factory CustomDropdown.diagnosis({
    String? value,
    required String label, // Clínico || Histopatológico
    required ValueChanged<String?> onChanged,
  }) {
    return CustomDropdown(
      value: _validateValue(value, diagnosisItems),
      items: diagnosisItems,
      label: "Diagnóstico $label",
      onChanged: onChanged,
      validator: _requiredValidator,
    );
  }

  // Factory for "Localización" dropdown
  factory CustomDropdown.location({
    String? value,
    required bool isFace,
    required bool isFront,
    required ValueChanged<String?> onChanged,
  }) {
    final locationItems = (isFace
        ? faceTags
        : isFront
            ? frontBodyTags
            : backBodyTags);

    return CustomDropdown(
      value: _validateValue(value, locationItems.keys.toList()),
      items: locationItems.keys.toList(),
      label: "Localización",
      onChanged: onChanged,
      translatorTags: locationItems,
      validator: _requiredValidator,
    );
  }

  // Factory for "Fototipo" dropdown
  factory CustomDropdown.phototype({
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return CustomDropdown(
      value: _validateValue(value, phototypeItems),
      items: phototypeItems,
      label: "Fototipo",
      onChanged: onChanged,
      validator: _requiredValidator,
    );
  }
}
