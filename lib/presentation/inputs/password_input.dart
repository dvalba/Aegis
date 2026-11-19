import 'package:formz/formz.dart';

// Define validation errors for the password input
enum PasswordInputError { empty, tooShort, invalid }

// Extend FormzInput for password validation
class PasswordInput extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input
  const PasswordInput.dirty(super.value) : super.dirty();

  // Error message mapping based on validation state
  String? get errorText {
    if (isValid || isPure) return null; // No error if valid or unmodified
    if (displayError == PasswordInputError.empty) {
      return "Requerido"; // Error when the field is empty
    }
    if (displayError == PasswordInputError.tooShort) {
      return "Mínimo 8 caracteres"; // Error if password is too short
    }
    if (displayError == PasswordInputError.invalid) {
      return "Debe tener mayúscula, minúscula y número"; // Error if password doesn't match the pattern
    }
    return null; // Return null as a fallback
  }

  // Password validation logic
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty; // Error if input is empty
    }

    if (value.length < 8) {
      return PasswordInputError.tooShort; // Error if password is too short
    }

    // Password regex: Must contain at least one lowercase letter, one uppercase letter, and one digit
    final passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return PasswordInputError.invalid; // Error if password doesn't match the pattern
    }

    return null; // No error if all validations pass
  }
}

