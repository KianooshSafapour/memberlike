import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';

import '../../app_controller.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/image_constant.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //     const Duration(seconds: 2),
  //     () async {
  //       final prefs = await SharedPreferences.getInstance();
  //       final accessToken = await prefs.getString(StorageConstants.token);
  //       Get.offAllNamed(accessToken != null ? Routes.HOME : Routes.LANGUAGE);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : ColorConstants.white,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(svgPath: ImageConstant.logo),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "App for selling social network services",
                  style: CommonConstants.kSecondaryTextStyle,
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: ColorConstants.kPrimaryColor10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
