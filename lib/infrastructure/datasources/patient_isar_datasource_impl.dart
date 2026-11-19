import 'dart:io';
import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aegis/domain/datasources/medical_report_datasource.dart';
import 'package:aegis/domain/entities/patient.dart';
import 'package:aegis/domain/entities/auto_diagnosis.dart';
import 'package:aegis/domain/entities/lesion.dart';
import 'package:aegis/domain/entities/tagged_image.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

class IsarMedicalReportDataSourceImpl implements MedicalReportDataSource {
  late final Future<Isar> db;

  IsarMedicalReportDataSourceImpl() {
    db = _openDB();
  }

  /// Abre la base de datos Isar.
  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PatientSchema, LesionSchema, TaggedImageSchema, AutoDiagnosisSchema],
        directory: dir.path,
        inspector: true, // Habilita el inspector para depuración
      );
    }
    return Future.value(Isar.getInstance()!);
  }

  // ============================================================
  // MÉTODOS EXISTENTES (CREATE)
  // ============================================================

  @override
  Future<int> savePatient(Patient patient) async {
    final isar = await db;

    // Verificar si el paciente ya existe
    final existingPatient = await isar.patients
        .filter()
        .patientIdEqualTo(patient.patientId)
        .findFirst();

    if (existingPatient != null) {
      throw Exception('El paciente con ID ${patient.patientId} ya existe.');
    }

    // Guardar el nuevo paciente
    return await isar.writeTxn(() async {
      return await isar.patients.put(patient);
    });
  }

  @override
  Future<int> addLesionToPatient(String patientId, Lesion lesion) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      final patient =
          await isar.patients.filter().patientIdEqualTo(patientId).findFirst();
      if (patient == null) {
        throw Exception('Paciente con ID $patientId no encontrado.');
      }

      lesion.patientId = patientId;
      final lesionId = await isar.lesions.put(lesion);

      await patient.lesions.load();
      patient.lesions.add(lesion);
      await patient.lesions.save();

      return lesionId;
    });
  }

  @override
  Future<int> addAutoDiagnosisToLesion(
      int lesionId, AutoDiagnosis autoDiagnosis) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      final lesion = await isar.lesions.get(lesionId);
      if (lesion == null) {
        throw Exception('Lesión con ID $lesionId no encontrada.');
      }

      autoDiagnosis.lesionId = lesionId;
      final autoDiagnosisId = await isar.autoDiagnosis.put(autoDiagnosis);

      await lesion.autoDiagnoses.load();
      lesion.autoDiagnoses.add(autoDiagnosis);
      await lesion.autoDiagnoses.save();

      return autoDiagnosisId;
    });
  }

  @override
  Future<int> addTaggedImageToLesion(int lesionId, TaggedImage image) async {
    final isar = await db;
    final lesion = await isar.lesions.get(lesionId);
    if (lesion == null) {
      throw Exception('Lesión con ID $lesionId no encontrada.');
    }

    final directory = await getApplicationDocumentsDirectory();
    final safeDirectory = Directory('${directory.path}/Images');
    if (!await safeDirectory.exists()) {
      await safeDirectory.create(recursive: true);
    }

    final uuid = Uuid();
    final uniqueId = uuid.v4();
    final newFileName = '${image.tag}_$uniqueId.jpg';
    final safeImagePath = '${safeDirectory.path}/$newFileName';

    final originalImage = File(image.imagePath);
    final bytes = await originalImage.readAsBytes();
    final decodedImage = img.decodeImage(Uint8List.fromList(bytes));
    if (decodedImage == null) {
      throw Exception('No se pudo decodificar la imagen.');
    }
    final jpgBytes = img.encodeJpg(decodedImage);
    final newImageFile = File(safeImagePath);
    await newImageFile.writeAsBytes(jpgBytes);

    final updatedImage = TaggedImage(
      imagePath: safeImagePath,
      tag: image.tag,
    );
    updatedImage.lesionId = lesionId;

    return await isar.writeTxn(() async {
      final imageId = await isar.taggedImages.put(updatedImage);

      await lesion.images.load();
      lesion.images.add(updatedImage);
      await lesion.images.save();

      return imageId;
    });
  }

  // ============================================================
  // MÉTODOS DE ACTUALIZACIÓN (UPDATE)
  // ============================================================

  @override
  Future<int> updatePatient(Patient patient) async {
    final isar = await db;
    final existingPatient = await findPatientById(patient.isarId);
    if (existingPatient == null) {
      throw Exception('Paciente con ID ${patient.isarId} no encontrado.');
    }

    final duplicatePatient = await isar.patients
        .filter()
        .patientIdEqualTo(patient.patientId)
        .findFirst();
    if (duplicatePatient != null && duplicatePatient.isarId != patient.isarId) {
      throw Exception(
          'Ya existe un paciente con patientId ${patient.patientId}. Elimine el paciente duplicado para evitar inconsistencias.');
    }

    return await isar.writeTxn(() async {
      return await isar.patients.put(patient);
    });
  }

  @override
  Future<int> updateLesion(Lesion lesion) async {
    final isar = await db;
    final existingLesion = await findLesionById(lesion.isarId);
    if (existingLesion == null) {
      throw Exception('Lesión con ID ${lesion.isarId} no encontrada.');
    }

    return await isar.writeTxn(() async {
      return await isar.lesions.put(lesion);
    });
  }

  @override
  Future<int> updateAutoDiagnosis(AutoDiagnosis autoDiagnosis) async {
    final isar = await db;
    final existingDiagnosis = await findAutoDiagnosisById(autoDiagnosis.isarId);
    if (existingDiagnosis == null) {
      throw Exception(
          'Diagnóstico automático con ID ${autoDiagnosis.isarId} no encontrado.');
    }
    autoDiagnosis.lesionId = existingDiagnosis.lesionId;
    return await isar.writeTxn(() async {
      return await isar.autoDiagnosis.put(autoDiagnosis);
    });
  }

  @override
  Future<int> updateTaggedImage(TaggedImage image) async {
    final isar = await db;
    final existingImage = await findTaggedImageById(image.isarId);
    if (existingImage == null) {
      throw Exception('Imagen con ID ${image.isarId} no encontrada.');
    }

    return await isar.writeTxn(() async {
      return await isar.taggedImages.put(image);
    });
  }

  @override
  Future<void> markAsSynced(String patientId) async {
    final isar = await db;
    final patient =
        await isar.patients.filter().patientIdEqualTo(patientId).findFirst();
    if (patient == null) {
      throw Exception('Paciente con ID $patientId no encontrado.');
    }

    patient.synced = true;
    await isar.writeTxn(() async {
      await isar.patients.put(patient);
    });
  }

  // ============================================================
  // MÉTODOS DE CONSULTA (READ)
  // ============================================================

  @override
  Future<Patient?> findPatientById(int isarId) async {
    final isar = await db;
    return await isar.patients.get(isarId);
  }

  @override
  Future<Lesion?> findLesionById(int isarId) async {
    final isar = await db;
    return await isar.lesions.get(isarId);
  }

  @override
  Future<AutoDiagnosis?> findAutoDiagnosisById(int isarId) async {
    final isar = await db;
    return await isar.autoDiagnosis.get(isarId);
  }

  @override
  Future<TaggedImage?> findTaggedImageById(int isarId) async {
    final isar = await db;
    return await isar.taggedImages.get(isarId);
  }

  @override
  Future<Patient> getPatient(String patientId) async {
    final isar = await db;
    final patient =
        await isar.patients.filter().patientIdEqualTo(patientId).findFirst();
    if (patient == null) {
      throw Exception('Paciente con ID $patientId no encontrado.');
    }

    await patient.lesions.load();
    for (final lesion in patient.lesions) {
      await lesion.images.load();
      await lesion.autoDiagnoses.load();
    }

    return patient;
  }

  @override
  Future<List<Lesion>> getLesionsByPatientId(String patientId) async {
    final isar = await db;
    final lesions =
        await isar.lesions.filter().patientIdEqualTo(patientId).findAll();
    for (final lesion in lesions) {
      await lesion.images.load();
      await lesion.autoDiagnoses.load();
    }
    return lesions;
  }

  @override
  Future<List<AutoDiagnosis>> getAutoDiagnosesByLesionId(int lesionId) async {
    final isar = await db;
    return await isar.autoDiagnosis
        .filter()
        .lesionIdEqualTo(lesionId)
        .findAll();
  }

  @override
  Future<List<TaggedImage>> getTaggedImagesByLesionId(int lesionId) async {
    final isar = await db;
    return await isar.taggedImages.filter().lesionIdEqualTo(lesionId).findAll();
  }

  @override
  Future<List<Patient>> getAllPatients({
    bool onlyUnsynced = false,
    int offset = 0,
    int limit = 10,
  }) async {
    final isar = await db;
    List<Patient> patients;
    if (onlyUnsynced) {
      patients = await isar.patients
          .filter()
          .syncedEqualTo(false)
          .offset(offset)
          .limit(limit)
          .findAll();
    } else {
      patients =
          await isar.patients.where().offset(offset).limit(limit).findAll();
    }

    for (final patient in patients) {
      await patient.lesions.load();
      for (final lesion in patient.lesions) {
        await lesion.images.load();
        await lesion.autoDiagnoses.load();
      }
    }

    return patients;
  }

  // ============================================================
  // MÉTODOS DE ELIMINACIÓN (DELETE)
  // ============================================================

  @override
  Future<void> deletePatient(String patientId) async {
  final isar = await db;
  final patient = await isar.patients.filter().patientIdEqualTo(patientId).findFirst();
  if (patient == null) {
    throw Exception('Paciente con ID $patientId no encontrado.');
  }

  await isar.writeTxn(() async {
    await patient.lesions.load();

    for (final lesion in patient.lesions) {

      await lesion.autoDiagnoses.load();
      await lesion.images.load();

      for (final image in lesion.images) {
        final file = File(image.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
        await isar.taggedImages.delete(image.isarId);
      }

      for (final autoDiagnosis in lesion.autoDiagnoses) {
        await isar.autoDiagnosis.delete(autoDiagnosis.isarId);
      }

      await isar.lesions.delete(lesion.isarId);
    }

    await isar.patients.delete(patient.isarId);
  });
}

@override
  Future<void> deleteLesion(int lesionId) async {
  final isar = await db;

  final lesion = await isar.lesions.get(lesionId);
  if (lesion == null) {
    throw Exception('Lesión con ID $lesionId no encontrada.');
  }

  await isar.writeTxn(() async {
 
     await lesion.autoDiagnoses.load();
    await lesion.images.load();

    for (final image in lesion.images) {
      final file = File(image.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      await isar.taggedImages.delete(image.isarId);
    }

    for (final autoDiagnosis in lesion.autoDiagnoses) {
      await isar.autoDiagnosis.delete(autoDiagnosis.isarId);
    }

    // Eliminar la lesión de la relación con el paciente
    final patient = await isar.patients.filter().patientIdEqualTo(lesion.patientId).findFirst();
    if (patient != null) {
      await patient.lesions.load();
      patient.lesions.removeWhere((l) => l.isarId == lesionId);
      await patient.lesions.save();
    }

    await isar.lesions.delete(lesionId);
  });
}




  @override
  Future<void> deleteAutoDiagnosis(int autoDiagnosisId) async {
  final isar = await db;

  // Verificar que el diagnóstico automático exista
  final autoDiagnosis = await isar.autoDiagnosis.get(autoDiagnosisId);
  if (autoDiagnosis == null) {
    throw Exception('Diagnóstico automático con ID $autoDiagnosisId no encontrado.');
  }

  await isar.writeTxn(() async {
    // Cargar la lesión asociada al diagnóstico automático
    final lesion = await isar.lesions.get(autoDiagnosis.lesionId);
    if (lesion != null) {
      await lesion.autoDiagnoses.load();
      lesion.autoDiagnoses.removeWhere((ad) => ad.isarId == autoDiagnosisId);
      await lesion.autoDiagnoses.save();
    }
    // Eliminar el diagnóstico automático de la base de datos
    await isar.autoDiagnosis.delete(autoDiagnosisId);
  });
}

@override
  Future<void> deleteTaggedImage(int taggedImageId) async {
  final isar = await db;

  // Verificar que la imagen exista
  final taggedImage = await isar.taggedImages.get(taggedImageId);
  if (taggedImage == null) {
    throw Exception('Imagen con ID $taggedImageId no encontrada.');
  }

  await isar.writeTxn(() async {
    // Cargar la lesión asociada a la imagen
    final lesion = await isar.lesions.get(taggedImage.lesionId);
    if (lesion != null) {
      await lesion.images.load();
      lesion.images.removeWhere((img) => img.isarId == taggedImageId);
      await lesion.images.save();
    }

    // Eliminar la imagen de la base de datos
    await isar.taggedImages.delete(taggedImageId);
  });

  // Opcional: eliminar el archivo físico de la imagen
  final file = File(taggedImage.imagePath);
  if (await file.exists()) {
    await file.delete();
  }
}

  

}