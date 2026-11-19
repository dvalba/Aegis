import 'package:aegis/domain/entities/patient.dart';
import 'package:aegis/domain/entities/lesion.dart';
import 'package:aegis/domain/entities/auto_diagnosis.dart';
import 'package:aegis/domain/entities/tagged_image.dart';

abstract class MedicalReportDataSource {
  Future<int> savePatient(Patient patient);
  Future<int> addLesionToPatient(String patientId, Lesion lesion);
  Future<int> addAutoDiagnosisToLesion(int lesionId, AutoDiagnosis autoDiagnosis);
  Future<int> addTaggedImageToLesion(int lesionId, TaggedImage image);

  Future<int> updatePatient(Patient patient);
  Future<int> updateLesion(Lesion lesion);
  Future<int> updateAutoDiagnosis(AutoDiagnosis autoDiagnosis);
  Future<int> updateTaggedImage(TaggedImage image);

  Future<void> deletePatient(String patientId);
  Future<void> deleteLesion(int lesionId);
  Future<void> deleteAutoDiagnosis(int autoDiagnosisId);
  Future<void> deleteTaggedImage(int taggedImageId);

  Future<void> markAsSynced(String patientId);

  Future<Patient?> findPatientById(int isarId);
  Future<Lesion?> findLesionById(int isarId);
  Future<AutoDiagnosis?> findAutoDiagnosisById(int isarId);
  Future<TaggedImage?> findTaggedImageById(int isarId);

  Future<Patient> getPatient(String patientId);
  Future<List<Lesion>> getLesionsByPatientId(String patientId);
  Future<List<AutoDiagnosis>> getAutoDiagnosesByLesionId(int lesionId);
  Future<List<TaggedImage>> getTaggedImagesByLesionId(int lesionId);
  Future<List<Patient>> getAllPatients({bool onlyUnsynced = false, int offset = 0, int limit = 10});
}

