import 'package:formz/formz.dart';

// Define validation errors for the ID input
enum IdInputError { empty, nonNumeric }

// Extend FormzInput for ID validation
class IdInput extends FormzInput<String, IdInputError> {
  // Call super.pure to represent an unmodified form input
  const IdInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const IdInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == IdInputError.empty) {
      return "Requerido";
    }
    if (displayError == IdInputError.nonNumeric) {
      return "Debe contener solo números";
    }
    return null; // Return null as a fallback
  }
  // ID validation logic
  @override
  IdInputError? validator(String value) {
    if (value.isEmpty) {
      return IdInputError.empty; // Error if input is empty
    }
    // Check if the ID contains only numbers
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return IdInputError.nonNumeric; // Error if the ID contains non-numeric characters
    }

    return null; // No error if all validations pass
  }
}
