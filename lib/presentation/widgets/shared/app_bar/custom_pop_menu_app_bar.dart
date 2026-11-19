import 'package:aegis/presentation/widgets/shared/logos/derma_text_logo.dart';
import 'package:flutter/material.dart';
import '../../home/custom_popup_menu_widget.dart';

class CustomPopMenuAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPopMenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: const CustomPopupMenuWidget(), // El menú desplegable
      title: const Column(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 30); // Establece la altura del AppBar
}
