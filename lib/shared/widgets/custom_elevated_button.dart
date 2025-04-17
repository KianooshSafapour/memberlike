import 'package:flutter/material.dart';

import '../utils/size_utils.dart';
import '../widgets/custom_button_style.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onTap,
    super.buttonStyle,
    super.alignment,
    super.disabledButtonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: buildElevatedButtonWidget,
        )
        : buildElevatedButtonWidget;
  }

  ButtonStyle? get elevatedButtonStyle =>
      (isDisabled ?? false) ? disabledButtonStyle : buttonStyle;
  Widget get buildElevatedButtonWidget => Container(
    height: height,
    margin: margin,
    width: width,
    decoration:
        decoration ??
        CustomButtonStyles.gradientnameblue900nameblue600Decoration,
    child: ElevatedButton(
      style: elevatedButtonStyle?.copyWith(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onTap ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Padding(
            padding: getPadding(all: 8),
            child: Container(
              alignment: Alignment.center,
              width: getHorizontalSize(140),
              child: Text(
                overflow: TextOverflow.ellipsis,
                text,
                style: buttonTextStyle,
              ),
            ),
          ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}
