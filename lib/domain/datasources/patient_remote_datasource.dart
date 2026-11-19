import '../entities/patient.dart';

abstract class PatientRemoteDataSource {
  Future<void> createPatient(Patient patient);
  Future<void> updatePatient(Patient patient);
  Future<void> deletePatient(String patientId);
}



