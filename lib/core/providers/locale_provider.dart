import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart' as riverpod;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_startup_provider.dart';

const kLocaleKey = 'appLocale';

final localeProvider = riverpod.NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends riverpod.Notifier<Locale?> {
  late SharedPreferences _prefs;

  @override
  Locale? build() {
    _prefs = ref.read(sharedPreferencesProvider);
    final code = _prefs.getString(kLocaleKey);
    return code == null || code.isEmpty ? null : Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    if (locale == null) {
      await _prefs.remove(kLocaleKey);
    } else {
      await _prefs.setString(kLocaleKey, locale.languageCode);
    }
  }
}
