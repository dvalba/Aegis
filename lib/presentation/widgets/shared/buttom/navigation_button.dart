import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class NavigationButton extends StatelessWidget {
  final String label;
  final String routeName;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Map<String, dynamic>? extra;  // Parámetro extra para datos adicionales

  const NavigationButton({
    super.key,
    required this.label,
    required this.routeName,
    required this.backgroundColor,
    required this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    this.borderRadius = 24,
    this.extra, // Recibimos los datos adicionales
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.pushNamed(routeName, extra: extra);  // Aquí pasa `extra` si es no-null o lo omite si es null
      },
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}

