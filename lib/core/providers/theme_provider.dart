import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart' as riverpod;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_startup_provider.dart';

const kThemeModeKey = 'themeMode';

final themeModeProvider =
    riverpod.NotifierProvider<ThemeModeController, ThemeMode>(
      ThemeModeController.new,
    );

class ThemeModeController extends riverpod.Notifier<ThemeMode> {
  late SharedPreferences _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.read(sharedPreferencesProvider);
    final stored = _prefs.getString(kThemeModeKey);
    return _decodeThemeMode(stored);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(kThemeModeKey, _encodeThemeMode(mode));
  }
}

ThemeMode _decodeThemeMode(String? value) {
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

String _encodeThemeMode(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.system:
      return 'system';
  }
}
