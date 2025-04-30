import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/models/response/notificaiton_response.dart';
import 'package:memberlike/shared/utils/launch_url.dart';
import '../../../../app_controller.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/constants/image_constant.dart';
import '../../../../shared/widgets/icon_title_item.dart';

class NotificationCard extends StatelessWidget {
  final NotificationResponse notificaiton;
  const NotificationCard({required this.notificaiton, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchTheUrl(notificaiton.btn_link ?? "");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: CommonConstants.defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: ColorConstants.kSecondColor10),
          borderRadius: const BorderRadius.all(
            Radius.circular(CommonConstants.mediumRadius),
          ),
        ),
        height: 70,
        width: Get.width,
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            dense: false,
            horizontalTitleGap: 0,
            title: Text(
              notificaiton.description ?? "",
              style: CommonConstants.kSecondaryTextStyle.copyWith(
                color:
                    Get.find<AppController>().isDarkModeOn.value
                        ? ColorConstants.white
                        : null,
              ),
            ),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: IconTitleItem(
                    onTap: () {},
                    title: notificaiton.created ?? "",
                    icon: ImageConstant.iconCalendar,
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: IconTitleItem(
                    onTap: () {},
                    title: notificaiton.created ?? "",
                    icon: ImageConstant.iconClock,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              alignment: const Alignment(0, -0.2),
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color:
                    Get.find<AppController>().isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.kPrimaryColor5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
