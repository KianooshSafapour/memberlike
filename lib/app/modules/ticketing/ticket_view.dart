import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:memberlike/app/modules/language/lang_controller.dart';
import 'package:memberlike/app/modules/ticketing/components/chat_view.dart';
import 'package:memberlike/app/modules/ticketing/ticket_controller.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/widgets/button.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import 'package:memberlike/shared/widgets/service_title_widget.dart';

import '../../../app_controller.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/custom_bottomsheet.dart';
import '../../../shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import '../../../shared/widgets/input_field.dart';
import 'components/ticket_page.dart';

class TicketView extends GetView<TicketController> {
  TicketView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : ColorConstants.white,
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        title: Text(
          "tickets".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: Get.width,
        margin: const EdgeInsets.only(
          bottom: 5,
          left: CommonConstants.defaultPadding,
          right: CommonConstants.defaultPadding,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          child: Center(
            child: CommonWidgets.primaryButton(
              text: "openNewTicket".tr,
              onPressed: () {
                CustomBottomSheet2.show(
                  context,
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        CommonConstants.mediumPadding,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection:
                                  Get.find<LangController>().currentLang() ==
                                          "en"
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              children: [
                                ServiceTitle(title: "openNewTicket".tr),
                                customAlign(
                                  child: CustomImageView(
                                    svgPath: ImageConstant.iconClose,
                                    color:
                                        Get.find<AppController>()
                                                .isDarkModeOn
                                                .value
                                            ? Colors.white
                                            : null,
                                    onTap: () => Get.back(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: CommonConstants.defaultPadding,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: CommonConstants.mediumPadding,
                                      bottom: 4,
                                    ),
                                    child: customAlign(
                                      child: Text(
                                        "title".tr,
                                        style: CommonConstants
                                            .kSecondaryTextStyle
                                            .copyWith(
                                              color:
                                                  Get.find<AppController>()
                                                          .isDarkModeOn
                                                          .value
                                                      ? Colors.white
                                                      : null,
                                            ),
                                      ),
                                    ),
                                  ),
                                  InputField(
                                    keyboardType: TextInputType.text,
                                    isBorder: true,
                                    controller: controller.titleController,
                                    hintText: "putTitle".tr,
                                    inputFormatters: [],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return CommonConstants
                                            .enterYourPhone
                                            .tr;
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
                                        "description".tr,
                                        style: CommonConstants
                                            .kSecondaryTextStyle
                                            .copyWith(
                                              color:
                                                  Get.find<AppController>()
                                                          .isDarkModeOn
                                                          .value
                                                      ? Colors.white
                                                      : null,
                                            ),
                                      ),
                                    ),
                                  ),
                                  InputField(
                                    height: 200,
                                    minLine: 5,
                                    maxLine: 5,
                                    keyboardType: TextInputType.text,
                                    isBorder: true,
                                    controller:
                                        controller.desctiptionController,
                                    hintText: "putDescription".tr,
                                    inputFormatters: [],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "enterDesceription".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CommonWidgets.primaryButton(
                                      text: "send".tr,
                                      onPressed: () async {
                                        EasyLoading.show();
                                        String? res =
                                            await controller.createTicket();
                                        if (res != null) {
                                          Get.back();
                                          controller.selectedTicket.value =
                                              controller.tickets
                                                  .where(
                                                    (element) =>
                                                        element.id.toString() ==
                                                        res,
                                                  )
                                                  .toList()[0];
                                          final messageResult = await controller
                                              .sendFirstMessage(
                                                controller
                                                    .selectedTicket
                                                    .value!
                                                    .description,
                                              );
                                          if (messageResult == true) {
                                            Get.to(() => ChatView());
                                          } else {
                                            EasyLoading.dismiss();
                                          }
                                        } else {
                                          EasyLoading.dismiss();
                                        }
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
                );
              },
            ),
          ),
        ),
      ),
      body: const TicketPage(),
    );
  }
}
