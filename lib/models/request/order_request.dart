import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  OrderRequest({
    required this.ids,
    required this.type,
    required this.charge,
    required this.status,
    required this.uid,
    required this.cateId,
    required this.serviceId,
    required this.mainOrderId,
    required this.serviceType,
    required this.apiProviderId,
    required this.apiServiceId,
    required this.apiOrderId,
    required this.link,
    required this.quantity,
    required this.usernames,
    required this.hashtag,
    required this.media,
    required this.comments,
    required this.subPosts,
    required this.subMin,
    required this.subMax,
    required this.subDelay,
    required this.subExpiry,
    required this.note,
    required this.changed,
    required this.created,
  });

  String ids;
  String type;
  String uid;
  double charge;
  String status;
  @JsonKey(name: 'cate_id')
  String cateId;
  @JsonKey(name: 'service_id')
  String serviceId;
  @JsonKey(name: 'main_order_id')
  int mainOrderId;
  @JsonKey(name: 'service_type')
  String serviceType;
  @JsonKey(name: 'api_provider_id')
  int apiProviderId;
  @JsonKey(name: 'api_service_id')
  String apiServiceId;
  @JsonKey(name: 'api_order_id')
  int apiOrderId;
  String link;
  String quantity;
  String usernames;
  String hashtag;
  String media;
  String comments;
  @JsonKey(name: 'sub_posts')
  int subPosts;
  @JsonKey(name: 'sub_min')
  int subMin;
  @JsonKey(name: 'sub_max')
  int subMax;
  @JsonKey(name: 'sub_delay')
  int subDelay;
  @JsonKey(name: 'sub_expiry')
  int subExpiry;
  String note;
  DateTime changed;
  DateTime created;

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
