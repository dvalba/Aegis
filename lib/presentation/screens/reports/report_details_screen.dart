import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../configs/dynamic_elements/dropdown_items.dart';
import '../../../infrastructure/dtos/auto_diagnosis_dto.dart';
import '../../../infrastructure/dtos/lesion_dto.dart';
import '../../../infrastructure/dtos/patient_dto.dart';
import '../../provider/records/record_service_provider.dart';
import '../../provider/reports/reports_provider.dart';
import '../../widgets/shared/app_bar/custom_app_bar.dart';

class ReportDetailScreen extends ConsumerWidget {
  final int indexPatient;
  const ReportDetailScreen({super.key, required this.indexPatient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportNotifier = ref.watch(reportProvider.notifier);
    final detailsPatient = reportNotifier.getReportDetails(indexPatient);
    final patient = ref.watch(reportProvider).patients[indexPatient];

    final List<LesionDTO> lesionsWithAutoDiagnoses = patient.lesions
        .where((lesion) => lesion.autoDiagnoses.isNotEmpty)
        .toList();

    final latestDiagnosis = getLatestDiagnosis(lesionsWithAutoDiagnoses);

    final String formattedTime = latestDiagnosis != null
        ? "${latestDiagnosis.autoDiagnosis.dateTime.hour}:${latestDiagnosis.autoDiagnosis.dateTime.minute}"
        : "Hora no disponible";

    final String formattedDate = latestDiagnosis != null
        ? "${latestDiagnosis.autoDiagnosis.dateTime.day}/${latestDiagnosis.autoDiagnosis.dateTime.month}/${latestDiagnosis.autoDiagnosis.dateTime.year}"
        : "Fecha no disponible";

    return Scaffold(
      appBar: CustomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text(
                  "Último Autodiagnóstico",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Paciente: ${detailsPatient!.name} ${detailsPatient.lastName} \nID:${detailsPatient.patientId}",
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 100, 100, 100)),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "edit") {
                  editUserInfo(context, patient, indexPatient);
                } else if (value == "details") {
                  showUserInfo(context, ref);
                } else if (value == "delete") {
                  deleteUser(context, ref, patient);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: "edit", child: Text("Editar Paciente")),
                const PopupMenuItem(
                    value: "details", child: Text("Detalles del Paciente")),
                const PopupMenuItem(
                    value: "delete", child: Text("Eliminar Paciente")),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (latestDiagnosis != null) ...[
              _buildDiagnosisCard(
                title: "Diagnóstico clínico",
                description: latestDiagnosis.lesion.clinicalDiagnosis,
                color: Colors.green,
                icon: Icons.medical_services,
              ),
              (latestDiagnosis.lesion.histopathDiagnosis?.isNotEmpty ?? false)
                  ? _buildDiagnosisCard(
                      title: "Diagnóstico histopatológico",
                      description: latestDiagnosis.lesion.histopathDiagnosis!,
                      color: Colors.blue,
                      icon: Icons.biotech,
                    )
                  : _buildDiagnosisCard(
                      title: "Diagnóstico histopatológico",
                      description:
                          "No se ha registrado un diagnóstico histopatológico. Por favor, complete esta información, de ser posible.",
                      color: Colors.amber,
                      icon: Icons.warning,
                    ),
              _buildDiagnosisCard(
                title: "Diagnóstico Automático",
                description: formatAutoDiagnosis(latestDiagnosis.autoDiagnosis)
                    .join("\n"),
                color:
                    Colors.orange, // O puedes ajustar el color según convenga
                icon: Icons
                    .analytics, // También puedes cambiar el icono si lo deseas
              ),
              _buildDiagnosisCard(
                title: "Ubicación",
                description:
                    getbodyPartFromTag(latestDiagnosis.lesion.location),
                color: Colors.red,
                icon: Icons.location_on,
              ),
              _buildDiagnosisCard(
                title: "Fecha y Hora de Diagnóstico",
                description: "Hora: $formattedTime\nFecha: $formattedDate",
                color: Colors.blue,
                icon: Icons.calendar_today,
              ),
              const Divider(thickness: 1, height: 30),
            ] else
              Container(
                height: 350, // Ajusta la altura según sea necesario
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 48, 48, 48),
                        width: 2), // Línea separadora
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Generando autodiagnóstico... Por favor, espera un momento.",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Lesiones Registradas:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            // Utilizamos ListView.builder dentro del scroll view
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: patient.lesions.length,
              itemBuilder: (context, index) {
                final lesion = patient.lesions[index];
                return Dismissible(
                  key: Key(lesion.isarId.toString()),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    // Si solo queda una lesión, bloquear la eliminación
                    if (patient.lesions.length == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("No se puede eliminar la última lesión."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return false; // Cancelar el gesto de deslizamiento
                    }
                    return true; // Permitir el gesto de deslizamiento
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {
                    // Eliminar la lesión solo si hay más de una
                    await ref
                        .read(recordsServiceProvider)
                        .deleteLesion(lesion.isarId!);
                    ref.read(reportProvider.notifier).deleteLesion(indexPatient, lesion.isarId!);
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: const Icon(Icons.local_hospital,
                          color: Colors.redAccent),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Diagnóstico clínico: ${lesion.clinicalDiagnosis}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Diagnóstico automático: ${lesion.autoDiagnoses.isNotEmpty ? lesion.autoDiagnoses.reduce((ad1, ad2) => ad1.dateTime.isAfter(ad2.dateTime) ? ad1 : ad2).diagnosis[0] : "No disponible"}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 70, 70, 70)),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Probabilidad: ${lesion.autoDiagnoses.isNotEmpty ? "${lesion.autoDiagnoses.reduce((ad1, ad2) => ad1.dateTime.isAfter(ad2.dateTime) ? ad1 : ad2).probability[0]}%" : "No disponible"}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => showLesionDetails(context, lesion),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisCard({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // Envolvemos el contenido en un Container con decoración para aplicar un gradiente sutil
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              color.withAlpha((0.2 * 255).toInt()), // 20% opacity
              color.withAlpha((0.05 * 255).toInt()),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showUserInfo(BuildContext context, WidgetRef ref) {
    final detailsPatient =
        ref.read(reportProvider.notifier).getReportDetails(indexPatient);
    if (detailsPatient == null) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Información del Paciente"),
        content: Text("Detalles sobre ${detailsPatient.name}."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  ({LesionDTO lesion, AutoDiagnosisDTO autoDiagnosis})? getLatestDiagnosis(
      List<LesionDTO> lesions) {
    if (lesions.isEmpty) return null;

    final lesion = lesions.reduce((lesion1, lesion2) {
      final latestAutoDiagnosis1 = lesion1.autoDiagnoses
          .reduce((ad1, ad2) => ad1.dateTime.isAfter(ad2.dateTime) ? ad1 : ad2);

      final latestAutoDiagnosis2 = lesion2.autoDiagnoses
          .reduce((ad1, ad2) => ad1.dateTime.isAfter(ad2.dateTime) ? ad1 : ad2);

      return latestAutoDiagnosis1.dateTime
              .isAfter(latestAutoDiagnosis2.dateTime)
          ? lesion1
          : lesion2;
    });

    if (lesion.autoDiagnoses.isEmpty) return null;
    final latestAutoDiagnosis = lesion.autoDiagnoses
        .reduce((ad1, ad2) => ad1.dateTime.isAfter(ad2.dateTime) ? ad1 : ad2);

    return (lesion: lesion, autoDiagnosis: latestAutoDiagnosis);
  }

  void editUserInfo(BuildContext context, PatientDTO patientData, int index) {
    context.pushNamed(
      'RecordsEdit',
      extra: {
        'patientData': patientData,
        'index': index,
      },
    );
  }

  void deleteUser(BuildContext context, WidgetRef ref, PatientDTO patient) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text("Funcionalidad de eliminación en construcción..."),
    //   ),
    // );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Paciente"),
        content: const Text(
            "¿Estás seguro de que deseas eliminar este paciente? Esta acción no se puede deshacer."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              // Eliminar el paciente
              await ref
                  .read(recordsServiceProvider)
                  .deletePatient(patient.patientId);

              // Cerrar el diálogo
              if (context.mounted) {
                Navigator.pop(context);
              }

              // Navegar a la ruta 'Reports' si está definida
              if (context.mounted) {
                context.goNamed(
                    'Reports'); // Asegúrate de que '/reports' esté definido en GoRouter
              }
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }

  void showLesionDetails(BuildContext context, LesionDTO lesion) {
    // Línea base: el diagnóstico clínico
    final diagnosisLines = <String>[
      "Diagnóstico Clínico: ${lesion.clinicalDiagnosis}"
    ];

    // Si hay diagnósticos automáticos, se recorren y se formatean
    if (lesion.autoDiagnoses.isNotEmpty) {
      diagnosisLines.add("Auto Diagnósticos:");
      for (var ad in lesion.autoDiagnoses) {
        // Formatear los diagnósticos y probabilidades usando la nueva lógica
        final formattedAutoDiagnosis = formatAutoDiagnosis(ad);
        diagnosisLines.addAll(formattedAutoDiagnosis);
      }
    } else {
      diagnosisLines.add("Auto Diagnóstico: No disponible");
    }

    // Se unen todas las líneas con saltos de línea dobles para separar secciones
    final String diagnosisDetails = diagnosisLines.join("\n");

    // Mostrar el diálogo con los detalles
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalles de la lesión"),
        content: Text(diagnosisDetails, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

// Función auxiliar para formatear los diagnósticos automáticos
  List<String> formatAutoDiagnosis(AutoDiagnosisDTO ad) {
    // Verificar que las listas tengan la misma longitud
    if (ad.diagnosis.length != ad.probability.length) {
      return [
        "Error: Las listas de diagnósticos y probabilidades no coinciden."
      ];
    }

    // Crear una lista de líneas formateadas
    List<String> formattedLines = [];
    for (int i = 0; i < ad.diagnosis.length; i++) {
      String diagnosis = ad.diagnosis[i];
      double probability = ad.probability[i];

      // Formatear la probabilidad como porcentaje redondeado a 1 decimal
      String probText = "${probability.toStringAsFixed(1)}%";

      // Agregar la línea formateada a la lista
      formattedLines.add("• $diagnosis : $probText");
    }

    return formattedLines;
  }
}
