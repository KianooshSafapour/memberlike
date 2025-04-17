import 'package:flutter/material.dart';

import 'custom_image_view.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage({
    super.key,
    this.height,
    this.width,
    this.imagePath,
    this.svgPath,
    this.margin,
    this.onTap,
    this.iconColor,
  });

  double? height;

  double? width;

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: height,
          width: width,
          fit: BoxFit.contain,
          color: iconColor,
        ),
      ),
    );
  }
}
