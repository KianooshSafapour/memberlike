import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';


FutureOr<Request> authInterceptor(request) async {
  final box = GetStorage();
  final token =await box.read('token');

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
   request.headers['Authorization'] = 'Bearer $token';

  return request;
}
