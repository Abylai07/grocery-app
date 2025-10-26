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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Войти`
  String get login {
    return Intl.message('Войти', name: 'login', desc: '', args: []);
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
    return Intl.message('Назад', name: 'back', desc: '', args: []);
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
    return Intl.message('Вход в аккаунт', name: 'signIn', desc: '', args: []);
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

  /// `Grocery App`
  String get abricoz {
    return Intl.message('Grocery App', name: 'abricoz', desc: '', args: []);
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
    return Intl.message(' и ', name: 'and', desc: '', args: []);
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

  /// `Выбрать адрес`
  String get select {
    return Intl.message('Выбрать адрес', name: 'select', desc: '', args: []);
  }

  /// `Укажите город`
  String get selectCity {
    return Intl.message(
      'Укажите город',
      name: 'selectCity',
      desc: '',
      args: [],
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
    return Intl.message('Получить код', name: 'getSms', desc: '', args: []);
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
    return Intl.message('Поиск товара', name: 'searchItem', desc: '', args: []);
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
    return Intl.message('Доставка до', name: 'deliveryTo', desc: '', args: []);
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
    return Intl.message('Главная', name: 'main', desc: '', args: []);
  }

  /// `Каталог`
  String get catalog {
    return Intl.message('Каталог', name: 'catalog', desc: '', args: []);
  }

  /// `Корзина`
  String get basket {
    return Intl.message('Корзина', name: 'basket', desc: '', args: []);
  }

  /// `Избранное`
  String get favorite {
    return Intl.message('Избранное', name: 'favorite', desc: '', args: []);
  }

  /// `Профиль`
  String get profile {
    return Intl.message('Профиль', name: 'profile', desc: '', args: []);
  }

  /// `Категории`
  String get category {
    return Intl.message('Категории', name: 'category', desc: '', args: []);
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

  /// `Попробуйте другие категории`
  String get otherCategory {
    return Intl.message(
      'Попробуйте другие категории',
      name: 'otherCategory',
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
    return Intl.message('Адреса', name: 'address', desc: '', args: []);
  }

  /// `Карты`
  String get carts {
    return Intl.message('Карты', name: 'carts', desc: '', args: []);
  }

  /// `Заказы`
  String get orders {
    return Intl.message('Заказы', name: 'orders', desc: '', args: []);
  }

  /// `Выйти`
  String get logout {
    return Intl.message('Выйти', name: 'logout', desc: '', args: []);
  }

  /// `В корзину`
  String get toBasket {
    return Intl.message('В корзину', name: 'toBasket', desc: '', args: []);
  }

  /// `Пусто`
  String get empty {
    return Intl.message('Пусто', name: 'empty', desc: '', args: []);
  }

  /// `В 100 граммах`
  String get in100gr {
    return Intl.message('В 100 граммах', name: 'in100gr', desc: '', args: []);
  }

  /// `ккал`
  String get calories {
    return Intl.message('ккал', name: 'calories', desc: '', args: []);
  }

  /// `белки`
  String get proteins {
    return Intl.message('белки', name: 'proteins', desc: '', args: []);
  }

  /// `жиры`
  String get fats {
    return Intl.message('жиры', name: 'fats', desc: '', args: []);
  }

  /// `углеводы`
  String get carbohydrates {
    return Intl.message('углеводы', name: 'carbohydrates', desc: '', args: []);
  }

  /// `Описание`
  String get description {
    return Intl.message('Описание', name: 'description', desc: '', args: []);
  }

  /// `Бренд`
  String get brand {
    return Intl.message('Бренд', name: 'brand', desc: '', args: []);
  }

  /// `Производитель`
  String get maker {
    return Intl.message('Производитель', name: 'maker', desc: '', args: []);
  }

  /// `Заказывайте свежую клубнику в нашем новом приложении!`
  String get bannerLocal {
    return Intl.message(
      'Заказывайте свежую клубнику в нашем новом приложении!',
      name: 'bannerLocal',
      desc: '',
      args: [],
    );
  }

  /// `Перейти к оформлению: {sum} ₸`
  String goToPay(Object sum) {
    return Intl.message(
      'Перейти к оформлению: $sum ₸',
      name: 'goToPay',
      desc: '',
      args: [sum],
    );
  }

  /// `Подтвердить заказ: {sum} ₸`
  String confirmPay(Object sum) {
    return Intl.message(
      'Подтвердить заказ: $sum ₸',
      name: 'confirmPay',
      desc: '',
      args: [sum],
    );
  }

  /// `Оформление заказа`
  String get makeOrder {
    return Intl.message(
      'Оформление заказа',
      name: 'makeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Доставка до`
  String get deliveryBefore {
    return Intl.message(
      'Доставка до',
      name: 'deliveryBefore',
      desc: '',
      args: [],
    );
  }

  /// `Время доставки`
  String get deliveryTime {
    return Intl.message(
      'Время доставки',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Способ оплаты`
  String get paymentType {
    return Intl.message(
      'Способ оплаты',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Наличными/Kaspi QR`
  String get cashToCourier {
    return Intl.message(
      'Наличными/Kaspi QR',
      name: 'cashToCourier',
      desc: '',
      args: [],
    );
  }

  /// `Продукты`
  String get products {
    return Intl.message('Продукты', name: 'products', desc: '', args: []);
  }

  /// `Стоимость доставки`
  String get deliveryPrice {
    return Intl.message(
      'Стоимость доставки',
      name: 'deliveryPrice',
      desc: '',
      args: [],
    );
  }

  /// `Доставка от 30 минут`
  String get delivery30min {
    return Intl.message(
      'Доставка от 30 минут',
      name: 'delivery30min',
      desc: '',
      args: [],
    );
  }

  /// `Оплата заказа`
  String get paymentOrder {
    return Intl.message(
      'Оплата заказа',
      name: 'paymentOrder',
      desc: '',
      args: [],
    );
  }

  /// `Номер заказа`
  String get orderNumber {
    return Intl.message(
      'Номер заказа',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Сумма к оплате`
  String get paySum {
    return Intl.message('Сумма к оплате', name: 'paySum', desc: '', args: []);
  }

  /// `Статус оплаты`
  String get paymentStatus {
    return Intl.message(
      'Статус оплаты',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Завершите оплату в течение {time} или заказ будет отменён`
  String payTime(Object time) {
    return Intl.message(
      'Завершите оплату в течение $time или заказ будет отменён',
      name: 'payTime',
      desc: '',
      args: [time],
    );
  }

  /// `Время на оплату истекло, заказ в процессе отмены`
  String get payTimeFinish {
    return Intl.message(
      'Время на оплату истекло, заказ в процессе отмены',
      name: 'payTimeFinish',
      desc: '',
      args: [],
    );
  }

  /// `Заказ был отменён по инициативе пользователя`
  String get orderCanceled {
    return Intl.message(
      'Заказ был отменён по инициативе пользователя',
      name: 'orderCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Спасибо за покупку! Мы свяжемся с вами с деталями для доставки`
  String get thanksForOrder {
    return Intl.message(
      'Спасибо за покупку! Мы свяжемся с вами с деталями для доставки',
      name: 'thanksForOrder',
      desc: '',
      args: [],
    );
  }

  /// `Оплатить заказ`
  String get payOrder {
    return Intl.message('Оплатить заказ', name: 'payOrder', desc: '', args: []);
  }

  /// `Отменить заказ`
  String get cancelOrder {
    return Intl.message(
      'Отменить заказ',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Эта опция доступна для авторизованных пользователей`
  String get nonAuthorizedText {
    return Intl.message(
      'Эта опция доступна для авторизованных пользователей',
      name: 'nonAuthorizedText',
      desc: '',
      args: [],
    );
  }

  /// `Закрыть`
  String get close {
    return Intl.message('Закрыть', name: 'close', desc: '', args: []);
  }

  /// `Удалить`
  String get delete {
    return Intl.message('Удалить', name: 'delete', desc: '', args: []);
  }

  /// `Неактивен`
  String get notActive {
    return Intl.message('Неактивен', name: 'notActive', desc: '', args: []);
  }

  /// `Добавить новую карту`
  String get addNewCard {
    return Intl.message(
      'Добавить новую карту',
      name: 'addNewCard',
      desc: '',
      args: [],
    );
  }

  /// `Ваши адреса`
  String get yourAddress {
    return Intl.message('Ваши адреса', name: 'yourAddress', desc: '', args: []);
  }

  /// `У вас нет адресов`
  String get noAddress {
    return Intl.message(
      'У вас нет адресов',
      name: 'noAddress',
      desc: '',
      args: [],
    );
  }

  /// `Ваши адреса будут храниться здесь`
  String get addressSaveHere {
    return Intl.message(
      'Ваши адреса будут храниться здесь',
      name: 'addressSaveHere',
      desc: '',
      args: [],
    );
  }

  /// `Добавить новый адрес`
  String get addNewAddress {
    return Intl.message(
      'Добавить новый адрес',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Город`
  String get city {
    return Intl.message('Город', name: 'city', desc: '', args: []);
  }

  /// `Район`
  String get district {
    return Intl.message('Район', name: 'district', desc: '', args: []);
  }

  /// `Улица, дом*`
  String get street {
    return Intl.message('Улица, дом*', name: 'street', desc: '', args: []);
  }

  /// `Кв/офис`
  String get office {
    return Intl.message('Кв/офис', name: 'office', desc: '', args: []);
  }

  /// `Подъезд`
  String get entrance {
    return Intl.message('Подъезд', name: 'entrance', desc: '', args: []);
  }

  /// `Этаж`
  String get floor {
    return Intl.message('Этаж', name: 'floor', desc: '', args: []);
  }

  /// `Комментарий к адресу`
  String get commentToAddress {
    return Intl.message(
      'Комментарий к адресу',
      name: 'commentToAddress',
      desc: '',
      args: [],
    );
  }

  /// `Редактировать адрес`
  String get editAddress {
    return Intl.message(
      'Редактировать адрес',
      name: 'editAddress',
      desc: '',
      args: [],
    );
  }

  /// `Изменить список адресов`
  String get changeAddress {
    return Intl.message(
      'Изменить список адресов',
      name: 'changeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Добавить адрес`
  String get addAddress {
    return Intl.message(
      'Добавить адрес',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Удалить выбранные товары из корзины?`
  String get deleteAllBasket {
    return Intl.message(
      'Удалить выбранные товары из корзины?',
      name: 'deleteAllBasket',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердить`
  String get confirm {
    return Intl.message('Подтвердить', name: 'confirm', desc: '', args: []);
  }

  /// `Отмена`
  String get cancel {
    return Intl.message('Отмена', name: 'cancel', desc: '', args: []);
  }

  /// `Отмена заказа? Ваши покупки почти отправились в путь!`
  String get orderCancel {
    return Intl.message(
      'Отмена заказа? Ваши покупки почти отправились в путь!',
      name: 'orderCancel',
      desc: '',
      args: [],
    );
  }

  /// `Вы точно хотите выйти? Мы будем скучать.`
  String get sureLogout {
    return Intl.message(
      'Вы точно хотите выйти? Мы будем скучать.',
      name: 'sureLogout',
      desc: '',
      args: [],
    );
  }

  /// `Этот адрес больше не нужен? Прощаться всегда непросто.`
  String get deleteAddress {
    return Intl.message(
      'Этот адрес больше не нужен? Прощаться всегда непросто.',
      name: 'deleteAddress',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message('Сохранить', name: 'save', desc: '', args: []);
  }

  /// `Сейчас нет доступного времени`
  String get notAvailableNow {
    return Intl.message(
      'Сейчас нет доступного времени',
      name: 'notAvailableNow',
      desc: '',
      args: [],
    );
  }

  /// `Выберите адрес доставки`
  String get selectAddressPlease {
    return Intl.message(
      'Выберите адрес доставки',
      name: 'selectAddressPlease',
      desc: '',
      args: [],
    );
  }

  /// `Выберите время доставки`
  String get selectTimePlease {
    return Intl.message(
      'Выберите время доставки',
      name: 'selectTimePlease',
      desc: '',
      args: [],
    );
  }

  /// `Выберите способ оплаты`
  String get selectPaymentPlease {
    return Intl.message(
      'Выберите способ оплаты',
      name: 'selectPaymentPlease',
      desc: '',
      args: [],
    );
  }

  /// `Список товаров`
  String get itemList {
    return Intl.message('Список товаров', name: 'itemList', desc: '', args: []);
  }

  /// `Версия`
  String get version {
    return Intl.message('Версия', name: 'version', desc: '', args: []);
  }

  /// `Язык приложения`
  String get appLanguage {
    return Intl.message(
      'Язык приложения',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Список заказов пуст`
  String get orderEmpty {
    return Intl.message(
      'Список заказов пуст',
      name: 'orderEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Здесь будут отображаться ваши\nпоследние заказы`
  String get lastOrderWillHere {
    return Intl.message(
      'Здесь будут отображаться ваши\nпоследние заказы',
      name: 'lastOrderWillHere',
      desc: '',
      args: [],
    );
  }

  /// `Перейти к покупкам`
  String get goToProducts {
    return Intl.message(
      'Перейти к покупкам',
      name: 'goToProducts',
      desc: '',
      args: [],
    );
  }

  /// `Заказ`
  String get order {
    return Intl.message('Заказ', name: 'order', desc: '', args: []);
  }

  /// `Ожидание`
  String get wait {
    return Intl.message('Ожидание', name: 'wait', desc: '', args: []);
  }

  /// `Обработка`
  String get processing {
    return Intl.message('Обработка', name: 'processing', desc: '', args: []);
  }

  /// `В процессе отмены`
  String get processCancel {
    return Intl.message(
      'В процессе отмены',
      name: 'processCancel',
      desc: '',
      args: [],
    );
  }

  /// `Отменён`
  String get canceled {
    return Intl.message('Отменён', name: 'canceled', desc: '', args: []);
  }

  /// `Доставлен`
  String get delivered {
    return Intl.message('Доставлен', name: 'delivered', desc: '', args: []);
  }

  /// `Все товары`
  String get allProducts {
    return Intl.message('Все товары', name: 'allProducts', desc: '', args: []);
  }

  /// `Повторить заказ`
  String get orderAgain {
    return Intl.message(
      'Повторить заказ',
      name: 'orderAgain',
      desc: '',
      args: [],
    );
  }

  /// `Итоговая сумма`
  String get totalSum {
    return Intl.message('Итоговая сумма', name: 'totalSum', desc: '', args: []);
  }

  /// `Мои заказы`
  String get myOrders {
    return Intl.message('Мои заказы', name: 'myOrders', desc: '', args: []);
  }

  /// `Дата оформления`
  String get createDate {
    return Intl.message(
      'Дата оформления',
      name: 'createDate',
      desc: '',
      args: [],
    );
  }

  /// `Дата и время доставки`
  String get deliveryDate {
    return Intl.message(
      'Дата и время доставки',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Статус`
  String get status {
    return Intl.message('Статус', name: 'status', desc: '', args: []);
  }

  /// `Адрес доставки`
  String get deliveryAddress {
    return Intl.message(
      'Адрес доставки',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Активный заказ`
  String get activeOrder {
    return Intl.message(
      'Активный заказ',
      name: 'activeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Перейти`
  String get go {
    return Intl.message('Перейти', name: 'go', desc: '', args: []);
  }

  /// `Перейти в корзину`
  String get goToBasket {
    return Intl.message(
      'Перейти в корзину',
      name: 'goToBasket',
      desc: '',
      args: [],
    );
  }

  /// `Введите имя и фамилию`
  String get enterName {
    return Intl.message(
      'Введите имя и фамилию',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Заполните поля "Имя" и "Фамилия"`
  String get fillName {
    return Intl.message(
      'Заполните поля "Имя" и "Фамилия"',
      name: 'fillName',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get name {
    return Intl.message('Имя', name: 'name', desc: '', args: []);
  }

  /// `Фамилия`
  String get surname {
    return Intl.message('Фамилия', name: 'surname', desc: '', args: []);
  }

  /// `Вы точно хотите удалить аккаунт?`
  String get deleteAccountSure {
    return Intl.message(
      'Вы точно хотите удалить аккаунт?',
      name: 'deleteAccountSure',
      desc: '',
      args: [],
    );
  }

  /// `Удалить аккаунт?`
  String get deleteAccount {
    return Intl.message(
      'Удалить аккаунт?',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Доставка в этот регион не осуществляется`
  String get notDeliverPlace {
    return Intl.message(
      'Доставка в этот регион не осуществляется',
      name: 'notDeliverPlace',
      desc: '',
      args: [],
    );
  }

  /// `Политика конфиденциальности`
  String get privacyPol {
    return Intl.message(
      'Политика конфиденциальности',
      name: 'privacyPol',
      desc: '',
      args: [],
    );
  }

  /// `Пользовательское соглашение`
  String get userAgre {
    return Intl.message(
      'Пользовательское соглашение',
      name: 'userAgre',
      desc: '',
      args: [],
    );
  }

  /// `Информация`
  String get info {
    return Intl.message('Информация', name: 'info', desc: '', args: []);
  }

  /// `Согласие на обработку персональных данных`
  String get consent_to_personal_data_processing {
    return Intl.message(
      'Согласие на обработку персональных данных',
      name: 'consent_to_personal_data_processing',
      desc: '',
      args: [],
    );
  }

  /// `Публичная оферта`
  String get public_offer {
    return Intl.message(
      'Публичная оферта',
      name: 'public_offer',
      desc: '',
      args: [],
    );
  }

  /// `Информация о заказе`
  String get order_info {
    return Intl.message(
      'Информация о заказе',
      name: 'order_info',
      desc: '',
      args: [],
    );
  }

  /// `Статус заказа`
  String get order_status {
    return Intl.message(
      'Статус заказа',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены, что хотите отменить заказ?`
  String get cancel_order_confirmation {
    return Intl.message(
      'Вы уверены, что хотите отменить заказ?',
      name: 'cancel_order_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Попробуйте снова`
  String get try_again {
    return Intl.message(
      'Попробуйте снова',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Извините, произошла ошибка. Мы уже работаем над её исправлением. Попробуйте ещё раз позже.`
  String get error_message {
    return Intl.message(
      'Извините, произошла ошибка. Мы уже работаем над её исправлением. Попробуйте ещё раз позже.',
      name: 'error_message',
      desc: '',
      args: [],
    );
  }

  /// `Минимальная сумма заказа: {price} тг`
  String minimum_order_amount(Object price) {
    return Intl.message(
      'Минимальная сумма заказа: $price тг',
      name: 'minimum_order_amount',
      desc: '',
      args: [price],
    );
  }

  /// `Сегодня`
  String get today {
    return Intl.message('Сегодня', name: 'today', desc: '', args: []);
  }

  /// `Завтра`
  String get tomorrow {
    return Intl.message('Завтра', name: 'tomorrow', desc: '', args: []);
  }

  /// `Товара нет в наличии`
  String get out_of_stock {
    return Intl.message(
      'Товара нет в наличии',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `Обновление корзины`
  String get cart_update {
    return Intl.message(
      'Обновление корзины',
      name: 'cart_update',
      desc: '',
      args: [],
    );
  }

  /// `Товары, которые недоступны:`
  String get inactive_products {
    return Intl.message(
      'Товары, которые недоступны:',
      name: 'inactive_products',
      desc: '',
      args: [],
    );
  }

  /// `Товары, которых нет на складе:`
  String get removed_products {
    return Intl.message(
      'Товары, которых нет на складе:',
      name: 'removed_products',
      desc: '',
      args: [],
    );
  }

  /// `Осталось:`
  String get remaining {
    return Intl.message('Осталось:', name: 'remaining', desc: '', args: []);
  }

  /// `Количество товара было изменено:`
  String get changed_quantity {
    return Intl.message(
      'Количество товара было изменено:',
      name: 'changed_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Недостаточно товаров на складе`
  String get insufficient_stock {
    return Intl.message(
      'Недостаточно товаров на складе',
      name: 'insufficient_stock',
      desc: '',
      args: [],
    );
  }

  /// `Оплата`
  String get payment {
    return Intl.message('Оплата', name: 'payment', desc: '', args: []);
  }

  /// `шт`
  String get pcs {
    return Intl.message('шт', name: 'pcs', desc: '', args: []);
  }

  /// `Написать`
  String get write {
    return Intl.message('Написать', name: 'write', desc: '', args: []);
  }

  /// `Оплата банковской картой`
  String get card_pay {
    return Intl.message(
      'Оплата банковской картой',
      name: 'card_pay',
      desc: '',
      args: [],
    );
  }

  /// `Для удаления аккаунта напишите нам на почту support@example.com. Ваш запрос будет обработан в ближайшее время.`
  String get write_message {
    return Intl.message(
      'Для удаления аккаунта напишите нам на почту support@example.com. Ваш запрос будет обработан в ближайшее время.',
      name: 'write_message',
      desc: '',
      args: [],
    );
  }

  /// `Запрос на удаление аккаунта`
  String get delete_account_email_subject {
    return Intl.message(
      'Запрос на удаление аккаунта',
      name: 'delete_account_email_subject',
      desc: '',
      args: [],
    );
  }

  /// `Здравствуйте, я хочу удалить свой аккаунт. Пожалуйста, удалите мой аккаунт.\n\nМой номер: `
  String get delete_account_email_body {
    return Intl.message(
      'Здравствуйте, я хочу удалить свой аккаунт. Пожалуйста, удалите мой аккаунт.\n\nМой номер: ',
      name: 'delete_account_email_body',
      desc: '',
      args: [],
    );
  }

  /// `НЕТ В НАЛИЧИИ`
  String get out_stock {
    return Intl.message('НЕТ В НАЛИЧИИ', name: 'out_stock', desc: '', args: []);
  }

  /// `Что-то пошло не так, попробуйте еще раз`
  String get errorPlsAgain {
    return Intl.message(
      'Что-то пошло не так, попробуйте еще раз',
      name: 'errorPlsAgain',
      desc: '',
      args: [],
    );
  }

  /// `Оплата не прошла или была отменена. Попробуйте снова.`
  String get payFailed {
    return Intl.message(
      'Оплата не прошла или была отменена. Попробуйте снова.',
      name: 'payFailed',
      desc: '',
      args: [],
    );
  }

  /// `Сохранение карты`
  String get saveCard {
    return Intl.message(
      'Сохранение карты',
      name: 'saveCard',
      desc: '',
      args: [],
    );
  }

  /// `Данные карты успешно сохранены`
  String get saveCardSuccess {
    return Intl.message(
      'Данные карты успешно сохранены',
      name: 'saveCardSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Доступно обновление`
  String get update_available {
    return Intl.message(
      'Доступно обновление',
      name: 'update_available',
      desc: '',
      args: [],
    );
  }

  /// `В Grocery App новые функции и улучшения. Обновитесь, чтобы не пропустить важное!`
  String get update_message {
    return Intl.message(
      'В Grocery App новые функции и улучшения. Обновитесь, чтобы не пропустить важное!',
      name: 'update_message',
      desc: '',
      args: [],
    );
  }

  /// `Обновить приложение`
  String get update_button {
    return Intl.message(
      'Обновить приложение',
      name: 'update_button',
      desc: '',
      args: [],
    );
  }

  /// `Ваши карты`
  String get your_cards {
    return Intl.message('Ваши карты', name: 'your_cards', desc: '', args: []);
  }

  /// `Добавить новую карту`
  String get add_new_card {
    return Intl.message(
      'Добавить новую карту',
      name: 'add_new_card',
      desc: '',
      args: [],
    );
  }

  /// `Максимальное количество карт`
  String get max_number_of_cards {
    return Intl.message(
      'Максимальное количество карт',
      name: 'max_number_of_cards',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет сохранённых карт`
  String get no_saved_cards {
    return Intl.message(
      'У вас нет сохранённых карт',
      name: 'no_saved_cards',
      desc: '',
      args: [],
    );
  }

  /// `Ваши карты будут храниться здесь`
  String get cards_will_be_stored_here {
    return Intl.message(
      'Ваши карты будут храниться здесь',
      name: 'cards_will_be_stored_here',
      desc: '',
      args: [],
    );
  }

  /// `Выберите способ оплаты`
  String get select_payment_method {
    return Intl.message(
      'Выберите способ оплаты',
      name: 'select_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, заполните поле кв/офис`
  String get fillHouse {
    return Intl.message(
      'Пожалуйста, заполните поле кв/офис',
      name: 'fillHouse',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, заполните поле подъезда`
  String get fillEntrance {
    return Intl.message(
      'Пожалуйста, заполните поле подъезда',
      name: 'fillEntrance',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, заполните поле этажа`
  String get fillFloor {
    return Intl.message(
      'Пожалуйста, заполните поле этажа',
      name: 'fillFloor',
      desc: '',
      args: [],
    );
  }

  /// `Электронная почта`
  String get email {
    return Intl.message('Электронная почта', name: 'email', desc: '', args: []);
  }

  /// `Пожалуйста, укажите ваше имя, фамилию и email. Эти данные необходимы для оформления заказа и отправки чеков.`
  String get enter_name_surname_email {
    return Intl.message(
      'Пожалуйста, укажите ваше имя, фамилию и email. Эти данные необходимы для оформления заказа и отправки чеков.',
      name: 'enter_name_surname_email',
      desc: '',
      args: [],
    );
  }

  /// `🔧 Технические работы`
  String get maintenance_title {
    return Intl.message(
      '🔧 Технические работы',
      name: 'maintenance_title',
      desc: '',
      args: [],
    );
  }

  /// `Мы проводим обновление системы для улучшения работы сервиса. Пожалуйста, попробуйте зайти позже. Спасибо за понимание!`
  String get maintenance_description {
    return Intl.message(
      'Мы проводим обновление системы для улучшения работы сервиса. Пожалуйста, попробуйте зайти позже. Спасибо за понимание!',
      name: 'maintenance_description',
      desc: '',
      args: [],
    );
  }

  /// `Проверить статус`
  String get check_status {
    return Intl.message(
      'Проверить статус',
      name: 'check_status',
      desc: '',
      args: [],
    );
  }

  /// `Технические работы все еще продолжаются`
  String get technicalStill {
    return Intl.message(
      'Технические работы все еще продолжаются',
      name: 'technicalStill',
      desc: '',
      args: [],
    );
  }

  /// `Неверный формат электронной почты. Пример: example@mail.com`
  String get email_invalid {
    return Intl.message(
      'Неверный формат электронной почты. Пример: example@mail.com',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Аккаунт заблокирован.`
  String get account_blocked {
    return Intl.message(
      'Аккаунт заблокирован.',
      name: 'account_blocked',
      desc: '',
      args: [],
    );
  }

  /// `Для выяснения причин свяжитесь с администрацией приложения.`
  String get contact_admin {
    return Intl.message(
      'Для выяснения причин свяжитесь с администрацией приложения.',
      name: 'contact_admin',
      desc: '',
      args: [],
    );
  }

  /// `Мы временно не принимаем заказы`
  String get temporarily_not_accepting_orders {
    return Intl.message(
      'Мы временно не принимаем заказы',
      name: 'temporarily_not_accepting_orders',
      desc: '',
      args: [],
    );
  }

  /// `Связаться с нами`
  String get contactUs {
    return Intl.message(
      'Связаться с нами',
      name: 'contactUs',
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
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
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
