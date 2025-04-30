import 'package:json_annotation/json_annotation.dart';
part 'product_response.g.dart';

@JsonSerializable()
class Product {
  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.isCheap,
    required this.isHot,
    required this.garanteed,
    required this.topSelled,
  });

  String name;
  int price;
  int quantity;
  bool isCheap;
  bool isHot;
  bool garanteed;
  bool topSelled;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
