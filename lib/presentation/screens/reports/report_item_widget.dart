// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../infrastructure/dtos/report_dto.dart';
import '../../provider/reports/reports_provider.dart';

class ReportItem extends ConsumerWidget {
  final int index;

  const ReportItem({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportProvider.notifier);
    //TODO Es ideal que se vean ordenados por la fecha en que se andio el paciente (Los ultimos primero)
    final ReportDetailsDTO? reportDetails = reports.getReportDetails(index);
   
    if(reportDetails == null){
      return Container();
    }
    final String formattedDate =
        "${reportDetails.date.hour}:${reportDetails.date.minute} ${reportDetails.date.day}-${reportDetails.date.month}-${reportDetails.date.year}";

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          "ReportDetails",
          extra: {"index": index}, // Pasamos el reporte como extra
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          title: Text(reportDetails.name + reportDetails.lastName),
          subtitle: Text(
            "ID: ${reportDetails.patientId}\nDetected: ${reportDetails.autoDiagnosis?[0]} \n Probability: ${reportDetails.probability?[0]}%",
          ),
          trailing: Text(formattedDate),
        ),
      ),
    );
  }
}
