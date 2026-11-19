import 'package:aegis/domain/entities/auto_diagnosis.dart';
import 'package:aegis/domain/entities/patient.dart';
import 'package:aegis/domain/entities/tagged_image.dart';
import '../../domain/datasources/medical_report_datasource.dart';
import '../../domain/entities/lesion.dart';
import '../../domain/repositories/medical_report_repository.dart';
import '../datasources/patient_isar_datasource_impl.dart';

class MedicalReportRepositoryImpl implements MedicalReportRepository {
  final MedicalReportDataSource dataSource;

  MedicalReportRepositoryImpl({MedicalReportDataSource? dataSource})
      : dataSource = dataSource ?? IsarMedicalReportDataSourceImpl();

  @override
  Future<int> savePatient(Patient patient) async {
    return await dataSource.savePatient(patient);
  }

  @override
  Future<int> addLesionToPatient(String patientId, Lesion lesion) async {
    return await dataSource.addLesionToPatient(patientId, lesion);
  }

  @override
  Future<int> addAutoDiagnosisToLesion(
      int lesionId, AutoDiagnosis autoDiagnosis) async {
    return await dataSource.addAutoDiagnosisToLesion(lesionId, autoDiagnosis);
  }

  @override
  Future<int> addTaggedImageToLesion(int lesionId, TaggedImage image) async {
    return await dataSource.addTaggedImageToLesion(lesionId, image);
  }

  @override
  Future<int> updatePatient(Patient patient) async {
    return await dataSource.updatePatient(patient);
  }

  @override
  Future<int> updateLesion(Lesion lesion) async {
    return await dataSource.updateLesion(lesion);
  }

  @override
  Future<int> updateAutoDiagnosis(AutoDiagnosis autoDiagnosis) async {
    return await dataSource.updateAutoDiagnosis(autoDiagnosis);
  }

  @override
  Future<int> updateTaggedImage(TaggedImage image) async {
    return await dataSource.updateTaggedImage(image);
  }

  @override
  Future<void> deletePatient(String patientId) async {
    await dataSource.deletePatient(patientId);
  }

  @override
  Future<void> deleteLesion(int lesionId) async {
    await dataSource.deleteLesion(lesionId);
  }

  @override
  Future<void> deleteAutoDiagnosis(int autoDiagnosisId) async {
    await dataSource.deleteAutoDiagnosis(autoDiagnosisId);
  }

  @override
  Future<void> deleteTaggedImage(int taggedImageId) async {
    await dataSource.deleteTaggedImage(taggedImageId);
  }

  @override
  Future<void> markAsSynced(String patientId) async {
    await dataSource.markAsSynced(patientId);
  }

  @override
  Future<Patient?> findPatientById(int isarId) async {
    return await dataSource.findPatientById(isarId);
  }

  @override
  Future<Lesion?> findLesionById(int isarId) async {
    return await dataSource.findLesionById(isarId);
  }

  @override
  Future<AutoDiagnosis?> findAutoDiagnosisById(int isarId) async {
    return await dataSource.findAutoDiagnosisById(isarId);
  }

  @override
  Future<TaggedImage?> findTaggedImageById(int isarId) async {
    return await dataSource.findTaggedImageById(isarId);
  }

  @override
  Future<Patient> getPatient(String patientId) async {
    return await dataSource.getPatient(patientId);
  }

  @override
  Future<List<Lesion>> getLesionsByPatientId(String patientId) async {
    return await dataSource.getLesionsByPatientId(patientId);
  }

  @override
  Future<List<AutoDiagnosis>> getAutoDiagnosesByLesionId(int lesionId) async {
    return await dataSource.getAutoDiagnosesByLesionId(lesionId);
  }

  @override
  Future<List<TaggedImage>> getTaggedImagesByLesionId(int lesionId) async {
    return await dataSource.getTaggedImagesByLesionId(lesionId);
  }

  @override
  Future<List<Patient>> getAllPatients({
    bool onlyUnsynced = false,
    int offset = 0,
    int limit = 10,
  }) async {
    return await dataSource.getAllPatients(
      onlyUnsynced: onlyUnsynced,
      offset: offset,
      limit: limit,
    );
  }
}
