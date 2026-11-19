// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../infrastructure/dtos/patient_dto.dart';
import '../../inputs/age_input.dart';
import '../../inputs/id_input.dart';
import '../../inputs/last_name.dart';
import '../../inputs/name_input.dart';
import 'lesions_provider.dart';



class PatientFormState {
  final bool isPosting;
  final bool formPosted;
  final bool isValid;
  final String? errorMessage;

  final int? isarId;
  final IdInput patientId;
  final NameInput name;
  final LastNameInput lastName;
  final String? sex;
  final Age age;
  final String? personalHealthRecord;

  PatientFormState({
    this.isPosting = false,
    this.formPosted = false,
    this.isValid = false,
    this.isarId,
    this.patientId = const IdInput.pure(),
    this.name = const NameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.sex,
    this.age = const Age.pure(),
    this.personalHealthRecord,
    this.errorMessage,
  });

  PatientFormState copyWith({
    bool? isPosting,
    bool? formPosted,
    int? isarId,
    bool? isValid,
    bool? isErrorTriggered,
    String? errorMessage,
    IdInput? patientId,
    NameInput? name,
    LastNameInput? lastName,
    String? sex,
    Age? age,
    String? personalHealthRecord,
  }) {
    return PatientFormState(
      isarId: isarId ?? this.isarId,
      isPosting: isPosting ?? this.isPosting,
      formPosted: formPosted ?? this.formPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      personalHealthRecord: personalHealthRecord ?? this.personalHealthRecord,
    );
  }

  @override
  String toString() {
    return 'PatientFormState('
        'formPosted: $formPosted, '
        'isValid: $isValid, '
        'errorMessage: $errorMessage, '
        'patientId: $patientId, '
        'name: $name, '
        ')';
  }
}

class PatientFormNotifier extends StateNotifier<PatientFormState> {
  final LesionNotifier lesionNotifier;

  final Ref ref; // Se almacena ref para escuchas reactivas

  PatientFormNotifier(
    this.lesionNotifier,
    this.ref,
  ) : super(PatientFormState()) {
    // Se escucha el estado del lesionProvider
    ref.listen<LesionState>(lesionProvider, (previous, next) {
      if (previous == null || previous.hasLesion() != next.hasLesion()) {
        validateAndUpdatePatientForm(state);
      }
    });
  }

  void updatePatientId(String value) {
    final newPatientId = IdInput.dirty(value);
    _updateState(patientId: newPatientId);
  }

  void updateName(String value) {
    final newName = NameInput.dirty(value);
    _updateState(name: newName);
  }

  void updateLastName(String value) {
    final newLastName = LastNameInput.dirty(value);
    _updateState(lastName: newLastName);
  }

  void updateSex(String? value) {
    _updateState(sex: value);
  }

  void updateHealthRecord(String? value) {
    _updateState(personalHealthRecord: value);
  }

  void updateAge(String value) {
    final newAge = Age.dirty(value);
    _updateState(age: newAge);
  }

  void _updateState({
    IdInput? patientId,
    NameInput? name,
    LastNameInput? lastName,
    String? sex,
    Age? age,
    String? personalHealthRecord,
  }) {
    final newState = state.copyWith(
      patientId: patientId ?? state.patientId,
      name: name ?? state.name,
      lastName: lastName ?? state.lastName,
      sex: sex ?? state.sex,
      age: age ?? state.age,
      personalHealthRecord: personalHealthRecord ?? state.personalHealthRecord,
    );

    validateAndUpdatePatientForm(newState);
  }

  void validateAndUpdatePatientForm(PatientFormState patientFormState) {
    final validation = validatePatientForm(patientFormState);
    state = patientFormState.copyWith(
        isValid: validation.isValid, errorMessage: validation.errorMessage);
  }

  ({bool isValid, String? errorMessage}) validatePatientForm(
      PatientFormState formState) {
    if (!_validateFormzInput(formState)) {
      return (
        isValid: false,
        errorMessage: 'Verifique los campos del paciente'
      );
    }

    final hasLesion = lesionNotifier.state.hasLesion();

    if (!hasLesion) {
      return (isValid: false, errorMessage: 'Debe añadir al menos una lesión');
    }

    return (isValid: true, errorMessage: null);
  }

  bool _validateFormzInput(PatientFormState formState) {
    return Formz.validate([
      formState.patientId,
      formState.name,
      formState.lastName,
      formState.age,
    ]);
  }

  Future<({bool isValid, String? errorMessage})> submitPatientForm() async {
    if (!state.isValid) {
      if (!state.formPosted) validateAndUpdatePatientForm(state);
      state = state.copyWith(isPosting: false, formPosted: true);
      return (
        isValid: false,
        errorMessage: state.errorMessage,
      );
    }

    try {
      state = state.copyWith(isPosting: true);
      //TODO: Posteed Pacient
      // ignore: unused_local_variable
      final patientData = PatientDTO(
        patientId: state.patientId.value,
        name: state.name.value,
        lastName: state.lastName.value,
        age: int.parse(state.age.value),
        sex: state.sex ?? 'Desconocido',
        healthRecord: state.personalHealthRecord,
        lesions: lesionNotifier.state.lesions,
      );

      return (
        isValid: false,
        errorMessage: "Anadido correctamente",
      );
    } catch (e) {
      return (
        isValid: false,
        errorMessage: 'Error inesperado al crear el paciente.',
      );
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

// ---------------------------------------------------------------------------
  // Edit Patient prepare the form with the patient data
  void editPatient(PatientDTO patientData) {
    state = PatientFormState().copyWith(
      isarId: patientData.isarId,
      isValid: true,
      patientId: IdInput.dirty(patientData.patientId),
      name: NameInput.dirty(patientData.name),
      lastName: LastNameInput.dirty(patientData.lastName),
      age: Age.dirty(patientData.age.toString()),
      sex: patientData.sex,
      personalHealthRecord: patientData.healthRecord,
    );

    lesionNotifier.loadLesions(patientData.lesions);
  }

  Future<PatientDTO?> createPatient() async {
    // Comprueba si el formulario es válido.
    if (!state.isValid) {
      // Si el formulario no ha sido enviado aún, valida el formulario para actualizar el estado.
      if (!state.formPosted) {
        validateAndUpdatePatientForm(state);
      }
      // Actualiza el estado para indicar que hay un error y que el formulario ya fue enviado.
      state = state.copyWith(isPosting: false, formPosted: true);
      return null;
    }

    // Marca que se está enviando el paciente.
    state = state.copyWith(isPosting: true);

    // Crea los datos del paciente utilizando los valores del formulario.
    final patientData = PatientDTO(
      isarId: state.isarId,
      patientId: state.patientId.value,
      name: state.name.value,
      lastName: state.lastName.value,
      age: int.parse(state.age.value),
      sex: state.sex ?? 'Desconocido',
      healthRecord: state.personalHealthRecord,
      lesions: lesionNotifier.state.lesions,
    );

    // Actualiza el estado para indicar que se ha terminado el envío.
    state = state.copyWith(isPosting: false);

    // Retorna los datos del paciente creado.
    return patientData;
  }

  void clearForm() {
    state = PatientFormState(); // Restablece el estado del formulario
    lesionNotifier.clearForm(); // Llama al clear de las lesiones
  }
}

// Define patientFormProvider as a StateNotifierProvider
final patientFormProvider =
    StateNotifierProvider<PatientFormNotifier, PatientFormState>(
  (ref) => PatientFormNotifier(ref.watch(lesionProvider.notifier), ref),
);
