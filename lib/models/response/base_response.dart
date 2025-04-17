// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  BaseResponse({
    required this.data,
    required this.message,
    required this.status,
    this.pricedo,
  });

  dynamic data;
  String message;
  String status;
  String? pricedo;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
