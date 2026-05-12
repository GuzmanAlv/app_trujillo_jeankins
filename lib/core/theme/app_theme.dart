import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales inspirados en Trujillo
  static const Color primario = Color(0xFF8B1A1A);     // Rojo colonial
  static const Color secundario = Color(0xFFD4A017);   // Dorado
  static const Color fondo = Color(0xFFF5F0EB);        // Crema
  static const Color texto = Color(0xFF2C2C2C);        // Oscuro
  static const Color exito = Color(0xFF2E7D32);        // Verde
  static const Color error = Color(0xFFC62828);        // Rojo error

  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primario,
        primary: primario,
        secondary: secundario,
        surface: fondo,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primario,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      fontFamily: 'Roboto',
    );
  }
}