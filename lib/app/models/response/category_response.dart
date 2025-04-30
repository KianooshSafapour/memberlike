import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  int id;
  String? ids;
  int? uid;
  String name;
  String? desc;
  String? image;
  int sort;
  int status;

  CategoryResponse({
    required this.id,
    required this.ids,
    required this.uid,
    required this.name,
    required this.desc,
    required this.image,
    required this.sort,
    required this.status,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
