import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';

import '../../app_controller.dart';
import '../constants/common.dart';

class ServiceTitle extends StatelessWidget {
  final String title;
  final double? horizontalPadding;
  const ServiceTitle({super.key, required this.title, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return customDirectionality(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? CommonConstants.defaultPadding,
        ),
        child: customAlign(
          child: Text(
            title,
            style: CommonConstants.kSecondaryTextStyle.copyWith(
              color:
                  Get.find<AppController>().isDarkModeOn.value
                      ? Colors.white
                      : null,
              fontSize: CommonConstants.mediumText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
