import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/image_constant.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';

import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';

class MaintanaceScreen extends StatelessWidget {
  const MaintanaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(svgPath: ImageConstant.imageMaintenance),
            const SizedBox(height: 20),
            Text(
              'maintenance'.tr,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
