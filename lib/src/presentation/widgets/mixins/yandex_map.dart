import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

mixin YandexMapMixin {

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui
        .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  checkPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  bool isPointInPolygon(Point point, List<Point> polygon) {
    int intersections = 0;
    for (int i = 0; i < polygon.length; i++) {
      Point vertex1 = polygon[i];
      Point vertex2 = polygon[(i + 1) % polygon.length];

      if (((vertex1.latitude > point.latitude) != (vertex2.latitude > point.latitude)) &&
          (point.longitude < (vertex2.longitude - vertex1.longitude) * (point.latitude - vertex1.latitude) /
              (vertex2.latitude - vertex1.latitude) + vertex1.longitude)) {
        intersections++;
      }
    }
    return intersections % 2 != 0;
  }
}