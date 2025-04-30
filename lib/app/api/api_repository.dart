import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../models/request/auth_request/login_request/login_request.dart';
import '../models/request/auth_request/register_request.dart';
import '../models/response/base_response.dart';
import '../modules/auth/auth_controller.dart';
import '../../core/routes/app_pages.dart';
import 'api.dart';

class ApiRepository extends GetxService {
  ApiRepository();

  final box = GetStorage();
  final logger = Logger();
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  void _handleResponse(Response response) {
    // Check if status code is 403
    if (response.statusCode == 403) {
      // Navigate to login
      box.erase();
      Get.delete<AuthController>();
      Get.offAllNamed(Routes.LANGUAGE);
    }
  }

  Future<BaseResponse?> login(LoginRequest data) async {
    try {
      final res = await apiProvider.login('/auth/login.php', data);
      _handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();

      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> loginWithGoogle(var data) async {
    try {
      final res = await apiProvider.loginWithGoogle(
        '/auth/register-by-google.php',
        data,
      );
      logger.d(res.body);
      return BaseResponse.fromJson(res.body);
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future confirmPayment(var data) async {
    try {
      final res = await apiProvider.confirmPayment('/pay/verify.php', data);
      var body = await json.decode(res.body);

      if (body["status"] != "error") {
        return body;
      } else {
        Get.snackbar("error".tr, body["message"]);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> register(RegisterRequest data) async {
    try {
      final res = await apiProvider.register('/auth/register.php', data);
      _handleResponse(res);
      if (res.statusCode == 201) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getTopSells() async {
    try {
      final res = await apiProvider.getTopSells('/products/top-sells.php');
      _handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getCategories(name) async {
    try {
      final res = await apiProvider.getCategories(
        '/categories/read.php?name=$name',
      );
      //_handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getServices() async {
    try {
      final res = await apiProvider.getServices('/services/read.php?status=1');
      //_handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> filterServices(String name) async {
    try {
      final res = await apiProvider.getServices(
        '/services/read.php?status=1&?name=$name',
      );
      //_handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> filterCervicesByCatId(int id) async {
    try {
      final res = await apiProvider.getServices(
        '/services/read.php?cat_id=$id',
      );
      //_handleResponse(res);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getGallery() async {
    try {
      final res = await apiProvider.getGallery('/gallery/read.php');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> checkMaintenance() async {
    try {
      final res = await apiProvider.checkMaintenance(
        '/maintenance_mode/read.php',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getFaq() async {
    try {
      final res = await apiProvider.getFaq('/faqs/read.php');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getNotification() async {
    try {
      final res = await apiProvider.getNotification('/general_alerts/read.php');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getUserInfo(String id) async {
    try {
      final res = await apiProvider.getUserInfo(
        '/general_users/read.php?id=$id',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getTransactions(String id) async {
    try {
      final res = await apiProvider.getTransactions(
        '/general_transaction_logs/read.php?uid=$id',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      //await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getTickets(String id) async {
    try {
      final res = await apiProvider.getTickets('/tickets/read.php?uid=$id');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getChats(String id) async {
    try {
      final res = await apiProvider.getChats(
        '/ticket_messages/read.php?ticket_id=$id',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> updateUserInfo(var body) async {
    try {
      final res = await apiProvider.updateUserInfo(
        '/general_users/update.php',
        body,
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> createTicket(var body) async {
    try {
      final res = await apiProvider.createTicket('/tickets/create.php', body);
      if (res.statusCode == 201) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> sendMessage(var body) async {
    try {
      final res = await apiProvider.sendMessage(
        '/ticket_messages/create.php',
        body,
      );
      if (res.statusCode == 201) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> createOrder(var body) async {
    try {
      final res = await apiProvider.sendMessage(
        '/orders/createOrder.php',
        body,
      );
      if (res.statusCode == 201) {
        logger.d(res.body);
        return BaseResponse(
          data: {res.body},
          message: "order created successfuly!",
          status: "success",
        );
      } else {
        // BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, "lowbalance".tr);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getCategory() async {
    try {
      final res = await apiProvider.getCategory('/categories/read.php');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getGeneralOptions() async {
    try {
      final res = await apiProvider.getGeneralOptions(
        '/general_options/read.php',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getMessageById(int id) async {
    try {
      final res = await apiProvider.getGeneralOptions(
        '/ticket_messages/read.php?id=$id',
      );
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getOrders(int id) async {
    try {
      final res = await apiProvider.getOrders('/orders/read.php?uid=$id');
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }

  Future<BaseResponse?> getPaymentLink(var body) async {
    try {
      final res = await apiProvider.getPaymentLink('/d/payment.php', body);
      if (res.statusCode == 200) {
        return BaseResponse.fromJson(res.body);
      } else {
        BaseResponse result = BaseResponse.fromJson(res.body);
        Get.snackbar("error".tr, result.message);
        return null;
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
    return null;
  }
}
