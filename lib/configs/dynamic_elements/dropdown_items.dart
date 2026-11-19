// dropdown_items.dart
final List<String> sexOptions = ['Masculino', 'Femenino'];

const List<String> phototypeItems = [
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
];

const List<String> diagnosisItems = [
  'Melanoma',
  'Carcinoma Basocelular',
  'Carcinoma Escamoso',
  'Otro',
];

final Map<String, String> tagToDiagnostico = {
  'Basal': 'Carcinoma Basocelular',
  'Melanoma': 'Melanoma',
  'Otro': 'Otro',
  'Escamoso': 'Carcinoma Escamoso',
};

// Función para obtener el diagnóstico dado un tag
String getDiagnosticoFromTag(String tag) {
  return tagToDiagnostico[tag] ??
      'Desconocido'; // Retorna 'Desconocido' si el tag no existe
}

String getbodyPartFromTag(String tag) {
  return bodyPartTags[tag] ??
      'Desconocido'; // Retorna 'Desconocido' si el tag no existe
}

final Map<String, String> bodyPartTags = {
  // Cara (Face)
  'lowRisk': 'Riesgo Bajo',
  'mediumRisk': 'Riesgo Medio',
  'highRisk': 'Riesgo Alto',

  // Partes del cuerpo frontal
  'rightShoulder': 'Hombro Derecho',
  'leftShoulder': 'Hombro Izquierdo',
  'rightArm': 'Brazo Derecho',
  'leftArm': 'Brazo Izquierdo',
  'rightForearm': 'Antebrazo Derecho',
  'leftForearm': 'Antebrazo Izquierdo',
  'rightHand': 'Mano Derecha',
  'leftHand': 'Mano Izquierda',
  'rightThigh': 'Muslo Derecho',
  'leftThigh': 'Muslo Izquierdo',
  'rightKnee': 'Rodilla Derecha',
  'leftKnee': 'Rodilla Izquierda',
  'rightLowerLeg': 'Pierna Derecha',
  'leftLowerLeg': 'Pierna Izquierda',
  'rightFoot': 'Pie Derecho',
  'leftFoot': 'Pie Izquierdo',
  'face': 'Cara',
  'neck': 'Cuello',
  'chest': 'Pecho',
  'abdomen': 'Abdomen',
  'pelvic': 'Pelvis',

  // Partes del cuerpo trasero
  'Back_Head': 'Parte Posterior de la Cabeza',
  'Upper_Back': 'Espalda Superior',
  'Middle_Back': 'Espalda Media',
  'Lower_Back': 'Espalda Inferior',
  'Left_Shoulder': 'Hombro Izquierdo',
  'Right_Shoulder': 'Hombro Derecho',
  'Left_Arm': 'Brazo Izquierdo',
  'Right_Arm': 'Brazo Derecho',
  'Left_Elbow': 'Codo Izquierdo',
  'Right_Elbow': 'Codo Derecho',
  'Left_Forearm': 'Antebrazo Izquierdo',
  'Right_Forearm': 'Antebrazo Derecho',
  'Left_Hand': 'Mano Izquierda',
  'Right_Hand': 'Mano Derecha',
  'Glute': 'Glúteo',
  'Left_Thigh': 'Muslo Izquierdo',
  'Right_Thigh': 'Muslo Derecho',
  'Left_Popliteal': 'Hueco Poplíteo Izquierdo',
  'Right_Popliteal': 'Hueco Poplíteo Derecho',
  'Left_Lower_Leg': 'Pierna Izquierda',
  'Right_Lower_Leg': 'Pierna Derecha',
  'Left_Foot': 'Pie Izquierdo',
  'Right_Foot': 'Pie Derecho',
};

final Map<String, String> faceTags = {
  'low_risk': 'Riesgo Bajo',
  'medium_risk': 'Riesgo Medio',
  'high_risk': 'Riesgo Alto',
};

final Map<String, String> frontBodyTags = {
  'right_shoulder': 'Hombro Derecho',
  'left_shoulder': 'Hombro Izquierdo',
  'right_arm': 'Brazo Derecho',
  'left_arm': 'Brazo Izquierdo',
  'right_forearm': 'Antebrazo Derecho',
  'left_forearm': 'Antebrazo Izquierdo',
  'right_hand': 'Mano Derecha',
  'left_hand': 'Mano Izquierda',
  'right_thigh': 'Muslo Derecho',
  'left_thigh': 'Muslo Izquierdo',
  'right_knee': 'Rodilla Derecha',
  'left_knee': 'Rodilla Izquierda',
  'right_lower_leg': 'Pierna Derecha',
  'left_lower_leg': 'Pierna Izquierda',
  'right_foot': 'Pie Derecho',
  'left_foot': 'Pie Izquierdo',
  'face': 'Cara',
  'neck': 'Cuello',
  'chest': 'Pecho',
  'abdomen': 'Abdomen',
  'pelvic': 'Pelvis',
};

final Map<String, String> backBodyTags = {
  'back_head': 'Parte Posterior de la Cabeza',
  'upper_back': 'Espalda Superior',
  'middle_back': 'Espalda Media',
  'lower_back': 'Espalda Inferior',
  'left_shoulder': 'Hombro Izquierdo',
  'right_shoulder': 'Hombro Derecho',
  'left_arm': 'Brazo Izquierdo',
  'right_arm': 'Brazo Derecho',
  'left_elbow': 'Codo Izquierdo',
  'right_elbow': 'Codo Derecho',
  'left_forearm': 'Antebrazo Izquierdo',
  'right_forearm': 'Antebrazo Derecho',
  'left_hand': 'Mano Izquierda',
  'right_hand': 'Mano Derecha',
  'glute': 'Glúteo',
  'left_thigh': 'Muslo Izquierdo',
  'right_thigh': 'Muslo Derecho',
  'left_popliteal': 'Hueco Poplíteo Izquierdo',
  'right_popliteal': 'Hueco Poplíteo Derecho',
  'left_lower_leg': 'Pierna Izquierda',
  'right_lower_leg': 'Pierna Derecha',
  'left_foot': 'Pie Izquierdo',
  'right_foot': 'Pie Derecho',
};

enum ImageType {
  dermatoscopic,
  clinical,
  none, // Nuevo tipo añadido
}
