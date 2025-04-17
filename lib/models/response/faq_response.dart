// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_response.g.dart';

@JsonSerializable()
class FaqResponse {
  int? id;
  String? question;
  String? answer;
  FaqResponse({
    this.id,
    this.question,
    this.answer,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FaqResponseToJson(this);
}
