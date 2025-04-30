import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/constants/image_constant.dart';
import '../../../../shared/utils/no_space_formatter.dart';
import '../../../../shared/utils/regex.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/widgets/button.dart';
import '../../../../shared/widgets/custom_image_view.dart';
import '../../../../shared/widgets/custom_outlined_button.dart';
import '../../../../shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import '../../../../shared/widgets/icon_button_custom.dart';
import '../../../../shared/widgets/input_field.dart';
import '../../../../theme/theme_helper.dart';
import '../../auth_controller.dart';

class LoginForm extends GetView<AuthController> {
  final AppController appController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            CommonConstants.btnSignIn.tr,
            style: CommonConstants.kTitleTextStyle,
          ),
          const SizedBox(height: CommonConstants.defaultPadding / 0.5),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 4),
            child: customAlign(child: Text("EmailOrPhoneNumber".tr)),
          ),
          InputField(
            keyboardType: TextInputType.text,
            prefixIcon: Icons.mail_outline_rounded,
            isBorder: true,
            controller: controller.loginPhoneNoController,
            hintText: CommonConstants.enterYourPhone.tr,
            inputFormatters: [NoSpaceLowerCaseFormatter()],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return CommonConstants.enterYourPhone.tr;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 4),
            child: customAlign(child: Text("password".tr)),
          ),

          Obx(
            () => InputField(
              controller: controller.loginPasswordController,
              hintText: CommonConstants.enterYourPassword.tr,
              suffixIcon: IconButtonCustom(
                onPressed:
                    () => controller.togglePasswordVisibility(
                      controller.isPasswordVisible,
                    ),
                child: Padding(
                  padding: getPadding(all: 8),
                  child: SvgPicture.asset(
                    controller.isPasswordVisible.value
                        ? ImageConstant.imgHiddenPassWord
                        : ImageConstant.icShowPassWord,
                    color: appTheme.gray500,
                  ),
                ),
              ),
              icon: ImageConstant.iconPassword,
              obscureText: controller.isPasswordVisible.value,
              focusNode: controller.passwordFocus,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return CommonConstants.passwordIsRequired.tr;
                }
                if (!Regex.isPasswordAtLeast6Characters(value)) {
                  return CommonConstants.textErrorPassword.tr;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: CommonConstants.defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("forgotYourPassword".tr),
              TextButton(
                child: Text(
                  "clickForgotPass".tr,
                  style: CommonConstants.kSecondaryTextStyle.copyWith(
                    color:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.kPrimaryColor8
                            : ColorConstants.kPrimaryColor5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () => Get.toNamed(Routes.SIGN_UP),
              ),
            ],
          ),
          // Padding(
          //   padding: getPadding(top: 18),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: TextButton(
          //       onPressed: () {
          //         controller.loginPhoneNoController.clear();
          //         controller.loginPasswordController.clear();
          //       },
          //       child: Text(
          //         CommonConstants.forgotPasswordInLogin.tr,
          //         style: CustomTextStyles.lableForgotPasswordBlack500,
          //       ),
          //     ),
          //   ),
          // ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets.primaryButton(
                text: CommonConstants.confirm.tr,
                onPressed: () => controller.login(context, _formKey),
              ),
              const SizedBox(height: 20),
              CustomOutlinedButton(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : null,
                ),
                height: CommonConstants.height45,
                leftIcon: CustomImageView(
                  margin: const EdgeInsets.only(
                    right: CommonConstants.smallPadding,
                  ),
                  svgPath: ImageConstant.iconGoogle,
                  height: getSize(25),
                  width: getSize(25),
                ),
                text: "signInWithGoogle".tr,
                buttonTextStyle: const TextStyle(
                  color: ColorConstants.kPrimaryColor6,
                ),
                onTap: () {
                  controller.signInWithGoogle();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("donHaveAnAcount".tr, textAlign: TextAlign.center),
                  TextButton(
                    child: Text(
                      CommonConstants.btnSignUp.tr,
                      style: CommonConstants.kSecondaryTextStyle.copyWith(
                        color:
                            Get.find<AppController>().isDarkModeOn.value
                                ? ColorConstants.kPrimaryColor8
                                : ColorConstants.kPrimaryColor5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () => Get.toNamed(Routes.SIGN_UP),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.1),

          // SocialSignUp(),
        ],
      ),
    );
  }
}
