import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_controller.dart';
import '../../constants/colors.dart';
import '../custom_text_style.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  final AppController appController = Get.find();

  AppbarTitle({super.key, required this.text, this.margin, this.onTap});

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: CustomTextStyles.titleMediumBlack900.copyWith(
            color:
                appController.isDarkModeOn.value
                    ? ColorConstants.white
                    : Colors.red,
          ),
        ),
      ),
    );
  }
}
