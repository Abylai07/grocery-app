import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../data/models/user/yandex_address.dart';

const yandexGeoderAPIkey = '1c473376-5626-4276-a3ca-96b0891926bd'; //'401e897c-fc82-4c23-92f2-0131246dcab2';
const base = 'https://geocode-maps.yandex.ru/1.x';

class YandexGeo {

  final dio = Dio(BaseOptions(
    baseUrl: base,
    connectTimeout: const Duration(milliseconds: 10000),
  ));

  static Future<List<YandexAddress>> searchByQuery(String query) async {
    const region = 'Казахстан+Актобе';
    final res = await YandexGeo()
        .dio
        .get('/?apikey=$yandexGeoderAPIkey&geocode=$region+$query&format=json');

    if (res.statusCode != 200) {
      return [];
    }
    final results =
        res.data['response']['GeoObjectCollection']['featureMember'];

    return List<YandexAddress>.from(results
        .map((x) => YandexAddress.fromYandex(x['GeoObject'])) as Iterable);
  }

  static Future<YandexAddress?> searchByCoords(
      dynamic lat, dynamic lon) async {
    final res = await YandexGeo()
        .dio
        .get('/?apikey=$yandexGeoderAPIkey&geocode=$lon,$lat&format=json');
    if (res.statusCode != 200) {
      return null;
    }
    final result = res.data['response']['GeoObjectCollection']['featureMember'][0];
    log('${result['GeoObject']}', name: 'Search Result');
    return YandexAddress.fromYandex(result['GeoObject']);
  }
}
