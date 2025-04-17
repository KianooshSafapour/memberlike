import 'package:flutter/material.dart';
import 'package:memberlike/shared/constants/colors.dart';
import 'package:memberlike/shared/constants/common.dart';
import '../utils/size_utils.dart';
import 'custom_text_style.dart';

class CommonWidgets {
  static Widget primaryButton(
      {required String text, required VoidCallback onPressed, double? radius}) {
    return SizedBox(
      width: double.infinity,
      height: getSize(50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.kPrimaryColor5,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(radius ?? CommonConstants.mediumRadius),
          ),
        ),
        child: Text(
          text,
          style: CustomTextStyles.bodyMediumWhite,
        ),
      ),
    );
  }
}
