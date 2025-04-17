// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      ids: json['ids'] as String,
      type: json['type'] as String,
      cateId: json['cate_id'] as String,
      serviceId: json['service_id'] as String,
      mainOrderId: (json['main_order_id'] as num).toInt(),
      serviceType: json['service_type'] as String,
      apiProviderId: (json['api_provider_id'] as num).toInt(),
      apiServiceId: json['api_service_id'] as String,
      apiOrderId: (json['api_order_id'] as num).toInt(),
      link: json['link'] as String,
      quantity: json['quantity'] as String,
      usernames: json['usernames'] as String,
      hashtag: json['hashtag'] as String,
      media: json['media'] as String,
      comments: json['comments'] as String,
      subPosts: (json['sub_posts'] as num).toInt(),
      subMin: (json['sub_min'] as num).toInt(),
      subMax: (json['sub_max'] as num).toInt(),
      subDelay: (json['sub_delay'] as num).toInt(),
      subExpiry: (json['sub_expiry'] as num).toInt(),
      status: json['status'] as String,
      uid: json['uid'] as String,
      charge: (json['charge'] as num).toDouble(),
      note: json['note'] as String,
      changed: DateTime.parse(json['changed'] as String),
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'type': instance.type,
      'cate_id': instance.cateId,
      'service_id': instance.serviceId,
      'main_order_id': instance.mainOrderId,
      'service_type': instance.serviceType,
      'api_provider_id': instance.apiProviderId,
      'api_service_id': instance.apiServiceId,
      'api_order_id': instance.apiOrderId,
      'link': instance.link,
      'quantity': instance.quantity,
      'usernames': instance.usernames,
      'hashtag': instance.hashtag,
      'media': instance.media,
      'comments': instance.comments,
      'sub_posts': instance.subPosts,
      'sub_min': instance.subMin,
      'sub_max': instance.subMax,
      'sub_delay': instance.subDelay,
      'sub_expiry': instance.subExpiry,
      'note': instance.note,
      'uid': instance.uid,
      'charge': instance.charge,
      'status': instance.status,
      'changed': instance.changed.toIso8601String(),
      'created': instance.created.toIso8601String(),
    };
