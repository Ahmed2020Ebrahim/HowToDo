import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localiz_state.dart';

class LocalizCubit extends Cubit<Locale> {
  LocalizCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }
  void changeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("locale", locale.languageCode);
    emit(locale);
  }

  //load saved locale
  /// Load saved locale (if any)
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString("locale");

    if (code != null && code.isNotEmpty) {
      emit(Locale(code));
    }
  }
}
