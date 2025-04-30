import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  MessageRequest({
    required this.author,
    required this.created,
    required this.message,
    required this.ticket_id,
    required this.uid,
    required this.ids,
  });

  int uid;
  String author;
  int ticket_id;
  String message;
  String created;
  String ids;

  factory MessageRequest.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}
