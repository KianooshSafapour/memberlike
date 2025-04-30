import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../app_controller.dart';
import '../../../../shared/constants/image_constant.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/utils/date_time_utils.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../../../../shared/widgets/service_title_widget.dart';
import '../../language/lang_controller.dart';
import '../ticket_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController textController = TextEditingController();
  final TicketController controller = Get.find<TicketController>();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    controller.messages.clear();
    // Initial call to getMessages
    controller.getMessages();
    // Start a timer to call getMessages every second
    controller.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      logger.d("called");
      controller.getMessages();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    controller.timer?.cancel();
    textController.dispose(); // Dispose of the text controller
    controller.messages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 160,
        leading: CustomIconButton(
          height: 35,
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kSecondColor5,
            size: 20,
          ),
        ),
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        title: Text(
          controller.selectedTicket.value!.subject,
          overflow: TextOverflow.ellipsis,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Column(
            children: [
              Container(height: 1, color: ColorConstants.kSecondColor10),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    ServiceTitle(
                      title: controller.selectedTicket.value!.description,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            child: IconTitleItem(
                              onTap: () {},
                              title:
                                  Get.find<LangController>().currentLang() ==
                                          "fa"
                                      ? DateTimeUtils.convertToJalali(
                                        controller
                                                .selectedTicket
                                                .value!
                                                .changed ??
                                            DateTime.now().toString(),
                                      )
                                      : controller
                                              .selectedTicket
                                              .value!
                                              .changed ??
                                          "",
                              icon: ImageConstant.iconCalendar,
                            ),
                          ),
                          Container(
                            height: 22,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.kSecondColor9,
                              ),
                              borderRadius: BorderRadius.circular(
                                CommonConstants.smallRadius,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  controller.selectedTicket.value!.status != ""
                                      ? controller.selectedTicket.value!.status
                                      : "open".tr,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection:
                          Get.find<LangController>().isRtl()
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      child: BubbleSpecialThree(
                        constraints: BoxConstraints(
                          minWidth: 80,
                          maxWidth: Get.width * 0.75,
                        ),
                        text: controller.messages[index].message,
                        isSender: controller.messages[index].support == 0,
                        color:
                            controller.messages[index].support == 1
                                ? ColorConstants.kSecondColor8
                                : ColorConstants.kPrimaryColor6,
                        tail: true,
                        delivered: true,
                        textStyle: const TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                    // return ListTile(
                    //   title: Text(controller.messages[index].message),
                    // );
                  },
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection:
                      Get.find<LangController>().isRtl()
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: ColorConstants.kSecondColor10,
                          borderRadius: BorderRadius.circular(
                            CommonConstants.mediumRadius,
                          ),
                        ),
                        child: TextField(
                          textAlign:
                              Get.find<LangController>().isRtl()
                                  ? TextAlign.right
                                  : TextAlign.left,
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'typeMessage'.tr,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          Get.find<LangController>().isRtl()
                              ? const EdgeInsets.only(right: 2)
                              : const EdgeInsets.only(left: 2),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          CommonConstants.mediumRadius,
                        ),
                        color: ColorConstants.kPrimaryColor5,
                      ),
                      child: IconButton(
                        icon: Transform.rotate(
                          angle: 0,
                          child: const Icon(Icons.send, color: Colors.white),
                        ),
                        onPressed: () {
                          !controller.isSending.value
                              ? controller.sendMessage()
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleSpecialThree extends StatelessWidget {
  final bool isSender;
  final String text;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final BoxConstraints? constraints;

  const BubbleSpecialThree({
    super.key,
    this.isSender = true,
    this.constraints,
    required this.text,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(color: Colors.black87, fontSize: 16),
  });

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(Icons.done, size: 18, color: Color(0xFF97AD8E));
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: CustomPaint(
          painter: _SpecialChatBubbleThree(
            color: color,
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            tail: tail,
          ),
          child: Container(
            constraints:
                constraints ??
                BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7,
                ),
            margin:
                isSender
                    ? stateTick
                        ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                        : const EdgeInsets.fromLTRB(7, 7, 17, 7)
                    : const EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding:
                      stateTick
                          ? const EdgeInsets.only(left: 4, right: 0)
                          : const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    text,
                    style: textStyle,
                    textAlign:
                        Get.find<LangController>().isRtl()
                            ? TextAlign.right
                            : TextAlign.left,
                  ),
                ),
                stateIcon != null && stateTick
                    ? Get.find<LangController>().isRtl()
                        ? Positioned(bottom: 0, left: 0, child: stateIcon)
                        : Positioned(bottom: 0, right: 0, child: stateIcon)
                    : const SizedBox(width: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///custom painter use to create the shape of the chat bubble
///
/// [color],[alignment] and [tail] can be changed

class _SpecialChatBubbleThree extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  _SpecialChatBubbleThree({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
          w - _radius * 1.5,
          h,
          w - _radius * 1.5,
          h - _radius * 0.6,
        );

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
          w - _radius * 0.8,
          h,
          w - _radius,
          h - _radius * 1.5,
        );

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
          RRect.fromLTRBR(0, 0, w, h, Radius.zero),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
          RRect.fromLTRBR(0, 0, w, h, Radius.zero),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
      }
    } else {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);
        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
          _radius * 1,
          h,
          _radius * 1.5,
          h - _radius * 0.6,
        );

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
          RRect.fromLTRBR(0, 0, w, h, Radius.zero),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
          RRect.fromLTRBR(0, 0, w, h, Radius.zero),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
