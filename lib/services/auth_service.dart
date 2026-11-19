// services/auth_service.dart
import '../domain/entities/user.dart';
import '../domain/repositories/auth_repository.dart';
import '../infrastructure/datasources/auth_datasource_impl.dart';
import '../infrastructure/repositories/auth_repository_impl.dart';


// TODO: Arreglar esto
class AuthService {
  final AuthRepository authRepository;

  AuthService({
    AuthRepository? authRepository, // ✅ Parámetro opcional
  }) : authRepository = authRepository ?? 
          AuthRepositoryImpl( // ✅ Implementación por defecto
            dataSource: AuthDataSourceImpl(),
          );

  Future<User> login({required String email, required String password}) {
    return authRepository.login(email: email, password: password);
  }

  Future<User> checkAuthentication({required String token}) {
    return authRepository.checkAuthentication(token: token);
  } 

  Future<User?> signup({
    required String email,
    required String password,
    required String regProfessional,
    required String firstName,
    required String lastName,
  }) {
    return authRepository.signup(
      email: email,
      password: password,
      regProfessional: regProfessional,
      firstName: firstName,
      lastName: lastName,
    );
  }
}