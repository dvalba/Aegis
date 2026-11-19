import 'package:formz/formz.dart';

// Define validation errors for the municipality input
enum MunicipalityInputError { empty, tooShort, invalid }

// Extend FormzInput for municipality validation
class MunicipalityInput extends FormzInput<String, MunicipalityInputError> {
  // Call super.pure to represent an unmodified form input
  const MunicipalityInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const MunicipalityInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == MunicipalityInputError.empty) {
      return "Requerido"; // Error when the field is empty
    }

    if (displayError == MunicipalityInputError.invalid) {
      return "El municipio no debe contener números ni caracteres especiales"; // Error if invalid characters are used
    }
    return null; // Return null as a fallback
  }

  // Municipality validation logic
  @override
  MunicipalityInputError? validator(String value) {
    if (value.isEmpty) {
      return MunicipalityInputError.empty; // Error if input is empty
    }
    // Regex: Only letters and spaces are allowed
    final municipalityRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!municipalityRegExp.hasMatch(value)) {
      return MunicipalityInputError
          .invalid; // Error if invalid characters are used
    }
    return null; // No error if all validations pass
  }
}
