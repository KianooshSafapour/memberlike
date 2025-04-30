import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/common.dart';

import '../notification_controller.dart';
import 'notification_card.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CommonConstants.defaultPadding),
      child: SizedBox(
        child: Obx(() {
          return controller.notifications.isEmpty
              ? Center(
                child: Text(
                  'noNotification'.tr,
                  style: const TextStyle(fontSize: 19, color: Colors.black),
                ),
              )
              : ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  return NotificationCard(
                    notificaiton: controller.notifications[index],
                  );
                },
              );
        }),
      ),
    );
  }
}
