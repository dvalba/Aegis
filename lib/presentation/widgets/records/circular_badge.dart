import 'package:flutter/material.dart';

class CircularBadge extends StatelessWidget {
  final String label;
  final Color textColor; // Color del texto
  final double size; // Diámetro del badge
  final Color backgroundColor; // Color de fondo del badge

  const CircularBadge({
    super.key,
    required this.label,
    this.size = 50.0,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Diámetro del círculo
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor, // Color de fondo del badge
        shape: BoxShape.circle, // Hacemos que el badge sea redondo
      ),
      child: FittedBox(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
