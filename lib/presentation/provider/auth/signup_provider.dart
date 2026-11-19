// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:aegis/presentation/inputs/email_input.dart';
import 'package:aegis/presentation/inputs/password_input.dart';
import '../../inputs/id_input.dart';
import '../../inputs/last_name.dart';
import '../../inputs/municipality_input.dart';
import '../../inputs/name_input.dart';
import '../../inputs/province_input.dart';
import '../../inputs/workplace_input.dart';

/// Estado del formulario de registro.
/// Estado del formulario de registro.
class SignupFormState {
  final bool isPosting; // Si el formulario está enviando datos
  final bool formPosted; // Si el formulario fue enviado
  final bool isValid; // Si el formulario es válido
  final String? errorMessage;
  final NameInput name; // Campo de nombre completo
  final LastNameInput lastName;
  final EmailInput email; // Campo de correo electrónico
  final PasswordInput password; // Campo de contraseña
  final PasswordInput confirmPassword; // Campo de contraseña
  final ProvinceInput province; // Campo de provincia
  final MunicipalityInput municipality; // Campo de municipio
  final WorkPlaceInput workPlace; // Campo de lugar de trabajo
  final IdInput regProfesional; // Campo de ID profesional

  SignupFormState({
    this.isPosting = false,
    this.formPosted = false,
    this.isValid = false,
    this.errorMessage,
    this.name = const NameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const PasswordInput.pure(),
    this.province = const ProvinceInput.pure(),
    this.municipality = const MunicipalityInput.pure(),
    this.workPlace = const WorkPlaceInput.pure(),
    this.regProfesional = const IdInput.pure(),
  });

  /// Método para copiar y actualizar el estado.
  SignupFormState copyWith({
    bool? isPosting,
    bool? formPosted,
    bool? isValid,
    String? errorMessage,
    NameInput? name,
    LastNameInput? lastName,
    EmailInput? email,
    ProvinceInput? province,
    MunicipalityInput? municipality,
    WorkPlaceInput? workPlace,
    PasswordInput? password,
    PasswordInput? confirmPassword,
    IdInput? regProfesional,
  }) {
    return SignupFormState(
      isPosting: isPosting ?? this.isPosting,
      formPosted: formPosted ?? this.formPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      province: province ?? this.province,
      municipality: municipality ?? this.municipality,
      workPlace: workPlace ?? this.workPlace,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      regProfesional: regProfesional ?? this.regProfesional,
    );
  }
}

/// Notificador del formulario de registro.
class SignupFormNotifier extends StateNotifier<SignupFormState> {
  SignupFormNotifier() : super(SignupFormState());

  /// Actualiza el campo de nombre completo y verifica si es válido.
  void updateName(String value) {
    final newName = NameInput.dirty(value);
    _updateSignupState(name: newName);
  }

  /// Actualiza el campo de apellido y verifica si es válido.
  void updateLastName(String value) {
    final newLastName = LastNameInput.dirty(value);
    _updateSignupState(lastName: newLastName);
  }

  /// Actualiza el campo de correo electrónico y verifica si es válido.
  void updateEmail(String value) {
    final newEmail = EmailInput.dirty(value);
    _updateSignupState(email: newEmail);
  }

  /// Actualiza el campo de contraseña y verifica si es válida.
  void updatePassword(String value) {
    final newPassword = PasswordInput.dirty(value);
    _updateSignupState(password: newPassword);
  }

  updateConfirmPassword(String value) {
    final newPassword = PasswordInput.dirty(value);
    _updateSignupState(confirmPassword: newPassword);
  }

  /// Actualiza el campo de ID profesional y verifica si es válido.
  void updateRegProfesional(String value) {
    final newRegProfesional = IdInput.dirty(value);
    _updateSignupState(regProfesional: newRegProfesional);
  }

  /// Actualiza el campo de provincia.
  void updateProvince(String value) {
    final newProvince = ProvinceInput.dirty(value);
    _updateSignupState(province: newProvince);
  }

  /// Actualiza el campo de municipio.
  void updateMunicipality(String value) {
    final newMunicipality = MunicipalityInput.dirty(value);
    _updateSignupState(municipality: newMunicipality);
  }

