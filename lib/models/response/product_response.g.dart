// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isCheap: json['isCheap'] as bool,
      isHot: json['isHot'] as bool,
      garanteed: json['garanteed'] as bool,
      topSelled: json['topSelled'] as bool,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'isCheap': instance.isCheap,
      'isHot': instance.isHot,
      'garanteed': instance.garanteed,
      'topSelled': instance.topSelled,
    };
