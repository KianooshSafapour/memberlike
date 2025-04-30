// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/widgets/custom_icon_button.dart';
import '../../../../app_controller.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/utils/size_utils.dart';
import 'components/login_form.dart';
import '../auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
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
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
