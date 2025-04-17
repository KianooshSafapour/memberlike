import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/button.dart';
import '../constants/common.dart';
import 'custom_image_view.dart';

class ProductTileWidget extends StatelessWidget {
  final String title;
  final String imagePth;
  final void Function() onPress;

  const ProductTileWidget({
    super.key,
    required this.title,
    required this.imagePth,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: ListTile(
        leading: CustomImageView(height: 45, width: 45, svgPath: imagePth),
        title: Text(
          title,
          style: CommonConstants.kTitleTextStyle.copyWith(fontSize: 17),
        ),
        trailing: SizedBox(
          height: 35,
          width: 120,
          child: CommonWidgets.primaryButton(
            radius: CommonConstants.mediumPadding,
            text: "choose".tr,
            onPressed: onPress,
          ),
        ),
      ),
    );
  }
}
