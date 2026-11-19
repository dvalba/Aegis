import 'package:formz/formz.dart';

// Define validation errors for the Age input
enum AgeInputError { empty, invalidAge }

// Extend FormzInput for Age validation
class Age extends FormzInput<String, AgeInputError> {
  // Call super.pure to represent an unmodified form input
  const Age.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const Age.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == AgeInputError.empty) {
      return "Requerido";
    }
    if (displayError == AgeInputError.invalidAge) {
      return "Debe ser un número válido entre 0 y 120";
    }
    return null; // Return null as a fallback
  }

  // Age validation logic
  @override
  AgeInputError? validator(String value) {
    if (value.isEmpty) {
      return AgeInputError.empty; // Error if input is empty
    }

    // Check if the age is a valid number between 0 and 120
    final age = int.tryParse(value);
    if (age == null || age < 0 || age > 120) {
      return AgeInputError.invalidAge; // Error if the age is not valid
    }

    return null; // No error if all validations pass
  }
}
