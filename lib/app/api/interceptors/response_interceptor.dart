import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:memberlike/core/routes/app_pages.dart';

FutureOr<dynamic> responseInterceptor(
  Request request,
  Response response,
) async {
  await EasyLoading.dismiss();
  handleResponseStatus(response, request);
  return response;
}

void handleResponseStatus(Response response, Request request) async {
  final finalValue = jsonDecode(response.bodyString!);
  switch (response.statusCode) {
    case 200:
      if (finalValue["status"] == "success") {
        return;
      }
      return;

    case 401:
      Get.toNamed(Routes.LANGUAGE);
      break;

    default:
      await EasyLoading.dismiss();
      break;
  }
  return;
}
