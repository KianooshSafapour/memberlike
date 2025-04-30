// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificaiton_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      id: (json['id'] as num?)?.toInt(),
      ids: json['ids'] as String?,
      uid: (json['uid'] as num?)?.toInt(),
      type: json['type'] as String?,
      color: json['color'] as String?,
      description: json['description'] as String?,
      status: (json['status'] as num?)?.toInt(),
      btn_label: json['btn_label'] as String?,
      btn_link: json['btn_link'] as String?,
      created: json['created'] as String?,
      changed: json['changed'] as String?,
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ids': instance.ids,
      'uid': instance.uid,
      'type': instance.type,
      'color': instance.color,
      'description': instance.description,
      'status': instance.status,
      'btn_label': instance.btn_label,
      'btn_link': instance.btn_link,
      'created': instance.created,
      'changed': instance.changed,
    };
