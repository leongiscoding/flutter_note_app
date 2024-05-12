import 'package:flutter/material.dart';
import 'package:flutter_note_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // initialize default theme
  ThemeData _themeData = lightMode;

  // getter method to access theme from other code
  ThemeData get themeData => _themeData;

  // getter method to see if dark mode is active
  bool get isDarkMode => _themeData == darkMode;

  // Load saved theme on initialization
  Future<void> loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('currentTheme') ?? 'light'; // Default theme if not saved

    switch (themeName) {
      case 'light':
        _themeData = lightMode;
        break;
      case 'dark':
        _themeData = darkMode;
        break;
      default:
        _themeData = lightMode; // Handle unexpected theme names
    }
    notifyListeners();
  }

  // Save the selected theme
  Future<void> saveThemeToPrefs(ThemeData themeData) async {
    final prefs = await SharedPreferences.getInstance();
    String themeName;
    if (themeData == lightMode) {
      themeName = 'light';
    } else {
      themeName = 'dark';
    }
    await prefs.setString('currentTheme', themeName);
  }

  // set and notify when theme has changed
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    saveThemeToPrefs(themeData); // Save theme to SharedPreferences
    notifyListeners();
  }

  // toggle theme and save the change
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
