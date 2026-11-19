import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    this.iconSize = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize, // Diametro del circulo
      height: iconSize, // Diameter of the circle
      decoration: BoxDecoration(
        color: backgroundColor, // Background color
        shape: BoxShape.circle, // Circular shape
      ),
      child:FittedBox(
        child: IconButton(
          icon: Icon(icon),
          tooltip: tooltip,
          onPressed: onPressed,
          color: iconColor,
        ),
      ),
    );
  }
}
