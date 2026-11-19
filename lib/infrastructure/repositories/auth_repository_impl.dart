import 'package:aegis/domain/datasources/auth_datasource.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository
 {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<User> checkAuthentication({required String token}) {
    return dataSource.checkAuthentication(token: token);
  }
  @override
  Future<User> login({required String email, required String password}) {
    return dataSource.login(email: email, password: password);
  }
  @override
  Future<User> signup({required String email, required String password, required String regProfessional, required String firstName, required String lastName, String province = '', String municipality = '', String workPlace = ''}) {
    return dataSource.signup(email: email, password: password, regProfessional: regProfessional, firstName: firstName, lastName: lastName);
  }
}