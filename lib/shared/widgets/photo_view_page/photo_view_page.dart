import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../app_controller.dart';
import '../../constants/colors.dart';

class PhotoViewPage extends StatelessWidget {
  final List<String> photos;
  final int index;

  const PhotoViewPage({super.key, required this.photos, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        elevation: 0,
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder:
            (context, index) => PhotoViewGalleryPageOptions.customChild(
              child: CachedNetworkImage(
                imageUrl: photos[index],
                placeholder: (context, url) => Container(color: Colors.grey),
                errorWidget:
                    (context, url, error) =>
                        Container(color: Colors.red.shade400),
              ),
              minScale: PhotoViewComputedScale.covered,
              heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
            ),
        pageController: PageController(initialPage: index),
        enableRotation: true,
      ),
    );
  }
}
