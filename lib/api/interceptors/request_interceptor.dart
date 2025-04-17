import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

FutureOr<Request> requestInterceptor(Request request) async {
  final box = GetStorage();
  final token = await box.read('token');

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  request.headers['Authorization'] = 'Bearer $token';

  if (!noLoadingPaths.contains(request.url.path.toLowerCase())) {
    await EasyLoading.show(
        status: 'loading'.tr,
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
  }

  return request;
}

List noLoadingPaths = [
  "/v1/gallery/read.php",
  "/v1/maintenance_mode/read.php",
  "/v1/services/read.php",
  "/v1/general_transaction_logs/read.php",
  "/v1/ticket_messages/create.php",
  "/v1/tickets/create.php",
  "/v1/general_users/read.php",
  "/v1/general_transaction_logs/read.php",
  "/v1/ticket_messages/read.php"
];
