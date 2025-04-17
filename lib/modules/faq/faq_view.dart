import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/common.dart';
import '../../app_controller.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/custom_icon_button.dart';
import 'faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<AppController>().isDarkModeOn.value
          ? ColorConstants.darkScaffoldBackgroundColor
          : ColorConstants.white,
      appBar: AppBar(
        backgroundColor: Get.find<AppController>().isDarkModeOn.value
            ? ColorConstants.darkScaffoldBackgroundColor
            : ColorConstants.white,
        title: Text('faq'.tr,
        style: CommonConstants.kSecondaryTextStyle.copyWith(
              color: Get.find<AppController>().isDarkModeOn.value
                  ? ColorConstants.white
                  : ColorConstants.kPrimaryColor),),
        centerTitle: true,
        toolbarHeight: 50,
        leading: CustomIconButton(
          height: 35,
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.white
                : ColorConstants.kSecondColor5,
            size: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(
            height: 1,
            color: ColorConstants.kSecondColor10,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return controller.faqItems.isEmpty
                ? Center(
                    child: Text('noFaq'.tr),
                  )
                : Accordion(
                    maxOpenSections:
                        1, // Only one section can be open at a time
                    headerBackgroundColor: Colors.transparent,
                    headerBorderColor: ColorConstants.kSecondColor9,
                    headerBorderWidth: 1,
                    headerPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    children: controller.faqItems.map((faqItem) {
                      return AccordionSection(
                        isOpen: false, // Default state is closed
                        header: Text(
                          faqItem.question!,
                          style: TextStyle(
                            color: Get.find<AppController>().isDarkModeOn.value
                                ? ColorConstants.white
                                : ColorConstants.kSecondColor3,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Html(
                          data: faqItem.answer!,
                        ),
                        rightIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Get.find<AppController>().isDarkModeOn.value
                              ? ColorConstants.white
                              : ColorConstants.kPrimaryColor6,
                        ),
                        contentHorizontalPadding: 15,
                        contentBorderWidth: 1,
                      );
                    }).toList(),
                  );
          })),
    );
  }
}
