// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketListItem _$TicketListItemFromJson(Map<String, dynamic> json) =>
    TicketListItem(
      admin_read: (json['admin_read'] as num).toInt(),
      changed: json['changed'] as String?,
      created: json['created'] as String?,
      description: json['description'] as String,
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      subject: json['subject'] as String,
      uid: (json['uid'] as num).toInt(),
      user_read: (json['user_read'] as num).toInt(),
    );

Map<String, dynamic> _$TicketListItemToJson(TicketListItem instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'uid': instance.uid,
      'subject': instance.subject,
      'status': instance.status,
      'user_read': instance.user_read,
      'admin_read': instance.admin_read,
      'created': instance.created,
      'changed': instance.changed,
    };
