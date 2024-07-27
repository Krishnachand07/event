import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  static TextStyle customFont = GoogleFonts.getFont(
    'Montserrat',
  );
  static ThemeData birthdayDarkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF232323),
    cardColor: const Color(0xFF2B2B2B),
    cardTheme: const CardTheme(color: Color(0xFF2B2B2B)),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1a4331)),
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
        titleMedium: TextStyle(color: Colors.white70, fontSize: 16),
        titleSmall: TextStyle(color: Colors.white60, fontSize: 14),
        bodySmall: TextStyle(color: Colors.white60, fontSize: 10),
        bodyMedium: TextStyle(color: Colors.white60, fontSize: 12)),
    listTileTheme: const ListTileThemeData(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        subtitleTextStyle: TextStyle(color: Colors.white54, fontSize: 14)),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: customFont.fontFamily)),
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    fontFamily: customFont.fontFamily,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green, brightness: Brightness.dark),
    useMaterial3: true,
  );

  static ThemeData birthdayLightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFb7e4c7)),
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black, fontSize: 18),
        titleMedium: TextStyle(color: Colors.black, fontSize: 16),
        titleSmall: TextStyle(color: Colors.black54, fontSize: 14),
        bodySmall: TextStyle(color: Colors.black54, fontSize: 10),
        bodyMedium: TextStyle(color: Colors.black54, fontSize: 12)),
    listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontFamily: customFont.fontFamily),
        subtitleTextStyle: TextStyle(
            color: Colors.black45,
            fontSize: 14,
            fontFamily: customFont.fontFamily)),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: customFont.fontFamily)),
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    fontFamily: customFont.fontFamily,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green, brightness: Brightness.light),
    useMaterial3: true,
  );
}

class CustomThemeProvider extends ChangeNotifier {
  ThemeMode? themeMode;
  ThemeMode get currentThemeMode => themeMode ?? ThemeMode.light;
  Future<void> initTheme() async {
    final pref = await SharedPreferences.getInstance();
    String? savedThemeMode;
    if (pref.getString('theme-mode') != null) {
      savedThemeMode = pref.getString('theme-mode');
    }
    if (savedThemeMode == 'light') {
      themeMode = ThemeMode.light;
    } else if (savedThemeMode == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('theme-mode', newThemeMode.name);
    themeMode = newThemeMode;
    notifyListeners();
  }
}
