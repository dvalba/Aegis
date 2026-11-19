import 'package:formz/formz.dart';

// Define validation errors for the full name input
enum FullNameInputError { empty, invalid }

// Extend FormzInput for full name validation
class FullNameInput extends FormzInput<String, FullNameInputError> {
  // Call super.pure to represent an unmodified form input
  const FullNameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const FullNameInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == FullNameInputError.empty) {
      return "Requerido";
    }
    if (displayError == FullNameInputError.invalid) {
      return "Introduce nombre y apellido";
    }
    return null; // Return null as a fallback
  }

  // Full name validation logic
  @override
  FullNameInputError? validator(String value) {
    if (value.isEmpty) {
      return FullNameInputError.empty; // Error if input is empty
    }

    // Ensure the full name contains at least two words
    final words = value.trim().split(RegExp(r'\s+'));
    if (words.length < 2) {
      return FullNameInputError.invalid; // Error if less than 2 words
    }

    return null; // No error if all validations pass
  }
}
