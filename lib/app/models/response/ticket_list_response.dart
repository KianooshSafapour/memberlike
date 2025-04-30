import 'package:json_annotation/json_annotation.dart';
part 'ticket_list_response.g.dart';

@JsonSerializable()
class TicketListItem {
  TicketListItem({
    required this.admin_read,
    this.changed,
    this.created,
    required this.description,
    required this.id,
    required this.status,
    required this.subject,
    required this.uid,
    required this.user_read,
  });

  String description;
  int id;
  int uid;
  String subject;
  String status;
  int user_read;
  int admin_read;
  String? created;
  String? changed;
  factory TicketListItem.fromJson(Map<String, dynamic> json) =>
      _$TicketListItemFromJson(json);

  Map<String, dynamic> toJson() => _$TicketListItemToJson(this);
}
