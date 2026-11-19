import 'package:flutter/material.dart';

import '../../widgets/shared/app_bar/custom_pop_menu_app_bar.dart';
import '../../widgets/shared/bottom_bar/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final int selectedIndex; // Índice seleccionado

  const HomeScreen({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPopMenuAppBar(),
      body: const Center(
        child: Text("Bienvenido a DERMAUH"),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex, // Usar el índice proporcionado
      ),
    );
  }
}
