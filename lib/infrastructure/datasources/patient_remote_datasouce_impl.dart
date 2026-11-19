// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';

import '../../configs/constants/environment.dart';
import '../../domain/datasources/patient_remote_datasource.dart';
import '../../domain/entities/patient.dart';
import '../errors/errors.dart';

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final String authToken;
  late final Dio _dio;

//TODO: Implementar la Comunicacion con la API

  PatientRemoteDataSourceImpl({
    required this.authToken,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {'Authorization': 'Token $authToken'},
    ));
  }

  @override
  Future<void> createPatient(Patient patient) async {
    try {
      await _dio.post(
        '/api/v1/pacients/create/'
        
        //data: PatientMapper.toJson(patient), // Convierte Patient a JSON
      );
    } on DioException catch (e) {
      _handleDioError(e);
      throw Exception('Unknown error: ${e.message}');
    }
  }

  @override
  Future<void> updatePatient(Patient patient) async {
    try {
        await _dio.patch(
        '/api/v1/pacients/${patient.patientId}/modify/',
        
       // data: PatientMapper.toJson(patient), // Convierte Patient a JSON
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw PatientNotFoundError();
      }
      _handleDioError(e);
      throw Exception('Unknown error: ${e.message}');
    }
  }

  @override
  Future<void> deletePatient(String patientId) async {
    try {
      await _dio.delete(
        '/api/v1/pacients/$patientId/delete/',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw PatientNotFoundError();
      }
      _handleDioError(e);
      throw Exception('Unknown error: ${e.message}');
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutError();
      case DioExceptionType.connectionError:
        throw ConnectionError();
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          throw UnauthorizedError();
        }
        if (e.response?.statusCode == 403) {
          throw ForbiddenError();
        }
        break;
      default:
        throw NetworkError();
    }
  }
}
