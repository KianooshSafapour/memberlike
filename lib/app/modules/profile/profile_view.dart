import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/app/modules/profile/profile.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/utils/no_space_formatter.dart';
import 'package:memberlike/shared/widgets/custom_bottomsheet.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import 'package:memberlike/shared/widgets/modal_sheet_widget.dart';
//import 'package:restart_app/restart_app.dart';

import '../../../app_controller.dart';
import '../../../core/routes/app_pages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/custom_radio_button.dart';
import '../../../shared/widgets/input_field.dart';
import '../language/lang_controller.dart';
import 'components/profile_card.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "profile".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: CommonConstants.smallPadding),
          onTap: () => Get.toNamed(Routes.NOTIFICATION),
          child: CustomImageView(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : null,
            svgPath: ImageConstant.iconNotification,
            height: 25,
            width: 25,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: CommonConstants.smallPadding),
                ProfileCard(controller: controller),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      menuListTile(
                        svgPath: ImageConstant.iconBottomProfile,
                        title: "manageAccount".tr,
                        onTap: () async {
                          bool ok = await controller.syncUserInfo();

                          ok
                              ? CustomBottomSheet2.show(
                                context,
                                SizedBox(
                                  height: Get.height,
                                  width: Get.width,
                                  // color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      CommonConstants.mediumPadding,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          customAlign(
                                            child: CustomImageView(
                                              svgPath: ImageConstant.iconClose,
                                              onTap: () => Get.back(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height:
                                                CommonConstants.defaultPadding,
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top:
                                                            CommonConstants
                                                                .mediumPadding,
                                                        bottom: 4,
                                                      ),
                                                  child: customAlign(
                                                    child: Text(
                                                      "firstName".tr,
                                                      style:
                                                          CommonConstants
                                                              .kSecondaryTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                InputField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  isBorder: true,
                                                  controller:
                                                      controller
                                                          .registerFirstNameController,
                                                  hintText: "firstName".tr,
                                                  inputFormatters: [
                                                    NoSpaceLowerCaseFormatter(),
                                                  ],
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return CommonConstants
                                                          .enterYourPhone
                                                          .tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top:
                                                            CommonConstants
                                                                .mediumPadding,
                                                        bottom: 4,
                                                      ),
                                                  child: customAlign(
                                                    child: Text(
                                                      "lastName".tr,
                                                      style:
                                                          CommonConstants
                                                              .kSecondaryTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                InputField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  isBorder: true,
                                                  controller:
                                                      controller
                                                          .registerLastNameController,
                                                  hintText: "lastName".tr,
                                                  inputFormatters: [
                                                    NoSpaceLowerCaseFormatter(),
                                                  ],
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return CommonConstants
                                                          .enterYourPhone
                                                          .tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top:
                                                            CommonConstants
                                                                .mediumPadding,
                                                        bottom: 4,
                                                      ),
                                                  child: customAlign(
                                                    child: Text(
                                                      "phoneNumberyou".tr,
                                                      style:
                                                          CommonConstants
                                                              .kSecondaryTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                InputField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  isBorder: true,
                                                  controller:
                                                      controller
                                                          .loginPhoneNoController,
                                                  hintText: "phoneNumberyou".tr,
                                                  inputFormatters: [
                                                    NoSpaceLowerCaseFormatter(),
                                                  ],
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "enterYourPhoneNumber"
                                                          .tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: Get.height * .1,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child:
                                                      CommonWidgets.primaryButton(
                                                        text: "doned".tr,
                                                        onPressed: () {
                                                          controller
                                                              .updateUserInfo();
                                                          Get.back();
                                                        },
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              : null;
                        },
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconSun,
                        title: "lightMode".tr,
                        onTap: () {},
                        customTrailing: Obx(() {
                          return CupertinoSwitch(
                            activeTrackColor: ColorConstants.kPrimaryColor6,
                            value: Get.find<AppController>().isDarkModeOn.value,
                            onChanged: (value) {
                              // Get.find<AppController>().isDarkModeOn.value =
                              //     value;
                              Get.find<AppController>().toggleDarkMode();
                            },
                          );
                        }),
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconGlobal,
                        title: "language".tr,
                        customTrailing: SizedBox(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomImageView(
                                svgPath:
                                    Get.find<LangController>()
                                                .selectedLanguage
                                                .code ==
                                            'fa'
                                        ? ImageConstant.iconPersian
                                        : Get.find<LangController>()
                                                .selectedLanguage
                                                .code ==
                                            'en'
                                        ? ImageConstant.iconEnglish
                                        : ImageConstant.iconArabic,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                color:
                                    Get.find<AppController>().isDarkModeOn.value
                                        ? ColorConstants.white
                                        : ColorConstants.kPrimaryColor6,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          CustomBottomSheet.show(
                            context,
                            Obx(() {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                color:
                                    Get.find<AppController>().isDarkModeOn.value
                                        ? ColorConstants.kPrimaryColor
                                        : Colors.white,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 40),
                                    CustomRadioButton(
                                      hasCustomColor: true,
                                      imagePath: ImageConstant.iconEnglish,
                                      value: 'english'.tr,
                                      groupValue:
                                          Get.find<LangController>()
                                              .selectedValue
                                              .value,
                                      onChanged: (value) {
                                        Get.find<LangController>()
                                            .selectedValue
                                            .value = value!;
                                      },
                                    ),
                                    CustomRadioButton(
                                      hasCustomColor: true,
                                      imagePath: ImageConstant.iconPersian,
                                      value: 'persian'.tr,
                                      groupValue:
                                          Get.find<LangController>()
                                              .selectedValue
                                              .value,
                                      onChanged: (value) {
                                        Get.find<LangController>()
                                            .selectedValue
                                            .value = value!;
                                      },
                                    ),
                                    // CustomRadioButton(
                                    //   hasCustomColor: true,
                                    //   imagePath: ImageConstant.iconArabic,
                                    //   value: 'arabic'.tr,
                                    //   groupValue: Get.find<LangController>()
                                    //       .selectedValue
                                    //       .value,
                                    //   onChanged: (value) {
                                    //     Get.find<LangController>()
                                    //         .selectedValue
                                    //         .value = value!;
                                    //   },
                                    // ),
                                    const Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: Get.height * 0.1,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            CommonConstants.defaultPadding,
                                      ),
                                      child: CommonWidgets.primaryButton(
                                        text: CommonConstants.confirm.tr,
                                        onPressed: () {
                                          if (Get.find<LangController>()
                                                  .selectedValue
                                                  .value ==
                                              'english'.tr) {
                                            Get.find<LangController>()
                                                .handleLanguageSelection(
                                                  Get.find<LangController>()
                                                      .langs[0],
                                                );
                                          } else if (Get.find<LangController>()
                                                  .selectedValue
                                                  .value ==
                                              "persian".tr) {
                                            Get.find<LangController>()
                                                .handleLanguageSelection(
                                                  Get.find<LangController>()
                                                      .langs[1],
                                                );
                                          } else if (Get.find<LangController>()
                                                  .selectedValue
                                                  .value ==
                                              "arabic".tr) {
                                            Get.find<LangController>()
                                                .handleLanguageSelection(
                                                  Get.find<LangController>()
                                                      .langs[2],
                                                );
                                          }
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            0.45,
                          );
                        },
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconDanger,
                        title: "ourTerms".tr,
                        onTap: () {
                          Get.toNamed(Routes.OURTERMS);
                        },
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconMessageQuestion,
                        title: "faqs".tr,
                        onTap: () {
                          Get.toNamed(Routes.FAQ);
                        },
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconpeople,
                        title: "aboutUs".tr,
                        onTap: () {
                          Get.toNamed(Routes.ABOUTUS);
                        },
                      ),
                      menuListTile(
                        svgPath: ImageConstant.iconSignpost,
                        title: "help".tr,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: CustomImageView(
                          svgPath: ImageConstant.iconLogout,
                          height: 28,
                          width: 28,
                        ),
                        title: Text(
                          "logout".tr,
                          style: CommonConstants.kSecondaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                                Get.find<AppController>().isDarkModeOn.value
                                    ? ColorConstants.white
                                    : ColorConstants.kSecondColor3,
                          ),
                        ),
                        onTap: () {
                          final box = GetStorage();
                          box.erase();
                          Get.offAllNamed(Routes.SPLASH);
                          //  Restart.restartApp();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class menuListTile extends StatelessWidget {
  final String? svgPath;
  final String title;
  final Widget? customTrailing;
  final bool hasUnderLine;

  final VoidCallback? onTap;
  const menuListTile({
    super.key,
    this.svgPath,
    required this.title,
    this.onTap,
    this.customTrailing,
    this.hasUnderLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        svgPath == null
            ? ListTile(
              contentPadding: const EdgeInsets.only(right: 25, left: 25),
              title: Text(
                title,
                style: CommonConstants.kSecondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.kSecondColor3,
                ),
              ),
              onTap: onTap,
              trailing:
                  customTrailing ??
                  Icon(
                    Icons.arrow_forward_ios,
                    color:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.kPrimaryColor6,
                    size: 18,
                  ),
            )
            : ListTile(
              leading: CustomImageView(
                color:
                    Get.find<AppController>().isDarkModeOn.value
                        ? ColorConstants.white
                        : null,
                svgPath: svgPath,
                height: svgPath == "" ? 0 : 28,
                width: svgPath == "" ? 0 : 28,
              ),
              title: Text(
                title,
                style: CommonConstants.kSecondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.kSecondColor3,
                ),
              ),
              onTap: onTap,
              trailing:
                  customTrailing ??
                  Icon(
                    Icons.arrow_forward_ios,
                    color:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.kPrimaryColor6,
                    size: 18,
                  ),
            ),
        hasUnderLine
            ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 1.5,
              color: ColorConstants.kSecondColor10,
              width: Get.width,
            )
            : Container(),
      ],
    );
  }
}
