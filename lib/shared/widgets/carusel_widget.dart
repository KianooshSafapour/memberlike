import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/splash/splash.dart';
import 'package:memberlike/shared/utils/launch_url.dart';

import '../constants/colors.dart';

class CaruselWidget extends StatelessWidget {
  const CaruselWidget({
    super.key,
    required this.imgList,
    required this.controller,
  });

  final List<SliderImage> imgList;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () => launchTheUrl(imgList[index].url),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imgList[index].image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180,
            aspectRatio: 19 / 9,
            autoPlay: true,
            onPageChanged: (index, reason) {
              controller.setCurrentIndex(index);
            },
            enlargeCenterPage: true,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller.setCurrentIndex(entry.key),
                  child: Obx(
                    () => Container(
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (controller.currentIndex.value == entry.key)
                                ? ColorConstants.kPrimaryColor
                                : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
