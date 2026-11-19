class User {
  final int id;               // ID único del usuario
  String email;                  // Correo electrónico
  String firstName;              // Primer nombre
  String lastName;               // Apellido
  final String regProfessional;  // Registro profesional
  String province;               // Provincia
  String municipality;           // Municipio
  String workPlace;              // Centro de trabajo
  String token;                  // Token de autenticación (si se necesita)
  bool canVerify;                // Indicador si el usuario puede verificar
  bool verified;                 // Indicador si el usuario está verificado
  bool isDoctor;                 // Indicador si el usuario es doctor
  int totalPacients;             // Total de pacientes
  int totalVisibilitiesGiven;    // Total de visibilidades otorgadas
  int totalVisibilitiesObteined; // Total de visibilidades obtenidas

  // Constructor
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.regProfessional,
    this.province = '',
    this.municipality = '',
    this.workPlace = '',
    this.token = '',
    required this.canVerify,
    required this.verified,
    required this.isDoctor,
    required this.totalPacients,
    required this.totalVisibilitiesGiven,
    required this.totalVisibilitiesObteined,
  });

  // Método para crear un usuario desde un mapa (para recibir datos desde un JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      regProfessional: json['reg_professional'] ?? '',
      province: json['province'] ?? '',
      municipality: json['municipality'] ?? '',
      workPlace: json['work_place'] ?? '',
      token: json['token'] ?? '',
      canVerify: json['can_verify'] ?? false,
      verified: json['verified'] ?? false,
      isDoctor: json['is_doctor'] ?? false,
      totalPacients: json['total_pacients'] ?? 0,
      totalVisibilitiesGiven: json['total_visibilities_given'] ?? 0,
      totalVisibilitiesObteined: json['total_visibilities_obteined'] ?? 0,
    );
  }

  // Método para convertir un objeto User a un mapa (para enviar datos a una API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'reg_professional': regProfessional,
      'province': province,
      'municipality': municipality,
      'work_place': workPlace,
      'token': token,
      'can_verify': canVerify,
      'verified': verified,
      'is_doctor': isDoctor,
      'total_pacients': totalPacients,
      'total_visibilities_given': totalVisibilitiesGiven,
      'total_visibilities_obteined': totalVisibilitiesObteined,
    };
  }

  // Getter para obtener el fullName
  String get fullName {
    return '$firstName $lastName';  // Concatenamos el primer nombre y apellido
  }

  // Setter para dividir el fullName y asignarlo a firstName y lastName
  set fullName(String name) {
    var names = name.split(' ');  // Se divide por espacio
    firstName = names[0];         // Asignamos el primer nombre
    lastName = names.length > 1 ? names.sublist(1).join(' ') : ''; // Asignamos el apellido
  }
}
