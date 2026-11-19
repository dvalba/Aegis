import 'package:flutter/material.dart';

List<Color> aegisColors = [
  const Color.fromARGB(255, 17, 17, 17), // Primario — negro
  const Color.fromARGB(255, 64, 64, 64), // Secundario — gris oscuro
];

class AppThemes {
  ThemeData theme() {
    // Generar el esquema de colores desde la semilla y ajustar los colores
    final colorScheme = ColorScheme.fromSeed(
      seedColor: aegisColors[0],
    ).copyWith(
      primary: aegisColors[0],
      secondary: aegisColors[1],
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: aegisColors[1],
        elevation: 4,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: aegisColors[0],
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge:
            TextStyle(color: Colors.black, fontSize: 16), // Texto estándar
        bodyMedium: TextStyle(color: Colors.black87), // Texto secundario
      ),
    );
  }
}
