import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/common.dart';

import '../../app_controller.dart';
import '../constants/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final double? height;
  final Widget child;

  const CustomBottomSheet({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16.0), // Set the radius for top corners
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.kPrimaryColor
                : Colors.white, // Background color
        child: child,
      ),
    );
  }

  static void show(BuildContext context, Widget child, double? height) {
    showFlexibleBottomSheet(
      bottomSheetColor:
          Get.find<AppController>().isDarkModeOn.value ? Colors.white : null,
      initHeight: height ?? 0.65,
      bottomSheetBorderRadius: BorderRadius.all(
        Radius.circular(CommonConstants.largeRadius),
      ),
      context: context,
      isCollapsible: true,
      decoration: BoxDecoration(color: Colors.white),
      builder: (context, controller, offset) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CustomBottomSheet(child: child),
        );
      },
    );
  }
}
