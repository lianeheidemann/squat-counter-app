import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF39E982);
  static const Color background = Color(0xFF07110E);
  static const Color surface = Color(0xFF0D1A16);
  static const Color outline = Color(0xFF294039);

  static ThemeData get theme {
    const colors = ColorScheme.dark(
      primary: primary,
      onPrimary: Color(0xFF032112),
      primaryContainer: Color(0xFF123E2A),
      onPrimaryContainer: Color(0xFF86F7B6),
      surface: surface,
      onSurface: Color(0xFFF4F8F6),
      onSurfaceVariant: Color(0xFFA7B5AF),
      outline: outline,
      surfaceContainerHighest: Color(0xFF1B3029),
      error: Color(0xFFFF6B6B),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Color(0xFFF4F8F6),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFFF4F8F6),
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF021A0E),
          disabledBackgroundColor: const Color(0xFF1C352B),
          disabledForegroundColor: const Color(0xFF789086),
          elevation: 0,
          minimumSize: const Size.fromHeight(58),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFF4F8F6),
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: Color(0xFF587068)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: primary,
          backgroundColor: const Color(0xFF123126),
          disabledForegroundColor: const Color(0xFF587068),
          disabledBackgroundColor: const Color(0xFF14221D),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Color(0xFFF7FAF8),
          fontSize: 31,
          height: 1.12,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: Color(0xFFF7FAF8),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFFA7B5AF),
          fontSize: 16,
          height: 1.45,
        ),
      ),
    );
  }
}
