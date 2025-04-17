import 'package:json_annotation/json_annotation.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  ServiceResponse({
    required this.id,
    required this.ids,
    required this.name,
    required this.cate_id,
    required this.desc,
    required this.price,
    required this.status,
    required this.min,
    required this.max,
    this.atrebiutes,
    this.final_price_usd = 0.0,
    this.final_price_irr = 0.0,
    required this.apiProviderId,
    required this.apiServiceId,
    required this.type,
    this.bazzar_id,
  });

  int id;
  String? bazzar_id;
  String name;
  String desc;
  String price;
  int status;
  int cate_id;
  String ids;
  String type;
  @JsonKey(name: "api_provider_id")
  int apiProviderId;
  @JsonKey(name: "api_service_id")
  String apiServiceId;
  int min;
  int max;
  double final_price_usd = 0.0;
  double final_price_irr = 0.0;
  List<String>? atrebiutes = [];

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}
