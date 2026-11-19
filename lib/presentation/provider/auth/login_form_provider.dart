// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:aegis/presentation/inputs/email_input.dart';
import 'package:aegis/presentation/inputs/password_input.dart';
import 'package:aegis/presentation/provider/auth/auth_provider.dart';

// Provider de Riverpod para el LoginFormNotifier
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {

  final loginCallback  = ref.watch(authProvider.notifier).login;
  return LoginFormNotifier(loginCallback:loginCallback);
});

// StateNotifier para gestionar el estado del formulario
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Future<void> Function({required String email, required String password}) loginCallback;
  LoginFormNotifier({
    required this.loginCallback
  }) : super(LoginFormState());

  // Actualizar el email y verificar si es válido
  void updateEmail(String value) {
      final newEmail = EmailInput.dirty(value);
      state = state.copyWith(
        email:newEmail,
        isValid:Formz.validate([newEmail,state.password])
      );
  }

  // Actualizar la contraseña y verificar si es válida
  void updatePassword(String value) {
    final newPassword = PasswordInput.dirty(value);
      state = state.copyWith(
        password:newPassword,
        isValid:Formz.validate([state.email,newPassword])
      );
  }

  // Simular el envío del formulario
  Future<void> submitForm() async {
    _dirtyEveryFields();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    
    await loginCallback(
      email: state.email.value,
      password: state.password.value
    );

    
  }

  _dirtyEveryFields(){
    final email = EmailInput.dirty(state.email.value);
    final password = PasswordInput.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password:password, 
      formPosted: true,
      isValid: Formz.validate([email,password])
    );

  }


}

class LoginFormState {
  final bool isPosting; // Indica si el formulario se está enviando
  final bool formPosted; // Indica si el formulario ya fue enviado
  final bool isValid; // Indica si el formulario es válido
  final EmailInput email; // Campo de correo electrónico
  final PasswordInput password; // Campo de contraseña

  LoginFormState({
    this.isPosting = false,
    this.formPosted=false ,
    this.isValid = false,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
  });

  // Método para copiar y actualizar el estado
  LoginFormState copyWith({
    bool? isPosting,
    bool? formPosted,
    bool? isValid,
    EmailInput? email,
    PasswordInput? password,
  }) {
    return LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      formPosted: formPosted ?? this.formPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 
    """LoginFormState(
      isPosting: $isPosting, 
      formPosted: $formPosted,
      isValid: $isValid,
      email: $email,
      password: $password)""";
  }
}

