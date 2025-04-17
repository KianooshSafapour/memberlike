// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) =>
    ServiceResponse(
      id: (json['id'] as num).toInt(),
      ids: json['ids'] as String,
      name: json['name'] as String,
      cate_id: (json['cate_id'] as num).toInt(),
      desc: json['desc'] as String,
      price: json['price'] as String,
      status: (json['status'] as num).toInt(),
      min: (json['min'] as num).toInt(),
      max: (json['max'] as num).toInt(),
      atrebiutes: (json['atrebiutes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      final_price_usd: (json['final_price_usd'] as num?)?.toDouble() ?? 0.0,
      final_price_irr: (json['final_price_irr'] as num?)?.toDouble() ?? 0.0,
      apiProviderId: (json['api_provider_id'] as num).toInt(),
      apiServiceId: json['api_service_id'] as String,
      type: json['type'] as String,
      bazzar_id: json['bazzar_id'] as String?,
    );

Map<String, dynamic> _$ServiceResponseToJson(ServiceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bazzar_id': instance.bazzar_id,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'status': instance.status,
      'cate_id': instance.cate_id,
      'ids': instance.ids,
      'type': instance.type,
      'api_provider_id': instance.apiProviderId,
      'api_service_id': instance.apiServiceId,
      'min': instance.min,
      'max': instance.max,
      'final_price_usd': instance.final_price_usd,
      'final_price_irr': instance.final_price_irr,
      'atrebiutes': instance.atrebiutes,
    };
