// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductHiveModelAdapter extends TypeAdapter<ProductHiveModel> {
  @override
  final int typeId = 1;

  @override
  ProductHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductHiveModel(
      id: fields[0] as int,
      subcategoryId: fields[1] as int,
      countryId: fields[2] as int?,
      brandId: fields[3] as int?,
      photoUrl: fields[4] as String?,
      name: (fields[5] as Map).cast<String, String>(),
      description: (fields[6] as Map).cast<String, String>(),
      price: fields[7] as num,
      discount: fields[8] as num?,
      priceWithDiscount: fields[9] as num?,
      rating: fields[10] as num?,
      totalSales: fields[11] as int?,
      isActive: fields[12] as bool?,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      basketCount: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductHiveModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subcategoryId)
      ..writeByte(2)
      ..write(obj.countryId)
      ..writeByte(3)
      ..write(obj.brandId)
      ..writeByte(4)
      ..write(obj.photoUrl)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(9)
      ..write(obj.priceWithDiscount)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.totalSales)
      ..writeByte(12)
      ..write(obj.isActive)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.basketCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
