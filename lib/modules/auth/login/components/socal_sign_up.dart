import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../shared/constants/image_constant.dart';
import 'social_icon.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Platform.isIOS;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        if (isIOS) ...[
          SocialIcon(iconSrc: ImageConstant.iconApple, press: () async {}),
          Spacer(),
        ],
        SocialIcon(iconSrc: ImageConstant.iconGoogle, press: () {}),
        Spacer(),
        SocialIcon(iconSrc: ImageConstant.iconZalo, press: () {}),
        Spacer(),
      ],
    );
  }
}
