import 'package:get/get.dart';

import '../shared/utils/app_flavor_helper.dart';
import 'api_constants.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';

class BaseProvider extends GetConnect implements GetxService {
  AppFlavor flavor;
  String? _httpBaseUrl;

  String? get httpBaseUrl => _httpBaseUrl;

  BaseProvider(this.flavor) {
    setupEnvironment(flavor);
  }

  void updateEnvironment(AppFlavor newFlavor) {
    flavor = newFlavor;
    setupEnvironment(newFlavor);
  }

  @override
  void onInit() async {
    setupEnvironment(flavor);
    _httpBaseUrl = httpClient.baseUrl;
    //httpClient.addRequestModifier(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
    httpClient.timeout = const Duration(seconds: 15);

    // httpClient.maxAuthRetries = 3;
  }

  void setupEnvironment(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.development:
        httpClient.baseUrl = ApiConstants.baseUrlDevelopment;
        break;
      case AppFlavor.production:
        httpClient.baseUrl = ApiConstants.baseUrlProduction;
        break;
    }
    _httpBaseUrl = httpClient.baseUrl;
  }
}
