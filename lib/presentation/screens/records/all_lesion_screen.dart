import 'package:aegis/presentation/widgets/shared/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Asegúrate de tener importado GoRouter

import '../../provider/records/lesions_provider.dart';

class AllLesionsScreen extends ConsumerWidget {
  const AllLesionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesionData =
        ref.watch(lesionProvider); // Obtén las lesiones del proveedor

    return Scaffold(
      appBar: CustomAppBar(
          child:
              const Text("Todas las lesiones", style: TextStyle(fontSize: 24))),
      body: lesionData.lesions.isEmpty
          ? const Center(child: Text("No hay lesiones registradas"))
          : ListView.builder(
              itemCount: lesionData.lesions.length,
              itemBuilder: (context, index) {
                final lesion = lesionData.lesions[index];

                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de edición con los datos de la lesión
                    context.pushNamed('LesionEdit', extra: {
                      'lesionData': lesion, // LesionData
                      'index': index, // Índice de la lesión
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title:
                          Text(lesion.clinicalDiagnosis), // Nombre de la lesión
                      subtitle:
                          Text(lesion.location), // Descripción de la lesión
                      leading: const Icon(Icons
                          .health_and_safety), // Icono representativo de lesión
                    ),
                  ),
                );
              },
            ),
    );
  }
}
