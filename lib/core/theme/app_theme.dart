import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primary = Color(0xFF00B686);
  static const Color _secondary = Color(0xFF6C63FF);
  static const Color _tertiary = Color(0xFFFFC857);
  static const Color _surfaceLight = Color(0xFFF6F7FB);
  static const Color _surfaceDark = Color(0xFF0B1220);
  static const Color _cardLight = Colors.white;
  static const Color _cardDark = Color(0xFF141F33);

  static final TextTheme _textTheme = GoogleFonts.plusJakartaSansTextTheme();

  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: _primary,
        secondary: _secondary,
        tertiary: _tertiary,
        surface: _cardLight,
        surfaceContainerLowest: _surfaceLight,
        surfaceContainerLow: const Color(0xFFEEF2F8),
        surfaceContainerHigh: const Color(0xFFE2E8F0),
        surfaceContainerHighest: const Color(0xFFD7DEE9),
        onSurface: const Color(0xFF0F172A),
        onSurfaceVariant: const Color(0xFF334155),
        outline: const Color(0xFF94A3B8),
        outlineVariant: const Color(0xFFD0D8E5),
      );

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xFF4ADEBB),
        secondary: const Color(0xFF9B94FF),
        tertiary: _tertiary,
        surface: _cardDark,
        surfaceContainerLowest: _surfaceDark,
        surfaceContainerLow: const Color(0xFF10192A),
        surfaceContainerHigh: const Color(0xFF17243A),
        surfaceContainerHighest: const Color(0xFF1F2F4A),
        onSurface: Colors.white,
        onSurfaceVariant: const Color(0xFFCBD5F5),
        outline: const Color(0xFF475569),
        outlineVariant: const Color(0xFF2B384F),
      );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: _lightScheme,
    textTheme: _textTheme,
    scaffoldBackgroundColor: _surfaceLight,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _lightScheme.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: _lightScheme.onSurface,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _cardLight.withValues(alpha: 0.9),
      elevation: 6,
      height: 72,
      indicatorColor: _primary.withValues(alpha: 0.16),
      surfaceTintColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: _primary, size: 28);
        }
        return const IconThemeData(color: Color(0xFF64748B), size: 26);
      }),
      labelTextStyle: WidgetStateProperty.all(
        _textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFE2E8F0),
      selectedColor: _primary.withValues(alpha: 0.15),
      secondarySelectedColor: _primary,
      labelStyle: _textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      secondaryLabelStyle: _textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    cardTheme: CardThemeData(
      color: _cardLight,
      elevation: 4,
      shadowColor: Colors.black12,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: _textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _secondary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: _textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primary,
        side: const BorderSide(color: _primary, width: 1.2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: _textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      hintStyle: _textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF94A3B8),
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: _darkScheme,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: _surfaceDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF111B2D).withValues(alpha: 0.92),
      indicatorColor: const Color(0xFF26334C),
      elevation: 6,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: Color(0xFF4ADEBB), size: 28);
        }
        return const IconThemeData(color: Color(0xFFA2B2D5), size: 26);
      }),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: _cardDark,
      shadowColor: Colors.black38,
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1F2937),
      selectedColor: const Color(0xFF26334C),
      secondarySelectedColor: const Color(0xFF4ADEBB),
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFE2E8F0),
      ),
      secondaryLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF0B1220),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4ADEBB),
        foregroundColor: const Color(0xFF03271F),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF9B94FF),
        foregroundColor: const Color(0xFF0B1220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF4ADEBB),
        side: const BorderSide(color: Color(0xFF4ADEBB), width: 1.2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF16223A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: const Color(0xFF74809C),
        fontSize: 14,
      ),
    ),
  );
}
