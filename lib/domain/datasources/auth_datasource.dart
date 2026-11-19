import '../entities/user.dart';

abstract class AuthDataSource {
  // Login: Todos los parámetros son obligatorios.
  Future<User> login({
    required String email,
    required String password,
  });

  // Signup: Todos los parámetros son obligatorios, excepto los que tienen valores predeterminados.
  Future<User> signup({
    required String email,
    required String password,
    required String regProfessional,
    required String firstName,
    required String lastName,
    String province = '', // Opcional con valor predeterminado
    String municipality = '', // Opcional con valor predeterminado
    String workPlace = '', // Opcional con valor predeterminado
  });

  Future<User> checkAuthentication({
    required String token,
  });
}
