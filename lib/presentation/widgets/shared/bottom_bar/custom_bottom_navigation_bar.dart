import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/dynamic_elements/component_map.dart'; // Asegúrate de importar GoRouter

class CustomBottomNavigationBar extends StatelessWidget {

  final int selectedIndex;
  final void Function(int)? onItemTapped;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor; // Nuevo parámetro para el color de fondo

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onItemTapped,
    this.selectedItemColor =
        const Color.fromARGB(255, 202, 58, 143), // Color por defecto
    this.unselectedItemColor = Colors.grey, // Color por defecto
    this.backgroundColor = Colors.white, // Color de fondo por defecto
  });

  

   void _navigateTo(BuildContext context, int index) {
    String selectedKey = componentsMap.keys.elementAt(index);
    String targetRoute = componentsMap[selectedKey]!['route'];

    // Obtener la ruta actual
    final currentRoute = GoRouter.of(context).state.uri.path;

    // Si la ruta actual es la misma que la ruta destino, no navegar
    if (currentRoute == targetRoute) {
      return; // Cancela la navegación
    }

    // Navegar a la ruta correspondiente
    context.push(targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped ?? (index) => _navigateTo(context, index),
      items: componentsMap.entries
          .map((entry) => BottomNavigationBarItem(
                icon: entry.value['icon'],
                label: entry.value['title'],
              ))
          .toList(),
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      backgroundColor: backgroundColor, // Establecer el color de fondo
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
