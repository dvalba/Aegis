import 'package:formz/formz.dart';

// Define validation errors for the work place input
enum WorkPlaceInputError { empty, tooShort, invalid }

// Extend FormzInput for work place validation
class WorkPlaceInput extends FormzInput<String, WorkPlaceInputError> {
  // Call super.pure to represent an unmodified form input
  const WorkPlaceInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const WorkPlaceInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == WorkPlaceInputError.empty) {
      return "Requerido"; // Error when the field is empty
    }
    if (displayError == WorkPlaceInputError.invalid) {
      return "El lugar de trabajo no debe contener caracteres especiales"; // Error if invalid characters are used
    }
    return null; // Return null as a fallback
  }

  // Work place validation logic
  @override
  WorkPlaceInputError? validator(String value) {
    if (value.isEmpty) {
      return WorkPlaceInputError.empty; // Error if input is empty
    }
    final workPlaceRegExp = RegExp(r'^[a-zA-Z0-9\s\.,\-]+$');
    if (!workPlaceRegExp.hasMatch(value)) {
      return WorkPlaceInputError
          .invalid; // Error if invalid characters are used
    }
    return null; // No error if all validations pass
  }
}
