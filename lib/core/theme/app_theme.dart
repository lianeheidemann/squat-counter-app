import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4FE58C);
  static const Color cyan = Color(0xFF56C8F2);
  static const Color background = Color(0xFF07100E);
  static const Color surface = Color(0xFF0C1714);
  static const Color surfaceHigh = Color(0xFF12211D);
  static const Color outline = Color(0xFF20342E);

  static ThemeData get theme {
    const colors = ColorScheme.dark(
      primary: primary,
      onPrimary: Color(0xFF03170C),
      primaryContainer: Color(0xFF103523),
      onPrimaryContainer: Color(0xFF9DF5C0),
      secondary: cyan,
      onSecondary: Color(0xFF001E2A),
      surface: surface,
      onSurface: Color(0xFFF2F7F4),
      onSurfaceVariant: Color(0xFF8FA29B),
      outline: outline,
      surfaceContainerHighest: surfaceHigh,
      error: Color(0xFFFF7676),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Color(0xFFF2F7F4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 58,
        titleSpacing: 20,
        titleTextStyle: TextStyle(
          color: Color(0xFFF2F7F4),
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF03170C),
          disabledBackgroundColor: const Color(0xFF173026),
          disabledForegroundColor: const Color(0xFF73867F),
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFB6C3BE),
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Color(0xFFF4F8F6),
          fontSize: 30,
          height: 1.08,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        titleLarge: TextStyle(
          color: Color(0xFFF4F8F6),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF91A39C),
          fontSize: 15,
          height: 1.4,
        ),
      ),
    );
  }
}
