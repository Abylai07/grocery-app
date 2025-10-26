class PushDataModel {
  final int orderStatusId;
  final int orderId;

  PushDataModel({
    required this.orderStatusId,
    required this.orderId,
  });

  factory PushDataModel.fromJson(Map<String, dynamic> json) {
    return PushDataModel(
      orderStatusId: int.parse(json['order_status_id'] ?? '0'),
      orderId: int.parse(json['order_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_status_id': orderStatusId,
      'order_id': orderId,
    };
  }
}
