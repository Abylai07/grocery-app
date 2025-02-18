import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int id;
  final int userId;
  final String invoiceID;
  final String cardMask;
  final String issuer;
  final String lastNumbers;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CardEntity({
    required this.id,
    required this.userId,
    required this.invoiceID,
    required this.cardMask,
    required this.issuer,
    required this.lastNumbers,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, userId, invoiceID, cardMask, lastNumbers, issuer, createdAt, updatedAt];
}
