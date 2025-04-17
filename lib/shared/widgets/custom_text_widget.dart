import 'package:flutter/material.dart';

class CustomTextStyle {
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;

  const CustomTextStyle({
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontFamily: fontFamily ?? 'Yekan',
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.textStyle});

  final String text;
  final CustomTextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle?.textStyle ?? const CustomTextStyle().textStyle,
    );
  }
}
