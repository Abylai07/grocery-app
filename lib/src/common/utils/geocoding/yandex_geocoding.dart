import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../data/models/user/my_address_model.dart';
import '../../../data/models/user/yandex_address.dart';

const base = 'https://geocode-maps.yandex.ru/1.x';

class YandexGeo {
  static String _apiKey = '1d80506d-5839-4891-b047-3dee83e38425';

  final dio = Dio(BaseOptions(
    baseUrl: base,
    connectTimeout: const Duration(milliseconds: 10000),
  ));

  static void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  static Future<YandexAddress?> searchByCoords(
      dynamic lat, dynamic lon) async {
    try{
      final res = await YandexGeo()
          .dio
          .get('/?apikey=$_apiKey&geocode=$lon,$lat&format=json');
      if (res.statusCode != 200) {
        return null;
      }
      final result = res.data['response']['GeoObjectCollection']['featureMember'][0];
      log('${result['GeoObject']}', name: 'Search Result');
      return YandexAddress.fromYandex(result['GeoObject']);
    } catch(e){
      log(e.toString(), name: 'Search Error');
    }
    return null;
  }

  // static Future<List<YandexAddress>> searchByQuery(String query) async {
  //   const region = 'Казахстан+Актобе';
  //   final res = await YandexGeo()
  //       .dio
  //       .get('/?apikey=$_apiKey&geocode=$region+$query&format=json');
  //
  //   if (res.statusCode != 200) {
  //     return [];
  //   }
  //   final results =
  //       res.data['response']['GeoObjectCollection']['featureMember'];
  //
  //   return List<YandexAddress>.from(results
  //       .map((x) => YandexAddress.fromYandex(x['GeoObject'])) as Iterable);
  // }

  static Future<NominatimAddress?> searchByNewCoords(dynamic lat, dynamic lon) async {
    try {
      final res = await Dio().get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'format': 'json',
        },
        options: Options(
          headers: {'User-Agent': 'MyApp/1.0 (myemail@example.com)'},
        ),
      );
      if (res.statusCode != 200) {
        return null;
      }

      log('${res.data}', name: 'Search Result');
      return NominatimAddress.fromJson(res.data);
    } catch (e) {
      log(e.toString(), name: 'Search Error');
    }
    return null;
  }
}
