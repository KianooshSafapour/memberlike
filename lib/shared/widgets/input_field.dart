// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import '../../theme/theme_helper.dart';
import '../constants/colors.dart';
import '../constants/common.dart';
import '../utils/size_utils.dart';
import 'custom_text_style.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    this.height,
    required this.hintText,
    this.prefixIcon,
    this.icon,
    this.leadingIconColor,
    this.obscureText = false,
    this.enableTexfield = true,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
    this.focusNode,
    this.isBorder,
    this.validator,
    this.iconButton,
    this.suffixIcon,
    this.initValue,
    this.inputFormatters,
    this.onChanged,
    this.digitsOnly = false,
    this.paddingIcon,
    this.checkBackgroundColorTextfield = false,
    this.maxLine,
    this.minLine,
  });

  final String hintText;
  final String? icon;
  final IconData? prefixIcon;
  final bool obscureText;
  final bool? enableTexfield;
  final bool? isBorder;
  final Color? leadingIconColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final IconButton? iconButton;
  final Widget? suffixIcon;
  final String? initValue;
  final void Function(String)? onChanged;
  final bool digitsOnly;
  final double? paddingIcon;
  bool validate = false;
  bool checkBackgroundColorTextfield;
  final double? height;
  int? minLine;
  int? maxLine;
  List<TextInputFormatter>? inputFormatters;

  final void Function(String?)? onSaved;

  PrimaryColors get appTheme => ThemeHelper().themeColor();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        onChanged: onChanged,
        minLines: minLine ?? 1,
        maxLines: maxLine ?? 1,
        inputFormatters: inputFormatters,
        validator: validator,
        keyboardType: digitsOnly ? TextInputType.number : keyboardType,
        textInputAction: textInputAction,
        cursorColor: ColorConstants.kPrimaryColor,
        controller: controller,
        onSaved: onSaved,
        focusNode: focusNode,
        obscureText: obscureText,
        initialValue: initValue,
        style: TextStyle(
          color:
              checkBackgroundColorTextfield == true
                  ? appController.isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.black
                  : ColorConstants.black,
        ),
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 60,
            maxWidth: 60,
          ),
          contentPadding: getPadding(all: 10),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: CustomTextStyles.lableTextInput500,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorConstants.kSecondColor9),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorConstants.kPrimaryColor8),
          ),
          prefixIcon: Padding(
            padding:
                paddingIcon != null
                    ? EdgeInsets.all(paddingIcon!)
                    : const EdgeInsets.all(CommonConstants.mediumPadding + 2),
            child: SizedBox(
              height: getSize(icon != null ? 0 : 20),
              width: getSize(icon != null ? 0 : 20),
              child:
                  prefixIcon != null
                      ? Icon(
                        prefixIcon,
                        color: leadingIconColor ?? ColorConstants.kPrimaryColor,
                        // size: getSize(20),
                      )
                      : icon != null
                      ? SvgPicture.asset(
                        icon!,
                        // height: getSize(20),
                        // width: getSize(20),
                        color: leadingIconColor ?? ColorConstants.kPrimaryColor,
                      )
                      : const SizedBox.shrink(),
            ),
          ),
          border: OutlineInputBorder(
            borderSide:
                isBorder ?? true
                    ? const BorderSide(color: ColorConstants.greenColor)
                    : BorderSide.none,
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          fillColor:
              checkBackgroundColorTextfield == true
                  ? appController.isDarkModeOn.value
                      ? ColorConstants.grey800
                      : ColorConstants.white
                  : ColorConstants.white,
        ),
        enabled: enableTexfield,
      ),
    );
  }
}
