import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final int selectedIndex; // Índice seleccionado

  const SettingsScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: colors.primary // Color del AppBar
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: const Center(
          child: Text(
            "Esta sección está en desarrollo. ¡Pronto estará disponible!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
