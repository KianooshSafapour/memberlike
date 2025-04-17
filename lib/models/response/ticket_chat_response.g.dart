// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketChatResponse _$TicketChatResponseFromJson(Map<String, dynamic> json) =>
    TicketChatResponse(
      changed: json['changed'] as String?,
      created: json['created'] as String?,
      id: (json['id'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      author: json['author'] as String,
      is_read: json['is_read'] as bool?,
      message: json['message'] as String,
      support: (json['support'] as num).toInt(),
      ticket_id: (json['ticket_id'] as num).toInt(),
    );

Map<String, dynamic> _$TicketChatResponseToJson(TicketChatResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'message': instance.message,
      'is_read': instance.is_read,
      'ticket_id': instance.ticket_id,
      'author': instance.author,
      'support': instance.support,
      'created': instance.created,
      'changed': instance.changed,
    };
