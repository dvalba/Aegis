import 'package:flutter/material.dart';
import '../logos/derma_text_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;

  const CustomAppBar({
    super.key,
    this.child, // Widget opcional para contenido adicional
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DermaTextLogo(),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
      leadingWidth: 45,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // Vuelve atrás a la pantalla anterior
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: child ??
              Container(), // Usa el widget proporcionado o un contenedor vacío
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);
}
