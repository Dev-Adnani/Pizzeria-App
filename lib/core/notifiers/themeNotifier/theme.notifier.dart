import 'package:flutter/material.dart';
import 'package:pizzeria/app/constants/app.colors.dart';
import 'package:pizzeria/app/constants/app.keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.orange,
    brightness: Brightness.dark,
    background: AppColors.tealDark,
  ),
  fontFamily: 'Avenir',
  indicatorColor: AppColors.orange,
  dividerColor: Colors.white54,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black,
    actionTextColor: AppColors.orange,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
  }),
);

final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.black,
      brightness: Brightness.light,
      background: Colors.white,
    ),
    fontFamily: 'Avenir',
    indicatorColor: const Color(0xff4B7191),
    dividerColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
    }));

class ThemeNotifier extends ChangeNotifier {
  bool _darktheme = false;
  bool get darkTheme => _darktheme;

  ThemeNotifier() {
    _loadFromPrefs();
  }

  toggleTheme() {
    _darktheme = !_darktheme;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    var val = await getDarkMode();
    _darktheme = val ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await saveDarkMode(_darktheme);
  }

  static Future<bool> saveDarkMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AppKeys.appMode, darkMode);
  }

  static Future<bool?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppKeys.appMode);
  }
}
