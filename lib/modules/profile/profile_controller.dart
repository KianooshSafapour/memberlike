// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:memberlike/api/api.dart';
import 'package:memberlike/models/response/user_response.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

class ProfileController extends GetxController {
  ProfileController({
    required this.apiRepository,
  });
  Rxn<UserInfoResponse> userInfo = Rxn<UserInfoResponse>();
  final ApiRepository apiRepository;
  RxInt isLoading = 0.obs;
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController loginPhoneNoController = TextEditingController();
  final box = GetStorage();

  getUserInfo() async {
    if (userInfo.value == null) {
      isLoading(1);
      final userId = await box.read("userId");
      final res = await apiRepository.getUserInfo(userId.toString());
      if (res != null) {
        userInfo.value = UserInfoResponse.fromJson(res.data);
        isLoading(0);
      } else {
        //show snack bar
        userInfo.value = null;
        showDarkSnackbar("error".tr, "noInternetError".tr);
        isLoading(2);
      }
    }
  }

  updateUserInfo() async {
    isLoading(1);
    final userId = await box.read("userId");
    final res = await apiRepository.updateUserInfo({
      "id": userId,
      "first_name": registerFirstNameController.text,
      "last_name": registerLastNameController.text,
      "mobile": loginPhoneNoController.text
    });
    if (res != null && res.status == "success") {
      userInfo.value!.first_name = registerFirstNameController.text;
      userInfo.value!.last_name = registerLastNameController.text;
      userInfo.value!.mobile = loginPhoneNoController.text;
      userInfo.refresh();
      isLoading(0);
    } else {
      //show snack bar
      userInfo.value = null;
      showDarkSnackbar("error".tr, "noInternetError".tr);
      isLoading(2);
    }
  }

  syncUserInfo() async {
    try {
      registerFirstNameController.text = userInfo.value!.first_name!;
      registerLastNameController.text = userInfo.value!.last_name!;
      loginPhoneNoController.text = userInfo.value!.mobile!;
      return true;
    } catch (e) {
      return false;
    }
  }
}
