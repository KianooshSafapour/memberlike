// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequest _$MessageRequestFromJson(Map<String, dynamic> json) =>
    MessageRequest(
      author: json['author'] as String,
      created: json['created'] as String,
      message: json['message'] as String,
      ticket_id: (json['ticket_id'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      ids: json['ids'] as String,
    );

Map<String, dynamic> _$MessageRequestToJson(MessageRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'author': instance.author,
      'ticket_id': instance.ticket_id,
      'message': instance.message,
      'created': instance.created,
      'ids': instance.ids,
    };
