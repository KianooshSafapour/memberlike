import 'package:freezed_annotation/freezed_annotation.dart';
part 'notificaiton_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  int? id;
  String? ids;
  int? uid;
  String? type;
  String? color;
  String? description;
  int? status;
  String? btn_label;
  String? btn_link;
  String? created;
  String? changed;

  NotificationResponse(
      {this.id,
      this.ids,
      this.uid,
      this.type,
      this.color,
      this.description,
      this.status,
      this.btn_label,
      this.btn_link,
      this.created,
      this.changed});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
