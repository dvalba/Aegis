import 'package:formz/formz.dart';

// ---------------------- VALIDACIÓN PARA NOMBRE ----------------------
enum NameError { empty, invalidCharacters }

class NameInput extends FormzInput<String, NameError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');

  @override
  NameError? validator(String value) {
    if (value.isEmpty) return NameError.empty;
    if (!_nameRegExp.hasMatch(value)) return NameError.invalidCharacters;
    return null;
  }

  String? get errorText {
    if (isValid) return null;
    return switch (error) {
      NameError.empty => 'Requerido',
      NameError.invalidCharacters => 'Solo letras y espacios',
      _ => null,
    };
  }
}
