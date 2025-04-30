import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/app/models/response/user_response.dart';
import 'package:memberlike/core/routes/app_pages.dart';
import '../../api/api_repository.dart';

class SliderImage {
  final String image;
  final String url;
  const SliderImage({required this.image, required this.url});
}

class SplashController extends GetxController {
  final box = GetStorage();
  final ApiRepository apiRepository;
  SplashController({required this.apiRepository});
  Rxn<UserInfoResponse> userInfo = Rxn<UserInfoResponse>();
  RxList<SliderImage> images = <SliderImage>[].obs;

  Future<void> checkMaintenance() async {
    var res = await apiRepository.checkMaintenance();
    if (res != null) {
      // Map<String, dynamic> parsedJson = json.decode(res);
      List<dynamic> records = res.data;

      // Sort records by created_at in descending order
      records.sort(
        (a, b) => DateTime.parse(
          b['created_at'],
        ).compareTo(DateTime.parse(a['created_at'])),
      );

      // Get the latest record
      var latestRecord = records.first;

      // Get the is_active value
      int isActive = latestRecord['is_active'];
      if (isActive == 1) {
        Get.offAllNamed(Routes.MAINTANACE);
      }
    }
  }

  Future<void> getGallery() async {
    var res = await apiRepository.getGallery();
    if (res != null) {
      images.clear();
      res.data.forEach((element) {
        images.add(
          SliderImage(
            image: "https://memberlike.com/${element["image"]}",
            url: element["link"],
          ),
        );
      });
    }
  }

  // Future getUserInfo() async {
  //   int? id = box.read("user_id");
  //   if (id == null) return;
  //   var res = await apiRepository.getUserInfo(1);
  //   if (res != null) {
  //     userInfo.value = UserInfoResponse.fromJson(res.data);
  //   } else {
  //     showDarkSnackbar("error".tr, "noInternetError".tr);
  //   }
  // }
}
