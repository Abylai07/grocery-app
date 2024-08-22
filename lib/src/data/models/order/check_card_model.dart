import '../../../domain/entity/order/check_card_entity.dart';
import '../../../presentation/widgets/main_functions.dart';
import '../product/product_model.dart';

class CheckCardModel extends CheckCardEntity {
  const CheckCardModel({
    required super.products,
    required super.totalPrice,
  });

  factory CheckCardModel.fromJson(Map<String, dynamic> json) {
    return CheckCardModel(
      products: List<ProductCardModel>.from(
        json['products']
            .map((productJson) => ProductCardModel.fromJson(productJson)),
      ),
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products
          .map((product) => (product as ProductModel).toJson())
          .toList(),
      'total_price': totalPrice,
    };
  }
}

class ProductCardModel extends ProductCardEntity {
  const ProductCardModel({
    required super.id,
    super.photoUrl,
    required super.name,
    required super.price,
    required super.isActive,
    super.discount,
    super.priceWithDiscount,
    super.weight,
    super.productQuantity,
  });

  factory ProductCardModel.fromJson(Map<String, dynamic> json) {
    return ProductCardModel(
      id: json['id'],
      productQuantity: json['product_quantity'],
      photoUrl: convertFilePathToUrl(json['photo_url']),
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
        'en': json['name_en'],
      },
      price: json['price'],
      discount: json['discount'],
      priceWithDiscount: json['price_with_discount'],
      isActive: json['is_active'] == 1,
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo_url': photoUrl,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
      'name_en': name['en'],
      'price': price,
      'product_quantity': productQuantity,
      'discount': discount,
      'price_with_discount': priceWithDiscount,
      'is_active': isActive ? 1 : 0,
      'weight': weight,
    };
  }
}
