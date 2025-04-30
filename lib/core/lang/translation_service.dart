import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'value/en_US.dart';
import 'value/fa_IR.dart';
import 'value/ar_AR.dart';

class TranslationService extends Translations {
  static Locale? get locale => fallbackLocale;
  static const fallbackLocale = Locale('en', 'US');

  static final langCodes = ['en', 'fa', 'ar'];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('fa', 'IR'),
    const Locale('ar', 'AR'),
  ];

  static final langs =
      LinkedHashMap.from({'en': 'English', 'fa': 'Persian', 'ar': 'Arabic'});

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'fa_IR': fa,
        'ar_AR': ar,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
