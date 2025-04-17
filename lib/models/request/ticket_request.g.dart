// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRequest _$TicketRequestFromJson(Map<String, dynamic> json) =>
    TicketRequest(
      status: json['status'] as String,
      ids: json['ids'] as String,
      description: json['description'] as String,
      subject: json['subject'] as String,
      created: json['created'] as String?,
      uid: (json['uid'] as num).toInt(),
    );

Map<String, dynamic> _$TicketRequestToJson(TicketRequest instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'uid': instance.uid,
      'status': instance.status,
      'description': instance.description,
      'subject': instance.subject,
      'created': instance.created,
    };
