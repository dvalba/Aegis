import 'package:flutter/material.dart';

import '../../../presentation/screens/auth/login_screen.dart';
import '../../../presentation/screens/auth/signup_screen.dart';
import '../../../presentation/screens/auth/welcome_screen.dart';
import '../../../presentation/screens/home/home_screen.dart';
import '../../../presentation/screens/pictures/camera_screen.dart';
import '../../../presentation/screens/records/lesion_screen.dart';
import '../../../presentation/screens/reports/reports_screen.dart';
import '../../../presentation/screens/settings/settings_screen.dart';
import '../../infrastructure/dtos/lesion_dto.dart';
import '../../infrastructure/dtos/patient_dto.dart';
import '../../presentation/screens/auth/fullscreen_loader.dart';
import '../../presentation/screens/records/all_lesion_screen.dart';
import '../../presentation/screens/records/record_screen.dart';
import '../../presentation/screens/reports/report_details_screen.dart';

enum RecordsMode {
  edit, // Modo para editar un registro existente
  add, // Modo para agregar un nuevo registro
}

enum LesionMode {
  // Estos modos Son usados cuando el RecordsMode es edit
  edit,
  editAdd,

  // Estos modos Son usados cuando el RecordsMode es add
  add,
  addEdit,
}

// Mapa de componentes con rutas
final Map<String, Map<String, dynamic>> componentsMap = {
  "Reports": {
    "widget": (context, state) => const ReportsScreen(
          selectedIndex: 0,
        ),
    "icon": const Icon(Icons.search),
    "title": "Reports",
    "route": "/reports", // Ruta correspondiente
  },
  "Camera": {
    "widget": (context, state) => const CameraScreen(
          selectedIndex: 1,
        ),
    "icon": const Icon(Icons.camera),
    "title": "Camera",
    "route": "/camera", // Ruta correspondiente
  },
  "Home": {
    "widget": (context, state) => const HomeScreen(
          selectedIndex: 2,
        ),
    "icon": const Icon(Icons.home),
    "title": "Home",
    "route": "/home", // Ruta correspondiente
  },
  "Records": {
    "widget": (context, state) {
      return RecordScreen(
        selectedIndex: 3,
        mode: RecordsMode.add, // Modo de agregar
      );
    },
    "icon": const Icon(Icons.local_hospital_rounded),
    "title": "Records",
    "route": "/records/add", // Ruta correspondiente a la adición
  },
  "Settings": {
    "widget": (context, state) => const SettingsScreen(
          selectedIndex: 4,
        ),
    "icon": const Icon(Icons.settings),
    "title": "Settings",
    "route": "/settings", // Ruta correspondiente
  },
};

final Map<String, Map<String, dynamic>> authMap = {
  "Welcome": {
    "widget": (context, state) => const WelcomeScreen(),
    "route": "/", // Ruta correspondiente
  },
  "Login": {
    "widget": (context, state) => const LoginScreen(),
    "route": "/login", // Ruta correspondiente
  },
  "SignUp": {
    "widget": (context, state) =>  SignUpScreen(),
    "route": "/signup", // Ruta correspondiente
  },
  "Loader": {
    "widget": (context, state) => const FullScreenLoader(),
    "route": "/loader", // Ruta correspondiente
  },
  "AllLesions": {
    "widget": (context, state) => const AllLesionsScreen(),
    "route": "/all-lesions", // Ruta correspondiente
  },
  "ReportDetails": {
    "widget": (context, state) {
      final args = state.extra as Map<String, dynamic>;
      final index = args['index'] as int;

      return ReportDetailScreen(
        indexPatient: index,
      );
    },
    "route": "/report/details",
  },

  //Record Edit Route
  "RecordsEdit": {
    "widget": (context, state) {
      final args = state.extra as Map<String, dynamic>;
      final patientData = args['patientData'] as PatientDTO;
      final index = args['index'] as int;

      return RecordScreen(
        index: index,
        patientData: patientData,
        mode: RecordsMode.edit, // Pasamos el modo a RecordScreen
      );
    },
    "route": "/records-edit", // Ruta correspondiente a la edición
  },
  //Lesion Routes
  "LesionEdit": {
    "widget": (context, state) {
      final args = state.extra as Map<String, dynamic>;
      final lesionData = args['lesionData'] as LesionDTO;
      final index = args['index'] as int;

      return LesionScreen(
        lesionData: lesionData,
        index: index,
        mode: LesionMode.edit, // Editar desde Register y Editar en Lesion
      );
    },
    "route": "/lesion-edit",
  },
  "LesionAdd": {
    "widget": (context, state) {
      return LesionScreen(
        mode: LesionMode.add, // Agregar desde Register y Agregar en Lesion
      );
    },
    "route": "/lesion-add",
  },

  "LesionEditAdd": {
    "widget": (context, state) {
      return LesionScreen(
        mode: LesionMode.editAdd, // Editar desde Register y Agregar en Lesion
      );
    },
    "route": "/lesion-edit-add",
  },
};
