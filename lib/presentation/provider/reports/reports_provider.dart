// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aegis/presentation/provider/records/patient_form_provider.dart';

import '../../../infrastructure/dtos/patient_dto.dart';
import '../../../infrastructure/dtos/report_dto.dart';
import '../../../services/records_service.dart';
import '../auth/auth_provider.dart';
import '../records/record_service_provider.dart';

// class FakeReportService {
//   static final List<PatientDTO> _patients = List.generate(50, (index) {
//     return PatientDTO(
//       patientId: "P$index",
//       name: "Paciente$index",
//       lastName: "Apellido$index",
//       age: Random().nextInt(50) + 20,
//       sex: index % 2 == 0 ? "Masculino" : "Femenino",
//       healthRecord: "Historial médico $index",
//       lesions: [
//         LesionDTO(
//           clinicalDiagnosis: "Melanoma",
//           autoDiagnoses: [
//             AutoDiagnosisDTO(
//               diagnosis: "Melanoma",
//               probability: "${Random().nextInt(50) + 50}",
//               dateTime: DateTime.now(),
//               modelTag: "v1.0", // Added required modelTag parameter
//             ),
//           ],
//           location: "Brazo",
//           phototype: "III",
//           images: [
//             TaggedImageDTO(
//                 imagePath: "https://example.com/lesion$index.jpg",
//                 tag: ImageType.dermatoscopic),
//           ],
//         )
//       ],
//     );
//   });

//   static Future<List<PatientDTO>> fetchReports(int offset, int limit) async {
//     await Future.delayed(Duration(seconds: 1)); // Simulación de latencia
//     return _patients.skip(offset).take(limit).toList();
//   }
// }

class ReportsState {
  final List<PatientDTO> patients;
  final bool isLoading;

  ReportsState({
    this.patients = const [],
    this.isLoading = false,
  });

  ReportsState copyWith({
    List<PatientDTO>? patients,
    bool? hasMoreReports,
    bool? isLoading,
  }) {
    return ReportsState(
      patients: patients ?? this.patients,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ReportsNotifier extends StateNotifier<ReportsState> {
  final PatientFormNotifier patientFormNotifier;
  RecordsService recordsService;
  final int doctorId; // Nuevo campo
  // ... resto de código

  ReportsNotifier(
    this.patientFormNotifier,
    this.recordsService,
    this.doctorId,
  ) : super(ReportsState());

  static const int _pageSize = 10;
  int _offset = 0;

  Future<({bool isValid, String? errorMessage})> submitReport() async {
    try {
      final newReport = await patientFormNotifier.createPatient();

      if (newReport == null) {
        return (
          isValid: patientFormNotifier.state.isValid,
          errorMessage: patientFormNotifier.state.errorMessage,
        );
      }

      // Guardar el paciente en el repositorio usando RecordsService
      await recordsService.savePatient(newReport, doctorId);

      // state = state.copyWith(patients: [...state.patients, newReport]);

      patientFormNotifier.clearForm();

      return (isValid: true, errorMessage: null);
    } catch (e) {
      return (
        isValid: false,
        errorMessage: 'Error inesperado al enviar el reporte: $e',
      );
    }
  }

  Future<({bool isValid, String? errorMessage})> updateReportAt(
      int index) async {
    if (index < 0 || index >= state.patients.length) {
      throw RangeError(
          'Índice fuera de rango al intentar actualizar el reporte.');
    }

    try {
      final updatedReport = await patientFormNotifier.createPatient();

      if (updatedReport == null) {
        return (
          isValid: patientFormNotifier.state.isValid,
          errorMessage: patientFormNotifier.state.errorMessage,
        );
      }

      final updatedPatients = List.of(state.patients);

      //TODO: Revisar si este servicio funciona , creo que no funciona revisar este parche
      await recordsService.updatePatient(updatedReport, doctorId);
      updatedPatients[index] =
          (await recordsService.getPatient(updatedReport.patientId))!;
      state = state.copyWith(patients: updatedPatients);
      patientFormNotifier.clearForm();

      return (isValid: true, errorMessage: null);
    } catch (e) {
      return (
        isValid: false,
        errorMessage: 'Error al actualizar el reporte. $e',
      );
    }
  }

  // Método para obtener los detalles de un reporte a partir de un índice
  ReportDetailsDTO? getReportDetails(int index) {
    if (index < 0 || index >= state.patients.length) return null;

    final patient = state.patients[index];

    // Verificamos si el paciente tiene lesiones registradas
    if (patient.lesions.isEmpty) return null;

    final lesion =
        patient.lesions.first; // Tomamos la primera lesión como referencia

    return ReportDetailsDTO(
      name: patient.name,
      lastName: patient.lastName,
      patientId: patient.patientId,
      autoDiagnosis: lesion.autoDiagnoses.firstOrNull?.diagnosis,
      probability: lesion.autoDiagnoses.firstOrNull?.probability,
      location: lesion.location,
      imageUrl: lesion.images.isNotEmpty
          ? lesion.images.first.imagePath
          : "https://example.com/default.jpg",
      date: lesion.autoDiagnoses.firstOrNull?.dateTime ?? DateTime.now(),
    );
  }

  Future<void> loadReports({String? searchId}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      List<PatientDTO> newReports;

      if (searchId != null && searchId.isNotEmpty) {
        // Buscar paciente por ID
        final patient = await recordsService.getPatientById(searchId);
        newReports = patient != null ? [patient] : [];
      } else {
        // Cargar todos los pacientes
        newReports = await recordsService.getAllPatients(
          offset: _offset,
          limit: _pageSize,
        );
      }

      // Limpiar y reflejar el estado de la base de datos
      state = state.copyWith(
        patients: [...newReports],
        isLoading: false,
      );

      _offset = newReports.length;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception('Error al cargar los reportesgetPatientById: $e');
    }
  }

  void reset() {
    _offset = 0;
  }

  void deleteLesion(int patientIndex, int lesionId) {
    final updatedPatients = [...state.patients];
    final patient = updatedPatients[patientIndex];

    // Eliminar la lesión del paciente
    patient.lesions.removeWhere((lesion) => lesion.isarId == lesionId);

    // Actualizar el estado
    state = state.copyWith(patients: updatedPatients);
  }
}

final reportProvider =
    StateNotifierProvider.autoDispose<ReportsNotifier, ReportsState>((ref) {
  final authState = ref.watch(authProvider);
  final doctorId = authState.user?.id ?? 0; // Manejo de nulos

  final patientFormNotifier = ref.watch(patientFormProvider.notifier);
  final recordsService = ref.watch(recordsServiceProvider);
  final notifier =
      ReportsNotifier(patientFormNotifier, recordsService, doctorId);

  return notifier;
});
