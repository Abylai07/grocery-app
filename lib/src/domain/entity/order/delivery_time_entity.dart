import 'package:equatable/equatable.dart';

class DeliveryTimeEntity extends Equatable {
  final int id;
  final String name;
  final String startTime;
  final String endTime;
  final bool isActive;
  final DateTime date;

  const DeliveryTimeEntity({
    required this.id,
    required this.name,
    required this.startTime,
    required this.date,
    required this.endTime,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, date, isActive];
}
