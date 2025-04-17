import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/models/response/ticket_list_response.dart';
import 'package:memberlike/modules/language/lang_controller.dart';
import 'package:memberlike/modules/ticketing/components/chat_view.dart';
import 'package:memberlike/modules/ticketing/ticket_controller.dart';
import 'package:memberlike/shared/utils/date_time_utils.dart';
import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/icon_title_item.dart';

class TicketCart extends StatelessWidget {
  final TicketListItem ticket;
  final TicketController controller;
  const TicketCart({required this.ticket, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedTicket.value = ticket;
        Get.to(() => ChatView());
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
              ticket.subject,
              style: CommonConstants.kSecondaryTextStyle.copyWith(
                color:
                    Get.find<AppController>().isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.kSecondColor3,
              ),
            ),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: IconTitleItem(
                    onTap: () {},
                    title:
                        Get.find<LangController>().currentLang() == "fa"
                            ? DateTimeUtils.convertToJalali(
                              ticket.created ?? DateTime.now().toString(),
                            )
                            : ticket.created ?? "",
                    icon: ImageConstant.iconCalendar,
                  ),
                ),
                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          ticket.status == "answered"
                              ? ColorConstants.greenColor
                              : ColorConstants.kSecondColor9,
                    ),
                    borderRadius: BorderRadius.circular(
                      CommonConstants.smallRadius,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        ticket.status != "" ? ticket.status : "open".tr,
                      ),
                    ),
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

// String TicketStatusConvertor() {
//   return "";
// }
