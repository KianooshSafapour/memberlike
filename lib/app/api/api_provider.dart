import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:typed_data';
import 'package:get/get.dart';

import '../models/request/auth_request/login_request/login_request.dart';
import '../models/request/auth_request/register_request.dart';
import 'base_provider.dart';

class ApiProvider extends BaseProvider {
  ApiProvider(super.flavor);

  static ApiProvider get to => Get.find();

  Future<Response> login(String path, LoginRequest data) =>
      post(path, data.toJson());

  Future<Response> register(String path, RegisterRequest data) async {
    // Convert RegisterRequest to JSON
    final String payload = jsonEncode(data.toJson());

    // Secret key (ensure this is stored securely)
    const String secret = 'WW9VQ2FuJ1RIQGNLbUU=';

    // Calculate HMAC SHA-256 signature
    final Uint8List keyBytes = utf8.encode(secret);
    final Uint8List payloadBytes = utf8.encode(payload);
    final Hmac hmac = Hmac(sha256, keyBytes);
    final Digest digest = hmac.convert(payloadBytes);
    final String calculatedSignature = digest.toString();

    // Create headers
    final headers = {
      'Content-Type': 'application/json',
      'X-Signature': calculatedSignature,
    };

    // Send POST request with payload and headers
    return httpClient.post(path, body: payload, headers: headers);
  }

  Future<Response> loginWithGoogle(String path, var body) {
    final String payload = json.encode(body);

    // Secret key (ensure this is stored securely)
    const String secret = 'WW9VQ2FuJ1RIQGNLbUU=';

    // Calculate HMAC SHA-256 signature
    final Uint8List keyBytes = utf8.encode(secret);
    final Uint8List payloadBytes = utf8.encode(payload);
    final Hmac hmac = Hmac(sha256, keyBytes);
    final Digest digest = hmac.convert(payloadBytes);
    final String calculatedSignature = digest.toString();

    // Create headers
    final headers = {
      'Content-Type': 'application/json',
      'X-Signature': calculatedSignature,
    };
    // var header = {
    //   'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    //   'X-Requested-With': 'XMLHttpRequest',
    //   'Accept': '*/*',
    //   'Accept-Language': 'en-US,en;q=0.5',
    // };
    return post(path, payload, headers: headers);
  }

  Future<Response> getTopSells(String path) => get(path);

  Future<Response> getCategories(String path) => get(path);

  Future<Response> getOrders(String path) => get(path);

  Future<Response> confirmPayment(String path, var body) => post(path, body);

  Future<Response> getServices(String path) => get(path);

  Future<Response> getFaq(String path) => get(path);

  Future<Response> getGallery(String path) => get(path);

  Future<Response> checkMaintenance(String path) => get(path);

  Future<Response> getNotification(String path) => get(path);

  Future<Response> getUserInfo(String path) => get(path);

  Future<Response> updateUserInfo(String path, var body) => post(path, body);

  Future<Response> getCategory(String path) => get(path);

  Future<Response> getGeneralOptions(String path) => get(path);

  Future<Response> getPaymentLink(String path, var body) => post(path, body);

  Future<Response> createOrder(String path, var body) => post(path, body);

  Future<Response> createTicket(String path, var body) => post(path, body);

  Future<Response> sendMessage(String path, var body) => post(path, body);

  Future<Response> getTransactions(String path) => get(path);

  Future<Response> getTickets(String path) => get(path);

  Future<Response> getChats(String path) => get(path);

  Future<Response> getMessageById(String path) => get(path);
}
