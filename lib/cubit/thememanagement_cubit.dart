import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'thememanagement_state.dart';

class ThemeManagementCubit extends Cubit<ThemeManagementState> {
  ThemeManagementCubit() : super(ThemeManagementState(themeMode: "light"));

  static const THEME_KEY = "theme_key";

  setTheme(String value) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(THEME_KEY, value);
    emit(ThemeManagementState(themeMode: value));


  }

  Future<void> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(THEME_KEY) == "dark") {
      emit(ThemeManagementState(themeMode: "dark")) ;
    } else {
      emit(ThemeManagementState(themeMode: "light")) ;
    }

  }
}
