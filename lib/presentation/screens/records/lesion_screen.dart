// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:aegis/configs/dynamic_elements/component_map.dart';
import 'package:aegis/presentation/provider/records/lesions_provider.dart';
import 'package:aegis/presentation/widgets/shared/app_bar/custom_app_bar.dart';
import 'package:aegis/presentation/widgets/shared/buttom/submit_button.dart';
import 'package:aegis/presentation/widgets/shared/forms/custom_dropdown.dart';

import '../../../configs/dynamic_elements/dropdown_items.dart';
import '../../../infrastructure/dtos/lesion_dto.dart';
import '../../provider/records/lesion_form_provider.dart';
import '../../provider/records/selected_region_provider.dart';
import '../../widgets/reports/interactive_body.dart';
import '../../widgets/shared/custom_expandable_menu.dart';
import '../../widgets/shared/forms/custom_text_form_field.dart';

class LesionScreen extends StatelessWidget {
  final LesionDTO? lesionData; // Datos de la lesión para edición
  final int? index; // Índice de la lesión en la lista
  final LesionMode? mode;

  const LesionScreen({
    super.key,
    this.lesionData,
    this.index,
    this.mode,
  }) : assert(
            mode == LesionMode.add || mode == LesionMode.editAdd
                ? (lesionData == null && index == null)
                : (lesionData != null && index != null),
            'En los modos "add" o "editAdd", tanto "lesionData" como "index" deben ser null. '
            'En los modos "edit" o "addEdit", tanto "lesionData" como "index"  debe tener un valor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          mode == LesionMode.add || mode == LesionMode.editAdd
              ? '¡Añade una lesión!'
              : 'Edita la lesión',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: LesionFormView(
        lesionData: lesionData,
        index: index,
        mode: mode,
      ),
    );
  }
}

class LesionFormView extends StatelessWidget {
  final LesionDTO? lesionData; // Datos de la lesión para edición
  final int? index; // Índice de la lesión en la lista
  final LesionMode? mode;

  const LesionFormView({
    super.key,
    this.lesionData,
    this.index,
    this.mode,
  }) : assert(
          mode == LesionMode.add || mode == LesionMode.editAdd
              ? (lesionData == null && index == null)
              : (lesionData != null && index != null),
          'En los modos "add" o "editAdd", tanto "lesionData" como "index" deben ser null. '
          'En los modos "edit" o "addEdit", tanto "lesionData" como "index" debe tener un valor',
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LesionForm(
                lesionData: lesionData,
                index: index,
                mode: mode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LesionForm extends ConsumerStatefulWidget {
  final LesionDTO? lesionData; // Acepta datos para editar
  final int? index; // Índice de la lesión en la lista
  final LesionMode? mode;

  const LesionForm({
    super.key,
    this.lesionData,
    this.index,
    this.mode,
  });

  @override
  ConsumerState<LesionForm> createState() => _LesionFormState();
}

class _LesionFormState extends ConsumerState<LesionForm> {
  bool _showMenu = false;
  ImageType _selectedType = ImageType.none; // Tipo de imagen seleccionada

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos después del build
    if (widget.mode == LesionMode.edit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(lesionFormProvider.notifier).editLesion(widget.lesionData!);
      });
    }
  }

  void _toggleMenu(ImageType type) {
    setState(() {
      _showMenu = !_showMenu;
      _selectedType = type; // Actualiza el estado correctamente
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final lesionDataProvider = ref.watch(lesionFormProvider);
    final lesionDataNotifier = ref.watch(lesionFormProvider.notifier);

    return Form(
      child: Column(
        children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                SizedBox(height: 5), // Espaciado superior

                // Mostrar el cuerpo seleccionado (frontal o trasero)
                InteractiveBody(
                  isFace: lesionDataProvider.isFace,
                  isFront: lesionDataProvider.isFront,
                ),

                // selectedBody == 0
                //     ? InteractiveParts.frontBody()
                //     : InteractiveParts.backBody(),
                SizedBox(height: 20), // Espaciado entre el cuerpo y los botones

                // Botón para seleccionar la vista frontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        lesionDataNotifier.updateLocation(
                            isFront: true, isFace: false);
                      },
                      child: Text("Vista Frontal"),
                    ),

                    SizedBox(width: 15),
                    // Botón para seleccionar la vista trasera
                    ElevatedButton(
                      onPressed: () {
                        lesionDataNotifier.updateLocation(
                            isFront: false, isFace: false);
                      },
                      child: Text("Vista Trasera"),
                    ),
                  ],
                ), // Espaciado entre los botones
              ])),
          SizedBox(height: 20), // Espaciado adicional

          CustomDropdown.location(
              isFace: lesionDataProvider.isFace,
              isFront: lesionDataProvider.isFront,
              value: lesionDataProvider.location,
              onChanged: (String? value) {
                ref.read(selectedRegionProvider.notifier).toggleRegion(value);
                ref
                    .read(lesionFormProvider.notifier)
                    .updateLocation(location: value);
              }),

          const SizedBox(height: 12.0),
          CustomDropdown.diagnosis(
            label: 'Clínico',
            value: lesionDataProvider.clinicalDiagnosis,
            onChanged:
                ref.read(lesionFormProvider.notifier).updateClinicalDiagnosis,
          ),
          const SizedBox(height: 12.0),
          CustomDropdown.diagnosis(
            label: 'Histopatológico',
            value: lesionDataProvider.histopathDiagnosis,
            onChanged:
                ref.read(lesionFormProvider.notifier).updateHistopathDiagnosis,
          ),
          const SizedBox(height: 12.0),

          const SizedBox(height: 12.0),
          CustomDropdown.phototype(
            value: lesionDataProvider.phototype,
            onChanged: ref.read(lesionFormProvider.notifier).updatePhototype,
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate,
                  color: colors.primary, size: 32.0),
              const SizedBox(width: 8.0),
              Text(
                "Añade las imágenes de lesión",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SubmitButton(
                label: "Dermatoscópica",
                backgroundColor: colors.primary,
                textColor: Colors.white,
                onPressed: () => _toggleMenu(ImageType.dermatoscopic),
              ),
              const SizedBox(width: 8),
              SubmitButton(
                label: "Clínica",
                backgroundColor: colors.primary,
                textColor: Colors.white,
                onPressed: () => _toggleMenu(ImageType.clinical),
              ),
            ],
          ),
          CustomExpandableMenu(showMenu: _showMenu, type: _selectedType),
          const SizedBox(height: 12.0),
          CustomTextFormField.personalHealthRecord(
            labelText: 'Notas',
            hintText: "Notas relevantes",
          ),
          const SizedBox(height: 12.0),
          SubmitButton(
            label: widget.mode == LesionMode.add ||
                    widget.mode == LesionMode.editAdd
                ? "Guardar Lesión"
                : "Actualizar Lesión",
            backgroundColor: colors.primary,
            textColor: Colors.white,
            onPressed: () async {
              // Determinar si estamos en modo de adición o edición
              final result = widget.lesionData == null
                  ? await ref.read(lesionProvider.notifier).submitLesion()
                  : await ref
                      .read(lesionProvider.notifier)
                      .updateLesionAt(widget.index!);

              if (!result.isValid) {
                if (context.mounted) {
                  showSnackbar(context, result.errorMessage!);
                }
              } else {
                if (widget.mode == LesionMode.add) {
                  if (context.mounted) {
                    context.pushNamed('Records');
                  }
                } else {
                  if (context.mounted) {
                    context.pop();
                  }
                }

                // Navegar a la ruta correspondiente
              }
            },
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
