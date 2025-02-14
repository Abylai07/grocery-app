import 'package:flutter/cupertino.dart';

/// Cubit statuses initial success error loading
enum CubitStatus { initial, success, error, loading}

extension CubitStatusX on CubitStatus {
  bool get isInitial => this == CubitStatus.initial;
  bool get isSuccess => this == CubitStatus.success;
  bool get isError => this == CubitStatus.error;
  bool get isLoading => this == CubitStatus.loading;
}


extension SizedBoxExtension on int {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

extension BorderRadiusExtension on int {
  BorderRadius get r => BorderRadius.circular(toDouble());
}

extension NullOrEmptyExtension<T> on T? {

  bool get isNotNullEmpty {
    if (this == null) return false;

    if (this is String) {
      return (this as String).isNotEmpty;
    } else if (this is Iterable) {
      return (this as Iterable).isNotEmpty;
    } else if (this is Map) {
      return (this as Map).isNotEmpty;
    }
    return true;
  }
}

enum OrderStatus {
  processing,
  beingAssembled,
  assembled,
  atTheCourier,
  delivered,
  cancelled,
  waitingPayment,
}

extension OrderStatusX on OrderStatus {
  bool get isProcessing => this == OrderStatus.processing;

  bool get isBeingAssembled => this == OrderStatus.beingAssembled;

  bool get isAssembled => this == OrderStatus.assembled;

  bool get isAtTheCourier => this == OrderStatus.atTheCourier;

  bool get isDelivered => this == OrderStatus.delivered;

  bool get isCancelled => this == OrderStatus.cancelled;

  bool get isWaitingPayment => this == OrderStatus.waitingPayment;
}

OrderStatus getStatusById(int id) {
  switch (id) {
    case 1:
      return OrderStatus.processing;
    case 2:
      return OrderStatus.beingAssembled;
    case 3:
      return OrderStatus.assembled;
    case 4:
      return OrderStatus.atTheCourier;
    case 5:
      return OrderStatus.delivered;
    case 7:
      return OrderStatus.waitingPayment;
    default:
      return OrderStatus.cancelled;
  }
}