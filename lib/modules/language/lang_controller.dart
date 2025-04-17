import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../lang/language.dart';
import '../../lang/translation_service.dart';
import '../../shared/constants/common.dart';
import '../../shared/widgets/common_widget.dart';

class LangController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiRepository apiRepository;
  final box = GetStorage();
  RxString selectedValue = 'ٌEnglish'.obs;
  List<Language> langs = [
    Language(1, "US", "English", "en"),
    Language(2, "IR", "Persian", "fa"),
    Language(3, "AR", "Arabic", "ar"),
  ];

  LangController({required this.apiRepository});
  DateTime? currentBackPressTime;

  final prefs = Get.find<SharedPreferences>();

  @override
  void onInit() async {
    String? lang = box.read('lang');
    if (lang != null) {
      TranslationService.changeLocale(lang);
    }
    super.onInit();
  }

  var defaultLang = Language(1, "🇺🇸", "English", "en").obs;
  Language get selectedLanguage => defaultLang.value;

  void handleLanguageSelection(Language? language) {
    if (language != null) {
      defaultLang.value = language;
      String code = language.code;

      if (code == 'fa') {
        TranslationService.changeLocale('fa');
        box.write('lang', 'fa');
      } else if (code == 'en') {
        TranslationService.changeLocale('en');
        box.write('lang', 'en');
      } else if (code == 'ar') {
        box.write('lang', 'ar');
        TranslationService.changeLocale('ar');
      }
      debugPrint("Bạn đã chọn: ${language.name}");
    }
  }

  bool isRtl() {
    return Get.locale!.languageCode != 'en' ? true : false;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;
      CommonWidget.toast(CommonConstants.tittleExitApp.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  String? currentLang() {
    return box.read("lang");
  }

  @override
  void onClose() {
    super.dispose();
  }
}
