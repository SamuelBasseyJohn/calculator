import 'package:flutter/material.dart';

import '../Model/theme_mode.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode appTheme;
  bool selected = false;

  AppTheme(this.appTheme);

  setTheme() {
    selected == true ? appTheme = ThemeMode.dark : appTheme = ThemeMode.light;
    notifyListeners();
  }
}
