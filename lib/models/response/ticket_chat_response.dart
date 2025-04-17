import 'package:json_annotation/json_annotation.dart';
part 'ticket_chat_response.g.dart';

@JsonSerializable()
class TicketChatResponse {
  TicketChatResponse(
      {this.changed,
      this.created,
      required this.id,
      required this.uid,
      required this.author,
      this.is_read,
      required this.message,
      required this.support,
      required this.ticket_id});

  int id;
  int uid;
  String message;
  bool? is_read;

  int ticket_id;
  String author;
  int support;
  String? created;
  String? changed;
  factory TicketChatResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketChatResponseToJson(this);
}
