// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(price, period) => "от ${price} тг/${period}";

  static String m1(num) => "Код выслан на ${num}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abricoz": MessageLookupByLibrary.simpleMessage("Abricoz"),
        "address": MessageLookupByLibrary.simpleMessage("Адреса"),
        "againOtherWord": MessageLookupByLibrary.simpleMessage(
            "Попробуйте другие ключевые слова или проверьте правильность ввода"),
        "and": MessageLookupByLibrary.simpleMessage(" и "),
        "back": MessageLookupByLibrary.simpleMessage("Назад"),
        "basket": MessageLookupByLibrary.simpleMessage("Корзина"),
        "basketEmpty":
            MessageLookupByLibrary.simpleMessage("Ваша корзина пуста"),
        "brand": MessageLookupByLibrary.simpleMessage("Бренд"),
        "calories": MessageLookupByLibrary.simpleMessage("ккал"),
        "carbohydrates": MessageLookupByLibrary.simpleMessage("углеводы"),
        "carts": MessageLookupByLibrary.simpleMessage("Карты"),
        "catalog": MessageLookupByLibrary.simpleMessage("Каталог"),
        "category": MessageLookupByLibrary.simpleMessage("Категории"),
        "continueAgree": MessageLookupByLibrary.simpleMessage(
            "Продолжая, вы соглашаетесь с "),
        "deliveryTo": MessageLookupByLibrary.simpleMessage("Доставка до"),
        "description": MessageLookupByLibrary.simpleMessage("Описание"),
        "empty": MessageLookupByLibrary.simpleMessage("Пусто"),
        "enterCode":
            MessageLookupByLibrary.simpleMessage("Введите код подтверждения"),
        "enterNum": MessageLookupByLibrary.simpleMessage(
            "Введите номер телефона для продолжения"),
        "fats": MessageLookupByLibrary.simpleMessage("жиры"),
        "favorite": MessageLookupByLibrary.simpleMessage("Избранное"),
        "favoriteEmpty": MessageLookupByLibrary.simpleMessage(
            "Список избранных товаров пуст"),
        "getNewSms": MessageLookupByLibrary.simpleMessage("Получить новый код"),
        "getSms": MessageLookupByLibrary.simpleMessage("Получить код"),
        "getSmsTime": MessageLookupByLibrary.simpleMessage(
            "Получить новый код можно через"),
        "gmail": MessageLookupByLibrary.simpleMessage("example@mail.com"),
        "hereWillFavorite": MessageLookupByLibrary.simpleMessage(
            "Здесь будут отображаться лайкнутые вами товары"),
        "hereWillProduct": MessageLookupByLibrary.simpleMessage(
            "Здесь будут лежать товары для покупки"),
        "in100gr": MessageLookupByLibrary.simpleMessage("В 100 граммах"),
        "incorrectNum":
            MessageLookupByLibrary.simpleMessage("Некорректный номер телефона"),
        "login": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginAccount": MessageLookupByLibrary.simpleMessage("Войти в аккаунт"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "main": MessageLookupByLibrary.simpleMessage("Главная"),
        "maker": MessageLookupByLibrary.simpleMessage("Производитель"),
        "mustFill": MessageLookupByLibrary.simpleMessage(
            "Поле обязательно для заполнения"),
        "notFound": MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
        "orderHistory": MessageLookupByLibrary.simpleMessage("История заказов"),
        "orders": MessageLookupByLibrary.simpleMessage("Заказы"),
        "ourProduct": MessageLookupByLibrary.simpleMessage("Наши продукты"),
        "personalData": MessageLookupByLibrary.simpleMessage("Личные данные"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "pinError": MessageLookupByLibrary.simpleMessage(
            "PIN-код не верен, либо истёк."),
        "price": m0,
        "privacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Политикой конфиденциальности"),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "proteins": MessageLookupByLibrary.simpleMessage("белки"),
        "searchItem": MessageLookupByLibrary.simpleMessage("Поиск товара"),
        "selectAddress":
            MessageLookupByLibrary.simpleMessage("Укажите адрес доставки"),
        "sentTo": m1,
        "signIn": MessageLookupByLibrary.simpleMessage("Вход в аккаунт"),
        "somethingError":
            MessageLookupByLibrary.simpleMessage("Что-то пошло не так"),
        "toBasket": MessageLookupByLibrary.simpleMessage("В корзину"),
        "userAgreement": MessageLookupByLibrary.simpleMessage(
            "Пользовательским соглашением"),
        "welcome": MessageLookupByLibrary.simpleMessage("Добро пожаловать в "),
        "wrongCurrentPass":
            MessageLookupByLibrary.simpleMessage("Текущий пароль неверен")
      };
}
