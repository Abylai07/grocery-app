import 'dart:io';

import 'package:get_storage/get_storage.dart';

class SharedPrefs {
  SharedPrefs._privateConstructor();

  static final SharedPrefs _instance = SharedPrefs._privateConstructor();

  factory SharedPrefs() {
    return _instance;
  }

  final _box = GetStorage();
  static const _accessToken = '_accessToken';
  static const _username = '_username';
  static const _refreshToken = '_refreshToken';
  static const _id = '_id';
  static const _phone = '_phone';
  static const _language = 'language';
  static const _fullName = '_fullName';
  static const _cityName = '_cityName';
  static const _cityId = '_cityId';
  static const _roles = '_roles';
  static const _appVersion = '_appVersion';
  static const _lightTheme = '_lightTheme';
  static const _setThemeAuto = '_setThemeAuto';

  dynamic _getValue(String key) {
    return _box.read(key);
  }

  void _setValue(String key, dynamic value) {
    _box.write(key, value);
  }

  void _removePref() {
    _box.remove(_accessToken);
    _box.remove(_username);
    _box.remove(_refreshToken);
    _box.remove(_id);
    _box.remove(_fullName);
    _box.remove(_cityName);
    _box.remove(_roles);
  }

  void setAccessToken(String? value) {
    if (value == null) return;
    _setValue(_accessToken, value);
  }

  void setGroupAndUser({String? username, String? group}) {
    if (group == null && username == null) return;
    _setValue(_username, username);
  }

  String? getAccessToken() {
    return _getValue(_accessToken);
  }

  String? getUsername() {
    return _getValue(_username);
  }

  void setRefreshToken(String? value) {
    if (value == null) return;
    _setValue(_refreshToken, value);
  }

  String? getRefreshToken() {
    return _getValue(_refreshToken);
  }

  void setLocaleLang(String value) async {
    _setValue(_language, value);
  }

  String getLocaleLang() {
    return _getValue(_language) ?? getLocale();
  }

  void setPhone(String number) {
    _setValue(_phone, number);
  }

  String? getPhone() {
    return _getValue(_phone);
  }

  void setId(String? id) {
    _setValue(_id, id);
  }

  String? getId() {
    return _getValue(_id);
  }

  void setFullName(String? name) {
    _setValue(_fullName, name);
  }

  String? getFullName() {
    return _getValue(_fullName);
  }

  void setAppVersion(String? value) {
    if (value == null) return;
    _setValue(_appVersion, value);
  }

  String? getAppVersion() {
    return _getValue(_appVersion);
  }

  void setCityName(String? value) {
    _setValue(_cityName, value);
  }

  void setCityId(int? value) {
    _setValue(_cityId, value);
  }

  String? getCityName() {
    return _getValue(_cityName);
  }

  int? getCityId() {
    return _getValue(_cityId);
  }

  void setRoles(List<String>? value) {
    _setValue(_roles, value);
  }

  List? getRoles() {
    return _getValue(_roles);
  }

  void setLightTheme([bool v = true]) => _setValue(_lightTheme, v);

  bool? isLightTheme() => _getValue(_lightTheme);

  void setThemeAuto([bool v = true]) => _setValue(_setThemeAuto, v);

  bool isThemeAuto() => _getValue(_setThemeAuto) ?? false;

  void deleteTokens() => _removePref();

  String getLocale() {
    String locale = 'ru';
    final systemLocale = Platform.localeName;
    final filteredLocale = systemLocale.split('_')[0];

    if (filteredLocale == 'kk') {
      locale = 'kk';
    }
    // else if (filteredLocale == 'en') {
    //   locale = 'en';
    // }
    else {
      locale = 'ru';
    }
    return locale;
  }
}
