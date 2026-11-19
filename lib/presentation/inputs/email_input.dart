import 'package:formz/formz.dart';

// Define validation errors for the email input
enum EmailInputError { empty, invalid }

// Extend FormzInput for email validation
class EmailInput extends FormzInput<String, EmailInputError> {
  // Call super.pure to represent an unmodified form input
  const EmailInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const EmailInput.dirty(super.value) : super.dirty();


  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == EmailInputError.empty) {
      return "Requerido"; // Error when the field is empty
    }
    if (displayError == EmailInputError.invalid) {
      return "Email inválido"; // Error when the email format is invalid
    }
    return null; // Return null as a fallback
  }
  // Email validation logic
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.empty; // Error if input is empty
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return EmailInputError.invalid; // Error if email format is invalid
    }

    return null; // No error if all validations pass
  }
}
