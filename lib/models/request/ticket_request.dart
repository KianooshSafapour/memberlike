import 'package:json_annotation/json_annotation.dart';

part 'ticket_request.g.dart';

@JsonSerializable()
class TicketRequest {
  TicketRequest({
    required this.status,
    required this.ids,
    required this.description,
    required this.subject,
    this.created,
    required this.uid,
  });

  String ids;
  int uid;
  String status;
  String description;
  String subject;
  String? created;

  factory TicketRequest.fromJson(Map<String, dynamic> json) =>
      _$TicketRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TicketRequestToJson(this);
}
