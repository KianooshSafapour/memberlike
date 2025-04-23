// ignore_for_file: unused_field, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_binding.dart';
import 'app_controller.dart';
import 'di.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'shared/constants/colors.dart';
import 'shared/utils/app_flavor_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> mainCommon(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: "https://fhwlazwfxxdfupbtsjyw.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZod2xhendmeHhkZnVwYnRzanl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk1MzY3NzUsImV4cCI6MjA1NTExMjc3NX0.pAbURypQsZ72Td_aWis9lKVpztOQvOFrgcRqyXbzpno",
  );
  await GetStorage.init();
  await Future.wait([
    DenpendencyInjection.init(),
    DenpendencyInjection.inject(flavor),
  ]);

  await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);

  runApp(App(flavor));

  configLoading();
}

class App extends GetView<AppController> {
  final AppFlavor flavor;

  App(this.flavor, {super.key});

  final mainTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    unselectedWidgetColor: ColorConstants.kSecondColor8,
    //appBarTheme: AppBarTheme(color: Colors.white),
  );

  final darkTheme = ThemeConfig.darkTheme;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        initialBinding: AppBinding(flavor),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.SPLASH,
        defaultTransition: Transition.fade,
        getPages: AppPages.routes,
        smartManagement: SmartManagement.keepFactory,
        title: 'Woo People',
        theme: controller.isDarkModeOn.value ? darkTheme : mainTheme,
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = ColorConstants.kPrimaryColor
    ..textColor = ColorConstants.kPrimaryColor
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
