import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import '../../../core/routes/app_pages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/image_constant.dart';
import 'splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    final box = GetStorage();
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      final token = await box.read("token");
      final expiresAt = await box.read("expires_at");
      if (token != null && expiresAt != null) {
        DateTime expiration = DateTime.parse(expiresAt);
        if (expiration.isBefore(DateTime.now())) {
          box.remove("token");
          box.remove("expires_at");
          Get.offAllNamed(Routes.LANGUAGE);
        } else {
          await Get.find<SplashController>().checkMaintenance();
          await Get.find<SplashController>().getGallery();

          //  await Get.find<SplashController>().getUserInfo();
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.offAllNamed(Routes.LANGUAGE); // Navigate to login if token is null
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                width: 170,
                height: 170,
                imagePath: ImageConstant.logo,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "App for selling social network services",
                  style: CommonConstants.kSecondaryTextStyle.copyWith(
                    color: ColorConstants.kPrimaryColor4,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: ColorConstants.kPrimaryColor10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
