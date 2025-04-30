import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/models/response/category_response.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_repository.dart';
import '../../../core/lang/language.dart';
import '../../../core/lang/translation_service.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/common_widget.dart';
import 'components/tabIcon_data.dart';
import 'tabs/tabs.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiRepository apiRepository;

  HomeController({required this.apiRepository});
  DateTime? currentBackPressTime;

  var currentTab = MainTabs.home.obs;
  int tabIndex = 0;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  RxInt bottomNavIndex = 0.obs;
  RxString selectedCategory = "".obs;

  late TabController tabController;
  final prefs = Get.find<SharedPreferences>();

  final RxList<String> categoriesName =
      [
        "Telegram",
        "Instagram",
        "Tiktok",
        "YouTube",
        "Facebook",
        "Spotify",
        "Snapchat",
        "Website",
        "Trovo",
        "Lazada",
      ].obs;
  RxList<CategoryResponse> categories = <CategoryResponse>[].obs;
  final List<String> bottomNavSelectedIconPaths = [
    ImageConstant.iconBottomHomeBold,
    ImageConstant.iconBottomCategory,
    ImageConstant.iconBottomWalletBold,
    ImageConstant.iconBottomSupportBold,
    ImageConstant.iconBottomProfileBold,
  ];

  final List<String> imagePaths = [
    ImageConstant.iconBottomHome,
    ImageConstant.iconBottomCategory,
    ImageConstant.iconBottomWallet,
    ImageConstant.iconBottomSupport,
    ImageConstant.iconBottomProfile,
  ];
  var currentIndex = 0.obs; // Observable variable to track the current index

  void setCurrentIndex(int index) {
    currentIndex.value = index; // Update the current index
  }

  @override
  void onInit() async {
    super.onInit();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      tabIndex = tabController.index;
    });
  }

  final _selectedLanguage = Language(1, "🇺🇸", "English", "en").obs;
  Language get selectedLanguage => _selectedLanguage.value;

  void getCategories(String name) async {
    var res = await apiRepository.getCategories(name);
    if (res != null) {
      res.data.forEach((element) {
        categories.add(CategoryResponse.fromJson(element));
      });
    } else {
      showDarkSnackbar("error".tr, "noInternetError");
    }
  }

  void handleLanguageSelection(Language? language) {
    if (language != null) {
      _selectedLanguage.value = language;
      String code = language.code;

      if (code == 'fa') {
        TranslationService.changeLocale('fa');
      } else if (code == 'en') {
        TranslationService.changeLocale('en');
      } else if (code == 'ko') {
        TranslationService.changeLocale('ko');
      }
    }
  }

  void resetState() => bottomNavIndex.value = 0;

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

  void changeTabIndex(int index) {
    tabIndex = index;
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  void setValueBottomIndex(int index) {
    bottomNavIndex.value = index;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.discover:
        return 1;
      case MainTabs.resource:
        return 2;
      case MainTabs.inbox:
        return 3;
      case MainTabs.me:
        return 4;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.discover;
      case 2:
        return MainTabs.resource;
      case 3:
        return MainTabs.inbox;
      case 4:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    result = await Permission.photos.request();
    if (result.isGranted) {
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    super.dispose();
  }
}
