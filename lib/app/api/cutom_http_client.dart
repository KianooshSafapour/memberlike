import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomHttpClient extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    // Initialize GetStorage
    GetStorage.init();
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    await _addAuthHeader(headers ?? {});
    return super.get<T>(
      url,
      contentType: contentType,
      decoder: decoder,
      headers: headers,
      query: query,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic Function(double)? uploadProgress,
  }) async {
    await _addAuthHeader(headers ?? {});
    return super.post<T>(
      url,
      body,
      contentType: contentType,
      decoder: decoder,
      headers: headers,
      query: query,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String? url,
    dynamic body, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic Function(double)? uploadProgress,
  }) async {
    await _addAuthHeader(headers ?? {});
    return super.put<T>(
      url!,
      body,
      contentType: contentType,
      decoder: decoder,
      headers: headers,
      query: query,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String? url, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    await _addAuthHeader(headers ?? {});
    return super.delete<T>(
      url!,
      contentType: contentType,
      decoder: decoder,
      headers: headers,
      query: query,
    );
  }

  Future<void> _addAuthHeader(Map<String, String> headers) async {
    final box = GetStorage();
    final token = await box.read('token');

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    headers['X-Requested-With'] = 'XMLHttpRequest';
  }
}
