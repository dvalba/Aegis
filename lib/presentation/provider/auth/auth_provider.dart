// ignore_for_file: public_member_api_docs, sort_constructors_first
// Definimos los posibles estados de autenticación
import 'dart:async';

import 'package:aegis/infrastructure/errors/errors.dart';
import 'package:aegis/infrastructure/services/key_value_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aegis/services/auth_service.dart';
import '../../../domain/entities/user.dart';
import '../../../infrastructure/services/key_value_storage.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;
  final KeyValueStorage storage;

  AuthNotifier()
      : authService = AuthService(),
        storage = KeyValueStorageImpl(),
        super(AuthState()) {
    checkAuthentication();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final user = await authService.login(email: email, password: password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout('Wrong Credentials');
    } on ConnectionTimeoutError {
      logout('Connection Timeout');
    } on ConnectionError {
      logout('Connection Error');
    } catch (e) {
      throw Exception('Error desconocido: $e');
    }
  }

  Future<void> checkAuthentication() async {
    final token = await storage.getValue<String>('token');

    if (token == null) {
      return logout();
    }
    try {
      final user = await authService.checkAuthentication(token: token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }

    // return dataSource.checkAuthentication(token: token);
  }

  void signup(
      {required String email,
      required String password,
      required String regProfessional,
      required String firstName,
      required String lastName,
      String province = '',
      String municipality = '',
      String workPlace = ''}) {
    // return dataSource.signup(email: email, password: password, regProfessional: regProfessional, firstName: firstName, lastName: lastName);
  }

  Future<void> _setLoggedUser(User user) async {
    await storage.setKeyValue('token', user.token);
    state = state.copyWith(
        user: user, status: AuthStatus.authenticated, errorMessage: '');
  }

  Future<void> logout([String? errorMessage]) async {
    await storage.removeKey('token');
    state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus {
  checking, // Se está revisando si el usuario existe o no
  notVerified, // El usuario existe pero no está verificado (no autenticado)
  authenticated, // El usuario está autenticado y verificado
  unauthenticated, // El usuario no está autenticado (no sabemos si existe o no)
}

// Clase que representa el estado de autenticación
class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  // Constructor
  AuthState(
      {this.status = AuthStatus.checking, this.user, this.errorMessage = ''});

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) =>
      AuthState(
          status: status ?? this.status,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
