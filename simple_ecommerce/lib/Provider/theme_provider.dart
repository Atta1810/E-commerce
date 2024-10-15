import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A ChangeNotifier class that manages the theme of the application.
class ThemeProvider with ChangeNotifier {
  // Constant key used for storing the theme status in shared preferences.
  static const String THEME_STATUS = "THEME_STATUS";

  // Private variable to track whether the dark theme is enabled.
  bool _darkTheme = false;

  /// Getter to retrieve the current dark theme status.
  bool get getIsDarkTheme => _darkTheme;

  /// Method to load the theme preference from SharedPreferences.
  Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme =
        prefs.getBool(THEME_STATUS) ?? false; // Default to false (light theme)
    notifyListeners();
  }

  setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the new theme value to shared preferences.
    await prefs.setBool(THEME_STATUS, themeValue);

    // Update the private variable to reflect the new theme status.
    _darkTheme = themeValue;

    // Notify listeners that the theme status has changed.
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(THEME_STATUS) ?? false;
    notifyListeners();

    return _darkTheme;
  }
}
