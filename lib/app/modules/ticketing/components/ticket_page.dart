import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/ticketing/components/ticket_cart.dart';
import 'package:memberlike/app/modules/ticketing/ticket_controller.dart';

import '../../../../shared/constants/common.dart';

class TicketPage extends GetView<TicketController> {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CommonConstants.defaultPadding),
      child: SizedBox(
        child: Obx(() {
          return controller.tickets.isEmpty
              ? Center(
                child: Text(
                  'noTickets'.tr,
                  style: const TextStyle(
                    fontFamily: "Yekan",
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              )
              : ListView.builder(
                reverse: false,
                itemCount: controller.tickets.length,
                itemBuilder: (context, index) {
                  return index == controller.tickets.length - 1
                      ? Column(
                        children: [
                          TicketCart(
                            controller: controller,
                            ticket: controller.tickets[index],
                          ),
                          const SizedBox(height: 100),
                        ],
                      )
                      : TicketCart(
                        controller: controller,
                        ticket: controller.tickets[index],
                      );
                },
              );
        }),
      ),
    );
  }
}
