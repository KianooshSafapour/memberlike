import 'package:freezed_annotation/freezed_annotation.dart';
part 'orders_response.g.dart';

@JsonSerializable()
class OrdersResponse {
  int id;
  String? ids;
  String? type;
  @JsonKey(name: "cate_id")
  String? cateId;
  @JsonKey(name: "service_id")
  String? serviceId;
  @JsonKey(name: "main_order_id")
  int? mainOrderId;
  @JsonKey(name: "service_type")
  String? serviceType;
  @JsonKey(name: "api_provider_id")
  int? apiProviderId;
  @JsonKey(name: "api_service_id")
  String? apiServiceId;
  @JsonKey(name: "api_order_id")
  int? apiOrderId;
  String? uid;
  String? link;
  String? quantity;
  String? usernames;
  dynamic username;
  dynamic hashtags;
  String? hashtag;
  String? media;
  String? comments;
  @JsonKey(name: "sub_posts")
  int? subPosts;
  @JsonKey(name: "sub_min")
  int? subMin;
  @JsonKey(name: "sub_max")
  int? subMax;
  @JsonKey(name: "sub_delay")
  int? subDelay;
  @JsonKey(name: "sub_expiry")
  String? subExpiry;
  @JsonKey(name: "sub_response_orders")
  dynamic subResponseOrders;
  @JsonKey(name: "sub_response_posts")
  dynamic subResponsePosts;
  @JsonKey(name: "sub_status")
  dynamic subStatus;
  String? charge;
  @JsonKey(name: "formal_charge")
  dynamic formalCharge;
  dynamic profit;
  String? status;
  @JsonKey(name: "start_counter")
  dynamic startCounter;
  String? remains;
  @JsonKey(name: "is_drip_feed")
  int? isDripFeed;
  int? runs;
  int? interval;
  @JsonKey(name: "dripfeed_quantity")
  String? dripfeedQuantity;
  int? refill;
  @JsonKey(name: "refill_status")
  dynamic refillStatus;
  @JsonKey(name: "refill_date")
  dynamic refillDate;
  String? note;
  dynamic changed;
  dynamic created;

  OrdersResponse({
    required this.id,
    this.ids,
    this.type,
    this.cateId,
    this.serviceId,
    this.mainOrderId,
    this.serviceType,
    this.apiProviderId,
    this.apiServiceId,
    this.apiOrderId,
    this.uid,
    this.link,
    this.quantity,
    this.usernames,
    this.username,
    this.hashtags,
    this.hashtag,
    this.media,
    this.comments,
    this.subPosts,
    this.subMin,
    this.subMax,
    this.subDelay,
    this.subExpiry,
    this.subResponseOrders,
    this.subResponsePosts,
    this.subStatus,
    this.charge,
    this.formalCharge,
    this.profit,
    this.status,
    this.startCounter,
    this.remains,
    this.isDripFeed,
    this.runs,
    this.interval,
    this.dripfeedQuantity,
    this.refill,
    this.refillStatus,
    this.refillDate,
    this.note,
    this.changed,
    this.created,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}


