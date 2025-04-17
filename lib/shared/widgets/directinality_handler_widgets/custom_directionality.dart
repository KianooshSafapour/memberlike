import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../modules/language/lang_controller.dart';

Directionality customDirectionality({required Widget child}) {
  return Directionality(
      textDirection: Get.find<LangController>().isRtl()
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: child);
}

Align customAlign({required Widget child}) {
  return Align(
    alignment: Get.find<LangController>().isRtl()
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: child,
  );
}
