import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:memberlike/models/response/service_response.dart';
import 'package:memberlike/modules/main/home_controller.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../api/api_repository.dart';

class CategoryController extends GetxController {
  final ApiRepository apiRepository;
  CategoryController({required this.apiRepository});
  RxString selectedValue = "0".obs;
  RxString prevSelectedValue = "0".obs;
  RxList<ServiceResponse> services = <ServiceResponse>[].obs;
  RxList<ServiceResponse> products = <ServiceResponse>[].obs;
  List<ServiceResponse> allServices = <ServiceResponse>[];
  RxString selectedCatName = "".obs;
  List<ServiceResponse> servicesBackUp = [];
  final int pageSize = 20; // Number of items per page
  int currentPage = 1; // Current page
  bool isLoading = false; // Prevent multiple fetches
  Rxn<ServiceResponse> selectedService = Rxn<ServiceResponse>();
  var dropDownSelected = ''.obs;
  var prevDropDownSelected = ''.obs;
  RxBool isFiltered = false.obs;
  // Reactive range values
  var rangeValues = const SfRangeValues(0.0, 200000).obs;

  // Update range values
  void updateRange(SfRangeValues newRange) {
    rangeValues.value = newRange;
  }

  List<String> extractAtrebiutes(String input) {
    // Regular expression to match the desired patterns
    final RegExp regex = RegExp(r'\[(.*?)\]');

    // Find all matches in the input string
    final matches = regex.allMatches(input);
    // Extract the matched strings, remove the brackets, and return them as a list
    return matches.map((match) => match.group(1)!).toList();
  }

  void getServices() async {
    if (allServices.isEmpty) {
      services.clear();
      await EasyLoading.show(
          status: 'loading...'.tr,
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black);
      var res = await apiRepository.getServices();
      if (res != null) {
        res.data.forEach((element) {
          allServices.add(ServiceResponse.fromJson(element));
          allServices.last.atrebiutes =
              extractAtrebiutes(allServices.last.name);
        });
        servicesBackUp = List.from(allServices);
        loadPaginatedServices();
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } else {
      services.clear();
      loadPaginatedServices();
    }
  }

  void removeFilter() {
    currentPage = 1;
    isFiltered(false);
    selectedValue.value = prevSelectedValue.value = "0";
    allServices = List.from(servicesBackUp);
    services.clear();
    loadPaginatedServices();
  }

  void filterServices() async {
    await EasyLoading.show(
        status: 'loading...'.tr,
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
    try {
      if (prevDropDownSelected.value != dropDownSelected.value ||
          isFiltered.value == false) {
        await filterByCategory();
      }

      await filterByPrice();
      if (selectedValue.value != prevSelectedValue.value) {
        await filterByType();
      }
      isFiltered(true);
      EasyLoading.dismiss();
      if (allServices.length != servicesBackUp.length) {
        services.clear();
        currentPage = 1;
        loadPaginatedServices();
        showDarkSnackbar("success".tr, "filterDone".tr);
      } else {
        showDarkSnackbar("error".tr, "filterFaild".tr);
      }
    } catch (e) {
      await EasyLoading.dismiss();
      showDarkSnackbar("error".tr, "filterFaild".tr);
      allServices = servicesBackUp;
    }
  }

  Future filterByType() async {
    if (selectedValue.value == "0") {
      return;
    }
    allServices = allServices.where(
      (element) {
        return element.name.contains(selectedValue.value);
      },
    ).toList();
  }

  Future filterByPrice() async {
    allServices = allServices.where(
      (element) {
        return double.parse(element.price) >= rangeValues.value.start &&
            double.parse(element.price) <= rangeValues.value.end;
      },
    ).toList();
  }

  Future filterByCategory() async {
    allServices.clear();
    var res = await apiRepository.filterServices(dropDownSelected.value);
    if (res != null) {
      res.data.forEach((element) {
        allServices.add(ServiceResponse.fromJson(element));
        allServices.last.atrebiutes = extractAtrebiutes(allServices.last.name);
      });
    } else {
      allServices = servicesBackUp;
    }
  }

  Future filterProductByCategory() async {
    products.clear();
    await EasyLoading.show(
        status: 'loading...'.tr,
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
    try {
      var res = await apiRepository
          .filterServices(Get.find<HomeController>().selectedCategory.value);
      if (res != null) {
        res.data.forEach((element) {
          products.add(ServiceResponse.fromJson(element));
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      EasyLoading.dismiss();
    }
  }
  Future filterByCatId(int id) async {
    products.clear();
    await EasyLoading.show(
        status: 'loading...'.tr,
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
    try {
      var res = await apiRepository
          .filterCervicesByCatId(id);
      if (res != null) {
        res.data.forEach((element) {
          products.add(ServiceResponse.fromJson(element));
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      EasyLoading.dismiss();
    }
  }

  // Load a chunk of services for the current page
  void loadPaginatedServices() {
    if (isLoading) return; // Prevent multiple requests
    isLoading = true;

    // Calculate start and end indices for pagination
    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = startIndex + pageSize;

    // Add the next chunk of services to the observable list
    if (startIndex < allServices.length) {
      services.addAll(allServices.sublist(
        startIndex,
        endIndex > allServices.length ? allServices.length : endIndex,
      ));
      currentPage++;
    }

    isLoading = false;
  }
}
