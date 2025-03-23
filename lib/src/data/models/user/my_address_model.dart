import 'dart:convert';

class NominatimAddress {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final double lat;
  final double lon;
  final String classification;
  final String type;
  final int placeRank;
  final double importance;
  final String addressType;
  final String name;
  final String displayName;
  final AddressDetails address;
  final List<double> boundingBox;

  NominatimAddress({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.classification,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addressType,
    required this.name,
    required this.displayName,
    required this.address,
    required this.boundingBox,
  });

  factory NominatimAddress.fromJson(Map<String, dynamic> json) {
    return NominatimAddress(
      placeId: json['place_id'],
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: json['osm_id'],
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
      classification: json['class'],
      type: json['type'],
      placeRank: json['place_rank'],
      importance: json['importance'].toDouble(),
      addressType: json['addresstype'],
      name: json['name'],
      displayName: json['display_name'],
      address: AddressDetails.fromJson(json['address']),
      boundingBox: (json['boundingbox'] as List).map((e) => double.parse(e.toString())).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'licence': licence,
      'osm_type': osmType,
      'osm_id': osmId,
      'lat': lat,
      'lon': lon,
      'class': classification,
      'type': type,
      'place_rank': placeRank,
      'importance': importance,
      'addresstype': addressType,
      'name': name,
      'display_name': displayName,
      'address': address.toJson(),
      'boundingbox': boundingBox.map((e) => e.toString()).toList(),
    };
  }
}

class AddressDetails {
  final String road;
  final String? neighbourhood;
  final String city;
  final String county;
  final String state;
  final String isoCode;
  final String postcode;
  final String country;
  final String countryCode;

  AddressDetails({
    required this.road,
    this.neighbourhood,
    required this.city,
    required this.county,
    required this.state,
    required this.isoCode,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      road: json['road'],
      neighbourhood: json['neighbourhood'],
      city: json['city'],
      county: json['county'],
      state: json['state'],
      isoCode: json['ISO3166-2-lvl4'],
      postcode: json['postcode'],
      country: json['country'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'road': road,
      'neighbourhood': neighbourhood,
      'city': city,
      'county': county,
      'state': state,
      'ISO3166-2-lvl4': isoCode,
      'postcode': postcode,
      'country': country,
      'country_code': countryCode,
    };
  }
}
