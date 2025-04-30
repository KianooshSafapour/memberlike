// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: (json['id'] as num).toInt(),
      ids: json['ids'] as String?,
      uid: (json['uid'] as num?)?.toInt(),
      name: json['name'] as String,
      desc: json['desc'] as String?,
      image: json['image'] as String?,
      sort: (json['sort'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ids': instance.ids,
      'uid': instance.uid,
      'name': instance.name,
      'desc': instance.desc,
      'image': instance.image,
      'sort': instance.sort,
      'status': instance.status,
    };
