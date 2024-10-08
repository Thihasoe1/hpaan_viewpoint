import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService extends Translations {
  // Supported languages
  static final langs = ['English', 'Myanmar'];

  // Supported locales
  static final locales = [
    Locale('en', 'US'),
    Locale('my', 'MM'),
  ];

  // Default locale
  static final locale = Locale('en', 'US');

  // Fallback locale in case something goes wrong
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'profile': 'Profile',
      'home': 'Home',
      'search': 'Search',
      'favourite': 'Favourite',
    },
    'my_MM': {
      'profile': 'ကိုယ်ရေးအကျဉ်း',
      'home': 'ပင်မစာမျက်နှာ',
      'search': 'ရှာဖွေရန်',
      'favourite': 'အကြိုက်ဆုံး',
    },
  };

  static String getFlagImage(String language) {
    switch (language) {
      case 'Myanmar':
        return 'assets/images/myanmar_flag.png';
      case 'English':
      default:
        return 'assets/images/us_flag.png';
    }
  }

  // Get locale from the language
  static Locale? getLocaleFromLanguage(String language) {
    for (int i = 0; i < langs.length; i++) {
      if (language == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  static Future<void> changeLocale(String language) async {
    final locale = getLocaleFromLanguage(language);
    Get.updateLocale(locale!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  static Future<void> loadSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');
    debugPrint("selected language =====> $savedLanguage");
    if (savedLanguage != null) {
      final locale = getLocaleFromLanguage(savedLanguage);
      Get.updateLocale(locale!);
    }
  }
}
