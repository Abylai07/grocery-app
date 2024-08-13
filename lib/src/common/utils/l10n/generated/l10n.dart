// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `example@mail.com`
  String get gmail {
    return Intl.message(
      'example@mail.com',
      name: 'gmail',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get login {
    return Intl.message(
      'Войти',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `от {price} тг/{period}`
  String price(Object price, Object period) {
    return Intl.message(
      'от $price тг/$period',
      name: 'price',
      desc: '',
      args: [price, period],
    );
  }

  /// `История заказов`
  String get orderHistory {
    return Intl.message(
      'История заказов',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Личные данные`
  String get personalData {
    return Intl.message(
      'Личные данные',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Поле обязательно для заполнения`
  String get mustFill {
    return Intl.message(
      'Поле обязательно для заполнения',
      name: 'mustFill',
      desc: '',
      args: [],
    );
  }

  /// `Текущий пароль неверен`
  String get wrongCurrentPass {
    return Intl.message(
      'Текущий пароль неверен',
      name: 'wrongCurrentPass',
      desc: '',
      args: [],
    );
  }

  /// `Вход в аккаунт`
  String get signIn {
    return Intl.message(
      'Вход в аккаунт',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать в `
  String get welcome {
    return Intl.message(
      'Добро пожаловать в ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Abricoz`
  String get abricoz {
    return Intl.message(
      'Abricoz',
      name: 'abricoz',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона для продолжения`
  String get enterNum {
    return Intl.message(
      'Введите номер телефона для продолжения',
      name: 'enterNum',
      desc: '',
      args: [],
    );
  }

  /// `Номер телефона`
  String get phoneNumber {
    return Intl.message(
      'Номер телефона',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Продолжая, вы соглашаетесь с `
  String get continueAgree {
    return Intl.message(
      'Продолжая, вы соглашаетесь с ',
      name: 'continueAgree',
      desc: '',
      args: [],
    );
  }

  /// ` и `
  String get and {
    return Intl.message(
      ' и ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Политикой конфиденциальности`
  String get privacyPolicy {
    return Intl.message(
      'Политикой конфиденциальности',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Пользовательским соглашением`
  String get userAgreement {
    return Intl.message(
      'Пользовательским соглашением',
      name: 'userAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Некорректный номер телефона`
  String get incorrectNum {
    return Intl.message(
      'Некорректный номер телефона',
      name: 'incorrectNum',
      desc: '',
      args: [],
    );
  }

  /// `Введите код подтверждения`
  String get enterCode {
    return Intl.message(
      'Введите код подтверждения',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Код выслан на {num}`
  String sentTo(Object num) {
    return Intl.message(
      'Код выслан на $num',
      name: 'sentTo',
      desc: '',
      args: [num],
    );
  }

  /// `Получить новый код можно через`
  String get getSmsTime {
    return Intl.message(
      'Получить новый код можно через',
      name: 'getSmsTime',
      desc: '',
      args: [],
    );
  }

  /// `Получить новый код`
  String get getNewSms {
    return Intl.message(
      'Получить новый код',
      name: 'getNewSms',
      desc: '',
      args: [],
    );
  }

  /// `Получить код`
  String get getSms {
    return Intl.message(
      'Получить код',
      name: 'getSms',
      desc: '',
      args: [],
    );
  }

  /// `PIN-код не верен, либо истёк.`
  String get pinError {
    return Intl.message(
      'PIN-код не верен, либо истёк.',
      name: 'pinError',
      desc: '',
      args: [],
    );
  }

  /// `Поиск товара`
  String get searchItem {
    return Intl.message(
      'Поиск товара',
      name: 'searchItem',
      desc: '',
      args: [],
    );
  }

  /// `Укажите адрес доставки`
  String get selectAddress {
    return Intl.message(
      'Укажите адрес доставки',
      name: 'selectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Доставка до`
  String get deliveryTo {
    return Intl.message(
      'Доставка до',
      name: 'deliveryTo',
      desc: '',
      args: [],
    );
  }

  /// `Что-то пошло не так`
  String get somethingError {
    return Intl.message(
      'Что-то пошло не так',
      name: 'somethingError',
      desc: '',
      args: [],
    );
  }

  /// `Наши продукты`
  String get ourProduct {
    return Intl.message(
      'Наши продукты',
      name: 'ourProduct',
      desc: '',
      args: [],
    );
  }

  /// `Главная`
  String get main {
    return Intl.message(
      'Главная',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Каталог`
  String get catalog {
    return Intl.message(
      'Каталог',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Корзина`
  String get basket {
    return Intl.message(
      'Корзина',
      name: 'basket',
      desc: '',
      args: [],
    );
  }

  /// `Избранное`
  String get favorite {
    return Intl.message(
      'Избранное',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Категории`
  String get category {
    return Intl.message(
      'Категории',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Ваша корзина пуста`
  String get basketEmpty {
    return Intl.message(
      'Ваша корзина пуста',
      name: 'basketEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Список избранных товаров пуст`
  String get favoriteEmpty {
    return Intl.message(
      'Список избранных товаров пуст',
      name: 'favoriteEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут лежать товары для покупки`
  String get hereWillProduct {
    return Intl.message(
      'Здесь будут лежать товары для покупки',
      name: 'hereWillProduct',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут отображаться лайкнутые вами товары`
  String get hereWillFavorite {
    return Intl.message(
      'Здесь будут отображаться лайкнутые вами товары',
      name: 'hereWillFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Ничего не найдено`
  String get notFound {
    return Intl.message(
      'Ничего не найдено',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Попробуйте другие ключевые слова или проверьте правильность ввода`
  String get againOtherWord {
    return Intl.message(
      'Попробуйте другие ключевые слова или проверьте правильность ввода',
      name: 'againOtherWord',
      desc: '',
      args: [],
    );
  }

  /// `Войти в аккаунт`
  String get loginAccount {
    return Intl.message(
      'Войти в аккаунт',
      name: 'loginAccount',
      desc: '',
      args: [],
    );
  }

  /// `Адреса`
  String get address {
    return Intl.message(
      'Адреса',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Карты`
  String get carts {
    return Intl.message(
      'Карты',
      name: 'carts',
      desc: '',
      args: [],
    );
  }

  /// `Заказы`
  String get orders {
    return Intl.message(
      'Заказы',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Выйти`
  String get logout {
    return Intl.message(
      'Выйти',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `В корзину`
  String get toBasket {
    return Intl.message(
      'В корзину',
      name: 'toBasket',
      desc: '',
      args: [],
    );
  }

  /// `Пусто`
  String get empty {
    return Intl.message(
      'Пусто',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `В 100 граммах`
  String get in100gr {
    return Intl.message(
      'В 100 граммах',
      name: 'in100gr',
      desc: '',
      args: [],
    );
  }

  /// `ккал`
  String get calories {
    return Intl.message(
      'ккал',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `белки`
  String get proteins {
    return Intl.message(
      'белки',
      name: 'proteins',
      desc: '',
      args: [],
    );
  }

  /// `жиры`
  String get fats {
    return Intl.message(
      'жиры',
      name: 'fats',
      desc: '',
      args: [],
    );
  }

  /// `углеводы`
  String get carbohydrates {
    return Intl.message(
      'углеводы',
      name: 'carbohydrates',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get description {
    return Intl.message(
      'Описание',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Бренд`
  String get brand {
    return Intl.message(
      'Бренд',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Производитель`
  String get maker {
    return Intl.message(
      'Производитель',
      name: 'maker',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
