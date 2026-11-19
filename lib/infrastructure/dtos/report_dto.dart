class ReportDetailsDTO {
  final String name;
  final String lastName;
  final String patientId;
  final List<String>? autoDiagnosis;
  final List<double>? probability;
  final String location;
  final String imageUrl;
  final DateTime date;

  ReportDetailsDTO({
    required this.name,
    required this.lastName,
    required this.patientId,
    required this.autoDiagnosis,
    required this.probability,
    required this.location,
    required this.imageUrl,
    required this.date,
  });

}