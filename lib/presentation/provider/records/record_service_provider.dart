





import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories/pacient_repository_impl.dart';
import '../../../services/records_service.dart';

final recordsServiceProvider = Provider<RecordsService>((ref) {
  return RecordsService(patientRepository:MedicalReportRepositoryImpl());
});
