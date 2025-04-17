import 'package:flutter/material.dart';
import 'package:memberlike/shared/constants/common.dart';

import '../constants/colors.dart';
import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
    super.onTap,
    super.buttonStyle,
    super.disabledButtonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.alignment,
    super.height,
    super.width,
    super.margin,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: buildOutlinedButtonWidget,
        )
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
    height: height,
    width: width,
    margin: margin,
    decoration: decoration,
    child: OutlinedButton(
      style:
          buttonStyle ??
          OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            overlayColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(CommonConstants.mediumRadius),
              ),
            ),
            side: BorderSide(width: 1.0, color: ColorConstants.kPrimaryColor5),
          ),
      onPressed: isDisabled ?? false ? () {} : onTap ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Text(text, style: buttonTextStyle),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}
