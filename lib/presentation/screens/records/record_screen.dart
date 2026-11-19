// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aegis/configs/dynamic_elements/component_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:aegis/presentation/widgets/shared/app_bar/custom_app_bar.dart';
import 'package:aegis/presentation/widgets/shared/bottom_bar/custom_bottom_navigation_bar.dart';
import 'package:aegis/presentation/widgets/shared/buttom/submit_button.dart';
import 'package:aegis/presentation/widgets/shared/buttom/navigation_button.dart';
import 'package:aegis/presentation/widgets/shared/forms/custom_dropdown.dart';
import 'package:aegis/presentation/widgets/shared/forms/custom_text_form_field.dart';
import 'package:aegis/presentation/widgets/records/profile_images_picker.dart';

import '../../../infrastructure/dtos/patient_dto.dart';
import '../../provider/records/patient_form_provider.dart';
import '../../provider/reports/reports_provider.dart';

class RecordScreen extends StatelessWidget {
  final RecordsMode mode;

  // Índice del paciente en la lista (ubicada en el provider de reportes).
  // Este valor es requerido únicamente en el modo de edición.
  final int? index;
  final PatientDTO? patientData;

  // Índice que ocupa el widget en la CustomAppBar.
  // Disponible únicamente en el modo de adición.
  final int? selectedIndex;

  const RecordScreen({
    super.key,
    required this.mode,
    this.index,
    this.patientData,
    this.selectedIndex,
  }) : assert(
          mode == RecordsMode.add
              ? patientData == null && index == null && selectedIndex != null
              : patientData != null && index != null && selectedIndex == null,
          'En modo add, patientData e index deben ser null y selectedIndex debe tener un valor. '
          'En modo edit, patientData e index deben tener un valor y selectedIndex debe ser null.',
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          mode == RecordsMode.add
              ? '¡Añade un nuevo paciente!'
              : 'Edita el paciente',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: _RecordFormView(
        patientData: patientData,
        index: index,
        mode: mode,
      ),
      bottomNavigationBar: mode == RecordsMode.add && selectedIndex != null
          ? CustomBottomNavigationBar(selectedIndex: selectedIndex!)
          : null,
    );
  }
}

class _RecordFormView extends StatelessWidget {
  final PatientDTO? patientData;
  final int? index;

  final RecordsMode mode;

  const _RecordFormView({
    required this.mode,
    this.patientData,
    this.index,
  }) : assert(
          mode == RecordsMode.add
              ? (patientData == null && index == null)
              : (patientData != null && index != null),
          'En modo add, patientData e index deben ser null; en modo edit, deben tener valores.',
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // En modo edición se pasan los datos existentes del paciente y su índice.
              // En modo adición se mostrará un formulario vacío.
              PatientForm(
                patientData: mode == RecordsMode.edit ? patientData! : null,
                index: mode == RecordsMode.edit ? index! : null,
                mode: mode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientForm extends ConsumerStatefulWidget {
  final PatientDTO? patientData;
  final int? index;
  final RecordsMode? mode;

  const PatientForm({super.key, this.patientData, this.index, this.mode});

  @override
  ConsumerState<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends ConsumerState<PatientForm> {
  @override
  void initState() {
    super.initState();
    if (widget.mode == RecordsMode.edit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(patientFormProvider.notifier).editPatient(widget.patientData!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final patientForm = ref.watch(patientFormProvider);

    return Form(
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          ProfileImagePicker(
            onTap: () {},
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField.patientId(
            initialValue:
                widget.patientData?.patientId ?? patientForm.patientId.value,
            onChanged: ref.read(patientFormProvider.notifier).updatePatientId,
            errorText:
                patientForm.formPosted ? patientForm.patientId.errorText : null,
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField.name(
            initialValue: widget.patientData?.name ?? patientForm.name.value,
            onChanged: ref.read(patientFormProvider.notifier).updateName,
            errorText:
                patientForm.formPosted ? patientForm.name.errorText : null,
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField.lastName(
            initialValue:
                widget.patientData?.lastName ?? patientForm.lastName.value,
            onChanged: ref.read(patientFormProvider.notifier).updateLastName,
            errorText:
                patientForm.formPosted ? patientForm.lastName.errorText : null,
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField.age(
            initialValue: widget.patientData?.age.toString() ??
                patientForm.age.value.toString(),
            onChanged: ref.read(patientFormProvider.notifier).updateAge,
            errorText:
                patientForm.formPosted ? patientForm.age.errorText : null,
          ),
          const SizedBox(height: 12.0),
          CustomDropdown.sex(
            value: widget.patientData?.sex ?? patientForm.sex,
            onChanged: ref.read(patientFormProvider.notifier).updateSex,
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField.personalHealthRecord(
            initialValue: widget.patientData?.healthRecord ??
                patientForm.personalHealthRecord,
            hintText: "Historial médico personal",
            onChanged:
                ref.read(patientFormProvider.notifier).updateHealthRecord,
          ),
          const SizedBox(height: 12.0),
          _LesionSection(colors: colors, mode: widget.mode),
          const SizedBox(height: 12.0),
          SubmitButton(
            label: widget.mode == RecordsMode.add ? "Guardar" : "Actualizar",
            backgroundColor: colors.primary,
            textColor: Colors.white,
            onPressed: () async {
              final result = widget.mode == RecordsMode.add
                  ? await ref.read(reportProvider.notifier).submitReport()
                  : await ref
                      .read(reportProvider.notifier)
                      .updateReportAt(widget.index!);

              if (!result.isValid) {
                if (context.mounted) {
                  showSnackbar(context, result.errorMessage!);
                }
              } else {
                if (widget.mode == RecordsMode.add) {
                  if (context.mounted) {
                    context.pushNamed('Home');
                  }
                } else {
                  if (context.mounted) {
                    context.pop();
                    context.pop();
                    context.pushNamed('ReportDetails',
                        extra: {'index': widget.index});
                  }
                  // En modo edición se pasa el índice del reporte como argumento extra
                }
              }
            },
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}

class _LesionSection extends StatelessWidget {
  final ColorScheme colors;
  final RecordsMode? mode;
  const _LesionSection({required this.colors, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: colors.primary, size: 32.0),
            onPressed: () {
              context.pushNamed('AllLesions');
            },
          ),
          const SizedBox(width: 8.0),
          Text(
            "Lesiones:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(width: 24.0),
          NavigationButton(
            routeName: mode == RecordsMode.add ? 'LesionAdd' : 'LesionEditAdd',
            label: 'Añadir',
            backgroundColor: colors.primary,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

void showSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: const Duration(seconds: 5),
    ),
  );
}
