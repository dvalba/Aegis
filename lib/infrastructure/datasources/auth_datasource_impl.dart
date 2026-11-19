import 'package:aegis/infrastructure/errors/errors.dart';
import 'package:dio/dio.dart';

import '../../configs/constants/environment.dart';
import '../../domain/datasources/auth_datasource.dart';
import '../../domain/entities/user.dart';
import '../mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      // 1. Login para obtener el token
      final loginResponse = await _dio.post(
        '/auth/token/login', // Ruta exacta de tu API
        data: {'email': email, 'password': password},
      );

      // Extraer el token de la respuesta
      final authToken = loginResponse.data['auth_token'] as String;

      // 2. Obtener el perfil del usuario
      final profileResponse = await _dio.get(
        '/profile/', // Ruta completa del perfil
        options: Options(headers: {'Authorization': 'Token $authToken'}),
      );

      final Map<String, dynamic> data = {
        ...profileResponse.data, // Todos los datos del perfil
        'token': authToken, // Añadimos el token aquí
      };

      return UserMapper.toEntity(data);
    } on DioException catch (e) {
      // Manejo específico de errores de la API
      if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
        throw WrongCredentials();
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeoutError();
      }
      if (e.type == DioExceptionType.connectionError) {
        throw ConnectionError();
      }
      throw Exception('Error desconocido: $e');
    }
  }

  @override
  Future<User> checkAuthentication({required String token}) async {
    try {
      final profileResponse = await _dio.get(
        '/profile/', // Ruta completa del perfil
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      final user = UserMapper.toEntity(profileResponse.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw InvalidToken();
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeoutError();
      }
      if (e.type == DioExceptionType.connectionError) {
        throw ConnectionError();
      }
      throw Exception('Error desconocido: $e');
    }
  }

  @override
  Future<User> signup(
      {required String email,
      required String password,
      required String regProfessional,
      required String firstName,
      required String lastName,
      String province = '',
      String municipality = '',
      String workPlace = ''}) {
    throw UnimplementedError();
  }
}
