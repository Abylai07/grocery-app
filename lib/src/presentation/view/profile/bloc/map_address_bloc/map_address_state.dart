part of 'map_address_cubit.dart';


class MapAddressState<T> extends Equatable {
  const MapAddressState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectAddress,
    this.markerIcon,
    this.mapObjects = const [],
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<AddressEntity>? entity;
  final YandexAddress? selectAddress;
  final List<MapObject> mapObjects;
  final Uint8List? markerIcon;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectAddress,
    markerIcon,
    mapObjects,
    message,
    count,
    errorCode,
  ];

  MapAddressState copyWith({
    List<AddressEntity>? entity,
    YandexAddress? selectAddress,
    List<MapObject>? mapObjects,
    Uint8List? markerIcon,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return MapAddressState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      mapObjects: mapObjects ?? this.mapObjects,
      selectAddress: selectAddress ?? this.selectAddress,
      markerIcon: markerIcon ?? this.markerIcon,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}