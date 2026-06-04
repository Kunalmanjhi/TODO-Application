import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  static const String _boxName = 'settings';
  static const String _themeKey = 'isDarkMode';

  late Box _settingsBox;
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _settingsBox = Hive.box(_boxName);
    _isDarkMode.value = _settingsBox.get(_themeKey, defaultValue: false);
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _settingsBox.put(_themeKey, _isDarkMode.value);
    Get.changeThemeMode(themeMode);
  }

  // ─── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    const primary = Color(0xFF6C63FF);
    const secondary = Color(0xFFFF6584);
    const surface = Color(0xFFF8F7FF);
    const cardBg = Colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: const Color(0xFF1A1A2E),
        surfaceContainerHighest: cardBg,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: const Color(0xFF1A1A2E),
        displayColor: const Color(0xFF1A1A2E),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A2E)),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xFF1A1A2E),
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0EEFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF6C63FF)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF0EEFF),
        selectedColor: primary,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // ─── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    const primary = Color(0xFF8B83FF);
    const secondary = Color(0xFFFF6584);
    const surface = Color(0xFF0F0E17);
    const cardBg = Color(0xFF1C1B2E);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: const Color(0xFFEFEEFF),
        surfaceContainerHighest: cardBg,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: const Color(0xFFEFEEFF),
        displayColor: const Color(0xFFEFEEFF),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFEFEEFF)),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xFFEFEEFF),
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Color(0xFF0F0E17),
        elevation: 6,
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF252438),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF8B83FF)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF252438),
        selectedColor: primary,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}