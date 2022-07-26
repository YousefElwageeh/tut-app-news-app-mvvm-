import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/langauge_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<String> getAppLanguage() async {
    String? language = sharedPreferences?.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }

  static Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      sharedPreferences?.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // set arabic
      sharedPreferences?.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  static Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();
    print('currentLang     $currentLang');
    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }
  // on boarding

  static Future<void> setOnBoardingScreenViewed() async {
    sharedPreferences?.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  static Future<bool> isOnBoardingScreenViewed() async {
    return sharedPreferences?.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //login

  static Future<void> setUserLoggedIn() async {
    sharedPreferences?.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  static Future<bool> isUserLoggedIn() async {
    return sharedPreferences?.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  static Future<void> logout() async {
    sharedPreferences?.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
