import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/auth/auth_provider.dart';

class CustomPopupMenuWidget extends ConsumerWidget {
  const CustomPopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    

    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.black),
      onSelected: (value) {
        // Maneja las acciones del menú aquí
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'), // Añade tu imagen de avatar
            ),
            title: Text("Olivia Rhyne"),
            subtitle: Text("olivia@untitledui.com"),
          ),
        ),
        const PopupMenuDivider(),
        _buildMenuItem(Icons.person, "Ver Perfil", null),
        _buildMenuItem(Icons.settings, "Configuración", null),
        _buildMenuItem(Icons.medical_services, "Equipo Médico", null),
        _buildMenuItem(Icons.group, "Comunidad", null),
        _buildMenuItem(Icons.support, "Soporte", null),
        const PopupMenuDivider(),
        _buildMenuItem(Icons.logout, "Cerrar sesión", 
        ref.read(authProvider.notifier).logout
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String title, Function()? onTap) {
    return PopupMenuItem(
      value: title.toLowerCase(),
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
      ),
    );
  }
}