  /// Actualiza el campo de lugar de trabajo.
  void updateWorkPlace(String value) {
    final newWorkPlace = WorkPlaceInput.dirty(value);
    _updateSignupState(workPlace: newWorkPlace);
  }

  /// Simula el envío del formulario.
  Future<({bool isValid, String? errorMessage})> submitForm() async {
    _dirtyEveryFields();
    if (!state.isValid)
      return (
        isValid: state.isValid,
        errorMessage: state.errorMessage,
      );

    try {
      state = state.copyWith(isPosting: true);
      // TODO: Aquí se realiza la petición al backend
      await Future.delayed(const Duration(seconds: 2));

      return (
        isValid: true,
        errorMessage: null,
      );
    } catch (e) {
      // En caso de error inesperado, devolvemos un mensaje de error.
      return (
        isValid: false,
        errorMessage: 'Error inesperado al enviar la lesión.',
      );
    } finally {
      state = state.copyWith(
        isPosting: false,
        formPosted: true,
      );
    }
  }

  /// Marca todos los campos como "dirty" y valida el formulario.
  void _dirtyEveryFields() {
    final name = NameInput.dirty(state.name.value);
    final lastName = LastNameInput.dirty(state.lastName.value);
    final email = EmailInput.dirty(state.email.value);
    final password = PasswordInput.dirty(state.password.value);
    final confirmPassword = PasswordInput.dirty(state.confirmPassword.value);

    final province = ProvinceInput.dirty(state.province.value);
    final municipality = MunicipalityInput.dirty(state.municipality.value);
    final workPlace = WorkPlaceInput.dirty(state.workPlace.value);
    final regProfesional = IdInput.dirty(state.regProfesional.value);

    state = state.copyWith(
      name: name,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      province: province,
      municipality: municipality,
      workPlace: workPlace,
      formPosted: true,
      regProfesional: regProfesional,
    );

    _validateSignupForm(state);
  }

  /// Método auxiliar para actualizar el estado y validar el formulario.
  void _updateSignupState({
    NameInput? name,
    LastNameInput? lastName,
    EmailInput? email,
    ProvinceInput? province,
    MunicipalityInput? municipality,
    WorkPlaceInput? workPlace,
    PasswordInput? password,
    PasswordInput? confirmPassword,
    IdInput? regProfesional,
  }) {
    final newState = state.copyWith(
      name: name ?? state.name,
      lastName: lastName ?? state.lastName,
      email: email ?? state.email,
      province: province ?? state.province,
      municipality: municipality ?? state.municipality,
      workPlace: workPlace ?? state.workPlace,
      password: password ?? state.password,
      confirmPassword: confirmPassword ?? state.confirmPassword,
      regProfesional: regProfesional ?? state.regProfesional,
    );

    _validateSignupForm(newState);
  }

  /// Valida el estado del formulario de registro.
  void _validateSignupForm(SignupFormState signupFormState) {
    final validation = _getSignupFormValidation(signupFormState);
    state = signupFormState.copyWith(
      isValid: validation.isValid,
      errorMessage: validation.errorMessage,
    );
  }

  /// Retorna el resultado de la validación comprobando que los campos obligatorios no estén vacíos.
  ({bool isValid, String? errorMessage}) _getSignupFormValidation(
      SignupFormState signupFormState) {
    final isValid = Formz.validate([
      signupFormState.name,
      signupFormState.lastName,
      signupFormState.email,
      signupFormState.password,
      signupFormState.confirmPassword,
      signupFormState.province,
      signupFormState.municipality,
      signupFormState.workPlace,
      signupFormState.regProfesional,
    ]);

    if (!isValid) {
      return (
        isValid: false,
        errorMessage: 'Verifique los campos',
      );
    }

    if (signupFormState.password != signupFormState.confirmPassword) {
      return (
        isValid: false,
        errorMessage: 'La contraseña y su confirmación no coinciden',
      );
    }

    return (isValid: true, errorMessage: '');
  }
}

/// Proveedor de Riverpod para el SignupFormNotifier.
final signupFormProvider =
    StateNotifierProvider.autoDispose<SignupFormNotifier, SignupFormState>(
        (ref) {
  return SignupFormNotifier();
});
