// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/core/routes/app_pages.dart';
import 'package:memberlike/shared/constants/colors.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import 'package:memberlike/shared/widgets/custom_outlined_button.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import '../../../../../app_controller.dart';
import '../../../../../shared/constants/common.dart';
import '../../../../../shared/constants/image_constant.dart';
import '../../../../../shared/utils/no_space_formatter.dart';
import '../../../../../shared/utils/size_utils.dart';
import '../../../../../shared/widgets/app_check_box.dart';
import '../../../../../shared/widgets/button.dart';
import '../../../../../shared/widgets/input_field.dart';
import '../../auth_controller.dart';

class SignUpForm extends GetView<AuthController> {
  final AppController appController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Text(
              CommonConstants.btnSignUp.tr,
              style: CommonConstants.kTitleTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: CommonConstants.mediumPadding,
                bottom: 4,
              ),
              child: customAlign(
                child: Text(
                  "email".tr,
                  style: CommonConstants.kSecondaryTextStyle,
                ),
              ),
            ),
            InputField(
              keyboardType: TextInputType.emailAddress,
              isBorder: true,
              controller: controller.registerEmailController,
              hintText: "email".tr,
              inputFormatters: [NoSpaceLowerCaseFormatter()],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return CommonConstants.enterYourPhone.tr;
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: CommonConstants.mediumPadding,
                bottom: 4,
              ),
              child: customAlign(
                child: Text(
                  "firstName".tr,
                  style: CommonConstants.kSecondaryTextStyle,
                ),
              ),
            ),
            InputField(
              keyboardType: TextInputType.text,
              isBorder: true,
              controller: controller.registerFirstNameController,
              hintText: "firstName".tr,
              inputFormatters: [NoSpaceLowerCaseFormatter()],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return CommonConstants.enterYourPhone.tr;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: CommonConstants.mediumPadding,
                bottom: 4,
              ),
              child: customAlign(
                child: Text(
                  "lastName".tr,
                  style: CommonConstants.kSecondaryTextStyle,
                ),
              ),
            ),
            InputField(
              keyboardType: TextInputType.text,
              isBorder: true,
              controller: controller.registerLastNameController,
              hintText: "lastName".tr,
              inputFormatters: [NoSpaceLowerCaseFormatter()],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return CommonConstants.enterYourPhone.tr;
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: CommonConstants.mediumPadding,
                bottom: 4,
              ),
              child: customAlign(
                child: Text(
                  "password".tr,
                  style: CommonConstants.kSecondaryTextStyle,
                ),
              ),
            ),
            InputField(
              keyboardType: TextInputType.visiblePassword,
              isBorder: true,
              controller: controller.registerPasswordController,
              hintText: "password".tr,
              //inputFormatters: [NoSpaceLowerCaseFormatter()],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return CommonConstants.enterYourPhone.tr;
                }
                return null;
              },
            ),

            const SizedBox(height: CommonConstants.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 35,
                  child: AppCheckbox(
                    checked: controller.isAgree.value,
                    onChecked: (value) => controller.isAgree.value = value!,
                  ),
                ),
                Text("iAcceptAll".tr, style: CommonConstants.kTitleTextStyle),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "rulesAndConditions".tr,
                    style: CommonConstants.kSecondaryTextStyle.copyWith(
                      color: ColorConstants.kPrimaryColor5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () => Get.toNamed(Routes.SIGN_UP),
                ),
              ],
            ),

            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.primaryButton(
                  text: CommonConstants.confirm.tr,
                  onPressed: () => controller.register(_formKey),
                ),
                const SizedBox(height: 20),
                CustomOutlinedButton(
                  onTap: () {
                    controller.signInWithGoogle();
                  },
                  height: CommonConstants.height45,
                  leftIcon: CustomImageView(
                    margin: const EdgeInsets.only(
                      right: CommonConstants.smallPadding,
                    ),
                    svgPath: ImageConstant.iconGoogle,
                    height: getSize(25),
                    width: getSize(25),
                  ),
                  text: "signUpWithGoogle".tr,
                  buttonTextStyle: const TextStyle(
                    color: ColorConstants.kPrimaryColor6,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "doYouHaveAnAccount".tr,
                      textAlign: TextAlign.center,
                      style: CommonConstants.kTitleTextStyle,
                    ),
                    TextButton(
                      child: Text(
                        CommonConstants.btnSignIn.tr,
                        style: CommonConstants.kSecondaryTextStyle.copyWith(
                          color: ColorConstants.kPrimaryColor5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () async {
                        Get.toNamed(Routes.LOG_IN);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.10),

            // SocialSignUp(),
          ],
        ),
      ),
    );
  }
}
