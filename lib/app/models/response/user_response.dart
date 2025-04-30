// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
part "user_response.g.dart";

@JsonSerializable()
class UserInfoResponse {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? balance;
  String? mobile;
  String? profile_img;
  UserInfoResponse({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.balance,
    this.mobile,
    this.profile_img
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
