// ---------------------- VALIDACIÓN PARA APELLIDO ----------------------
import 'package:formz/formz.dart';

enum LastNameError { empty, invalidCharacters }

class LastNameInput extends FormzInput<String, LastNameError> {
  const LastNameInput.pure() : super.pure('');
  const LastNameInput.dirty([super.value = '']) : super.dirty();

  static final _lastNameRegExp = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');

  @override
  LastNameError? validator(String value) {
    if (value.isEmpty) return LastNameError.empty;
    if (!_lastNameRegExp.hasMatch(value)) {
      return LastNameError.invalidCharacters;
    }
    return null;
  }

  String? get errorText {
    if (isValid) return null;
    return switch (error) {
      LastNameError.empty => 'Requerido',
      LastNameError.invalidCharacters => 'Caracteres no permitidos',
      _ => null,
    };
  }
}
