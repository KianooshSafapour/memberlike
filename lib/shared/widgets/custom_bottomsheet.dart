import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_controller.dart';
import '../constants/colors.dart';

class CustomBottomSheet2 extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet2({super.key, required this.child});

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

  static void show(BuildContext context, Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
              color:
                  Get.find<AppController>().isDarkModeOn.value
                      ? ColorConstants.kPrimaryColor
                      : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            child: CustomBottomSheet2(child: child),
          ),
        );
      },
    );
  }
}
