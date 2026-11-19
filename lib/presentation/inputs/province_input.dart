import 'package:formz/formz.dart';

// Define validation errors for the province input
enum ProvinceInputError { empty,invalid }

// Extend FormzInput for province validation
class ProvinceInput extends FormzInput<String, ProvinceInputError> {
  // Call super.pure to represent an unmodified form input
  const ProvinceInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const ProvinceInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == ProvinceInputError.empty) {
      return "Requerido"; // Error when the field is empty
    }
   
    if (displayError == ProvinceInputError.invalid) {
      return "La provincia no debe contener números ni caracteres especiales"; // Error if invalid characters are used
    }
    return null; // Return null as a fallback
  }

  // Province validation logic
  @override
  ProvinceInputError? validator(String value) {
    if (value.isEmpty) {
      return ProvinceInputError.empty; // Error if input is empty
    }
    // Regex: Only letters and spaces are allowed
    final provinceRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!provinceRegExp.hasMatch(value)) {
      return ProvinceInputError.invalid; // Error if invalid characters are used
    }
    return null; // No error if all validations pass
  }
}