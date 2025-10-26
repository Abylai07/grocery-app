import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexAddress {
  const YandexAddress({
    this.id = 0,
    this.street = '',
    this.floor = '',
    this.flat = '',
    this.comment = '',
    this.longitude = 43.210571,
    this.latitude = 76.877588,
    this.message = '',
    this.error = false,
    this.deliveryFee = 0,
    this.description = '',
    this.ne = const Point(latitude: 0, longitude: 0),
    this.sw = const Point(latitude: 0, longitude: 0),
  });

  factory YandexAddress.fromJson(dynamic json) {
    const def = false;
    String shorten(dynamic data) {
      String newstr = data as String;
      newstr = newstr.replaceAll('улица', 'ул.');
      newstr = newstr.replaceAll('проспект', 'пр.');
      newstr = newstr.replaceAll('переулок', 'пер.');
      newstr = newstr.replaceAll('микрорайон', 'мкрн.');
      newstr = newstr.replaceAll('район', 'р-н.');
      return newstr;
    }

    return YandexAddress(
      id: json['id'] == null ? 0 : json['id'] as int,
      street: json['street'] == null ? '' : shorten(json['street']),
      floor: json['floor'] == null ? '' : json['floor'] as String,
      flat: json['flat'] == null ? '' : json['flat'] as String,
      comment: json['comment'] == null ? '' : json['comment'] as String,
      longitude: json['longitude'] == null ? 0 : json['longitude'].toDouble() as double,
      latitude: json['latitude'] == null ? 0 : json['latitude'].toDouble() as double,
      message: json['message'] == null ? '' : json['message'] as String,
      error: json['error'] == null ? def : json['error'] as bool,
      deliveryFee: json['deliveryFee'] == null ? 0 : json['deliveryFee'] as int,
    );
  }

  factory YandexAddress.fromYandex(dynamic json) {
    Point split(dynamic data) {
      final coords = data.split(' ');
      final lon = double.parse(coords[0] as String);
      final lat = double.parse(coords[1] as String);
      return Point(latitude: lat, longitude: lon);
    }

    String shorten(dynamic data) {
      String newstr = data as String;
      newstr = newstr.replaceAll('улица', 'ул.');
      newstr = newstr.replaceAll('проспект', 'пр.');
      newstr = newstr.replaceAll('переулок', 'пер.');
      newstr = newstr.replaceAll('микрорайон', 'мкрн.');
      newstr = newstr.replaceAll('район', 'р-н.');
      newstr = newstr.replaceAll(' (Астана)', '');
      return newstr;
    }

    return YandexAddress(
      street: shorten(json['name']),
      description: json['description'] == null ? '' : shorten(json['description']),
      latitude: split(json['Point']['pos']).latitude,
      longitude: split(json['Point']['pos']).longitude,
      ne: split(json['boundedBy']['Envelope']['upperCorner']),
      sw: split(json['boundedBy']['Envelope']['lowerCorner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'description': description,
      'floor': floor,
      'flat': flat,
      'latitude': latitude,
      'longitude': longitude,
      'comment': comment,
    };
  }

  final int id;
  final String street;
  final String floor;
  final String flat;
  final String comment;
  final double longitude;
  final double latitude;
  final String message;
  final bool error;
  final int deliveryFee;
  final String description;
  final Point sw;
  final Point ne;
}