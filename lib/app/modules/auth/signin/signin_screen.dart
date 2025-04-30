// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_controller.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../auth_controller.dart';
import 'components/signin_form.dart';

class SigninScreen extends GetView<AuthController> {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        appBar: AppBar(
          backgroundColor:
              Get.find<AppController>().isDarkModeOn.value
                  ? ColorConstants.darkScaffoldBackgroundColor
                  : ColorConstants.white,
          toolbarHeight: 50,
          leading: CustomIconButton(
            height: 35,
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  Get.find<AppController>().isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.kSecondColor5,
              size: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(Get.width, 2),
            child: Container(height: 1, color: ColorConstants.kSecondColor10),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: getPadding(left: 20, right: 20, top: 20),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
