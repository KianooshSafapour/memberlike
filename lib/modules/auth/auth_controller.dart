import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../api/api_repository.dart';
import '../../models/request/auth_request/login_request/login_request.dart';
import '../../models/request/auth_request/register_request.dart';
import '../../routes/app_pages.dart';
import '../../shared/utils/focus.dart';
import '../../shared/utils/regex.dart';
import '../../shared/widgets/common_widget.dart';
import '../../shared/widgets/custom_snackbar_widget.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  final prefs = Get.find<SharedPreferences>();
  final logger = Logger();
  final box = GetStorage();
  int? type;
  Rx validate = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isEmailEntered = false.obs;
  RxBool isEmail = false.obs;
  RxBool isPhoneNumber = false.obs;
  RxBool isAgree = false.obs;

  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController loginPhoneNoController = TextEditingController();

  final loginPhoneNoControllerCode = TextEditingController();
  final loginPasswordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  void hideKeyboard() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  bool isEmailRegrex(String input) {
    return Regex.isEmail(input);
  }

  void togglePasswordVisibility(RxBool isVisible) =>
      isVisible.value = !isVisible.value;
  bool registerValidate() {
    if (registerFirstNameController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourName".tr);

      return false;
    }
    if (registerLastNameController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourLastName".tr);
      return false;
    }
    if (registerEmailController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourEmail".tr);
      return false;
    }
    if (registerPasswordController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourPassword".tr);
      return false;
    }
    if (!Regex.isEmail(registerEmailController.text)) {
      CommonWidget.toast("pleaseEnterValidEmail".tr);
      return false;
    }
    if (!Regex.isPasswordAtLeast6Characters(registerPasswordController.text)) {
      CommonWidget.toast("passwordShouldBeAtLeast6Characters".tr);
      return false;
    }
    if (!isAgree.value) {
      CommonWidget.toast("pleaseAcceptTermsAndConditions".tr);
      return false;
    }
    return true;
  }

  bool loginValidate() {
    if (loginPhoneNoController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourPhone".tr);
      return false;
    }
    if (loginPasswordController.text.isEmpty) {
      CommonWidget.toast("pleaseEnterYourPassword".tr);
      return false;
    }
    return true;
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        clientId:
            "378380236051-3ifjuu1kpaupilrlo6vo99l6in4kh4vj.apps.googleusercontent.com",
      );

      GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;

        // Get the ID Token
        final String? idToken = auth.idToken;
        logger.d(idToken);
        // Prepare the POST request body
        final body = {'id_token': idToken};

        // Make the POST request to the backend
        final response = await apiRepository.loginWithGoogle(body);

        if (response != null) {
          // final responseData = response.data;
          box.write("token", response.data["token"]);
          box.write("userId", response.data["user_id"]);
          logger.d(response.data["token"]);

          box.write("expires_at", response.data["expires_at"]);
          Get.toNamed(Routes.SPLASH);
          // Handle the successful response
        } else {
          // Handle the error response

          showDarkSnackbar("Sign-InFailed".tr, "FaildToLogin".tr);
        }
      }
    } catch (error) {
      showDarkSnackbar("Sign-In Failed", "$error");
    }
  }

  void login(BuildContext context, GlobalKey<FormState> formKey) async {
    AppFocus.unfocus(context);
    var isValid = formKey.currentState!.validate();

    if (loginValidate() && isValid) {
      final res = await apiRepository.login(
        LoginRequest(
          email: loginPhoneNoController.text,
          password: loginPasswordController.text,
        ),
      );

      if (res != null) {
        box.write("token", res.data["token"]);
        box.write("userId", res.data["user_id"]);
        logger.d(res.data["token"]);
        box.write("expires_at", res.data["expires_at"]);
        Get.toNamed(Routes.SPLASH);
      }
    }
  }

  void register(GlobalKey<FormState> formKey) async {
    if (registerValidate()) {
      RegisterRequest data = RegisterRequest(
        email: registerEmailController.text,
        first_name: registerFirstNameController.text,
        last_name: registerLastNameController.text,
        password: registerPasswordController.text,
      );
      final res = await apiRepository.register(data);
      if (res != null) {
        box.write("userId", res.data["user_id"]);
        showDarkSnackbar("success".tr, res.message);
      }
    }
  }
}
