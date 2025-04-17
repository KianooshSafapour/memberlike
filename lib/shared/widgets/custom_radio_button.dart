import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/colors.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';

import '../../app_controller.dart';
import '../constants/common.dart';
import 'directinality_handler_widgets/custom_directionality.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final String? imagePath;
  final double? padding;
  final ValueChanged<String?> onChanged;
  final FontWeight? fontWeight;
  final bool hasCustomColor;
  final double? fontSize;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.hasCustomColor = false,
    this.imagePath,
    this.padding,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: customAlign(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: padding ?? 16.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              customAlign(
                child: Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    fillColor:
                        value != groupValue
                            ? WidgetStatePropertyAll<Color>(
                              Get.find<AppController>().isDarkModeOn.value
                                  ? ColorConstants.white
                                  : ColorConstants.kSecondColor9,
                            )
                            : WidgetStatePropertyAll<Color>(
                              Get.find<AppController>().isDarkModeOn.value
                                  ? ColorConstants.white
                                  : ColorConstants.kPrimaryColor4,
                            ),
                    activeColor:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants
                                .kPrimaryColor4, // Hide default radio color
                  ),
                ),
              ),
              imagePath != null
                  ? CustomImageView(
                    color:
                        hasCustomColor
                            ? null
                            : Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : null,
                    margin: const EdgeInsets.only(right: 10.0),
                    svgPath: imagePath,
                    width: 30.0,
                  )
                  : Container(),
              const SizedBox(width: 5),
              Text(
                value,
                style: TextStyle(
                  color:
                      groupValue == value
                          ? Get.find<AppController>().isDarkModeOn.value
                              ? ColorConstants.white
                              : ColorConstants.kPrimaryColor4
                          : Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.black,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontSize: fontSize ?? CommonConstants.mediumText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
