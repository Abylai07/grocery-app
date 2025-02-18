import '../../../domain/entity/user/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.userId,
    required super.invoiceID,
    required super.lastNumbers,
    required super.cardMask,
    required super.issuer,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Factory method to create `CardModel` from JSON
  factory CardModel.fromJson(Map<String, dynamic> json) {
    String cardMask = json['cardMask'].toString();
    String lastNumbers = cardMask.substring(cardMask.length - 4);
    return CardModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      lastNumbers: lastNumbers,
      invoiceID: json['invoiceID'] as String,
      cardMask: cardMask,
      issuer: json['issuer'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Converts `CardModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "invoiceID": invoiceID,
      "cardMask": cardMask,
      "issuer": issuer,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
