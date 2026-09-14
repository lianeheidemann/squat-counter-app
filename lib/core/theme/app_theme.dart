import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF55D98B);
  static const Color cyan = Color(0xFF66BBD8);
  static const Color background = Color(0xFF111416);
  static const Color surface = Color(0xFF181C1E);
  static const Color surfaceHigh = Color(0xFF202527);
  static const Color outline = Color(0xFF303638);

  static ThemeData get theme {
    const colors = ColorScheme.dark(
      primary: primary,
      onPrimary: Color(0xFF07150D),
      primaryContainer: Color(0xFF1B3929),
      onPrimaryContainer: Color(0xFFAAEFC5),
      secondary: cyan,
      onSecondary: Color(0xFF071419),
      surface: surface,
      onSurface: Color(0xFFE7EAEB),
      onSurfaceVariant: Color(0xFF9CA3A6),
      outline: outline,
      surfaceContainerHighest: surfaceHigh,
      error: Color(0xFFE67B7B),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'sans-serif',
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Color(0xFFDDE1E2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 54,
        titleSpacing: 16,
        iconTheme: IconThemeData(color: Color(0xFFABB2B4), size: 21),
        titleTextStyle: TextStyle(
          color: Color(0xFFDDE1E2),
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF08140D),
          disabledBackgroundColor: const Color(0xFF25332C),
          disabledForegroundColor: const Color(0xFF7E8782),
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFAEB4B6),
          minimumSize: const Size.fromHeight(46),
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Color(0xFFE8EBEC),
          fontSize: 27,
          height: 1.08,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.7,
        ),
        titleLarge: TextStyle(
          color: Color(0xFFE1E5E6),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF9CA3A6),
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
