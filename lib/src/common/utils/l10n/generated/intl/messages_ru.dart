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

  static String m0(sum) => "Подтвердить заказ: ${sum} ₸";

  static String m1(sum) => "Перейти к оформлению: ${sum} ₸";

  static String m2(price) => "Минимальная сумма заказа: ${price} тг";

  static String m3(time) =>
      "Завершите оплату в течение ${time} или заказ будет отменён";

  static String m4(num) => "Код выслан на ${num}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abricoz": MessageLookupByLibrary.simpleMessage("Abricoz"),
        "activeOrder": MessageLookupByLibrary.simpleMessage("Активный заказ"),
        "addAddress": MessageLookupByLibrary.simpleMessage("Добавить адрес"),
        "addNewAddress":
            MessageLookupByLibrary.simpleMessage("Добавить новый адрес"),
        "addNewCard":
            MessageLookupByLibrary.simpleMessage("Добавить новую карту"),
        "add_new_card":
            MessageLookupByLibrary.simpleMessage("Добавить новую карту"),
        "address": MessageLookupByLibrary.simpleMessage("Адреса"),
        "addressSaveHere": MessageLookupByLibrary.simpleMessage(
            "Ваши адреса будут храниться здесь"),
        "againOtherWord": MessageLookupByLibrary.simpleMessage(
            "Попробуйте другие ключевые слова или проверьте правильность ввода"),
        "allProducts": MessageLookupByLibrary.simpleMessage("Все товары"),
        "and": MessageLookupByLibrary.simpleMessage(" и "),
        "appLanguage": MessageLookupByLibrary.simpleMessage("Язык приложения"),
        "back": MessageLookupByLibrary.simpleMessage("Назад"),
        "bannerLocal": MessageLookupByLibrary.simpleMessage(
            "Заказывайте клубнику в новом приложении от Abricoz!"),
        "basket": MessageLookupByLibrary.simpleMessage("Корзина"),
        "basketEmpty":
            MessageLookupByLibrary.simpleMessage("Ваша корзина пуста"),
        "brand": MessageLookupByLibrary.simpleMessage("Бренд"),
        "calories": MessageLookupByLibrary.simpleMessage("ккал"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "cancelOrder": MessageLookupByLibrary.simpleMessage("Отменить заказ"),
        "cancel_order_confirmation": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите отменить заказ?"),
        "canceled": MessageLookupByLibrary.simpleMessage("Отменён"),
        "carbohydrates": MessageLookupByLibrary.simpleMessage("углеводы"),
        "card_pay":
            MessageLookupByLibrary.simpleMessage("Оплата банковской картой"),
        "cards_will_be_stored_here": MessageLookupByLibrary.simpleMessage(
            "Ваши карты будут храниться здесь"),
        "cart_update":
            MessageLookupByLibrary.simpleMessage("Обновление корзины"),
        "carts": MessageLookupByLibrary.simpleMessage("Карты"),
        "cashToCourier":
            MessageLookupByLibrary.simpleMessage("Наличными курьеру"),
        "catalog": MessageLookupByLibrary.simpleMessage("Каталог"),
        "category": MessageLookupByLibrary.simpleMessage("Категории"),
        "changeAddress":
            MessageLookupByLibrary.simpleMessage("Изменить список адресов"),
        "changed_quantity": MessageLookupByLibrary.simpleMessage(
            "Количество товара было изменено:"),
        "check_status":
            MessageLookupByLibrary.simpleMessage("Проверить статус"),
        "city": MessageLookupByLibrary.simpleMessage("Город"),
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "commentToAddress":
            MessageLookupByLibrary.simpleMessage("Комментарий к адресу"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "confirmPay": m0,
        "consent_to_personal_data_processing":
            MessageLookupByLibrary.simpleMessage(
                "Согласие на обработку персональных данных"),
        "continueAgree": MessageLookupByLibrary.simpleMessage(
            "Продолжая, вы соглашаетесь с "),
        "createDate": MessageLookupByLibrary.simpleMessage("Дата оформления"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Удалить аккаунт?"),
        "deleteAccountSure": MessageLookupByLibrary.simpleMessage(
            "Вы точно хотите удалить аккаунт?"),
        "deleteAddress": MessageLookupByLibrary.simpleMessage(
            "Этот адрес больше не нужен? Прощаться всегда непросто."),
        "deleteAllBasket": MessageLookupByLibrary.simpleMessage(
            "Удалить выбранные товары из корзины?"),
        "delete_account_email_body": MessageLookupByLibrary.simpleMessage(
            "Здравствуйте, я хочу удалить свой аккаунт. Пожалуйста, удалите мой аккаунт.\n\nМой номер: "),
        "delete_account_email_subject":
            MessageLookupByLibrary.simpleMessage("Запрос на удаление аккаунта"),
        "delivered": MessageLookupByLibrary.simpleMessage("Доставлен"),
        "delivery30min":
            MessageLookupByLibrary.simpleMessage("Доставка от 30 минут"),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("Адрес доставки"),
        "deliveryBefore": MessageLookupByLibrary.simpleMessage("Доставка до"),
        "deliveryDate":
            MessageLookupByLibrary.simpleMessage("Дата и время доставки"),
        "deliveryPrice":
            MessageLookupByLibrary.simpleMessage("Стоимость доставки"),
        "deliveryTime": MessageLookupByLibrary.simpleMessage("Время доставки"),
        "deliveryTo": MessageLookupByLibrary.simpleMessage("Доставка до"),
        "description": MessageLookupByLibrary.simpleMessage("Описание"),
        "district": MessageLookupByLibrary.simpleMessage("Район"),
        "editAddress":
            MessageLookupByLibrary.simpleMessage("Редактировать адрес"),
        "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
        "email_invalid": MessageLookupByLibrary.simpleMessage(
            "Неверный формат электронной почты. Пример: example@mail.com"),
        "empty": MessageLookupByLibrary.simpleMessage("Пусто"),
        "enterCode":
            MessageLookupByLibrary.simpleMessage("Введите код подтверждения"),
        "enterName":
            MessageLookupByLibrary.simpleMessage("Введите имя и фамилию"),
        "enterNum": MessageLookupByLibrary.simpleMessage(
            "Введите номер телефона для продолжения"),
        "enter_name_surname_email": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, укажите ваше имя, фамилию и email. Эти данные необходимы для оформления заказа и отправки чеков."),
        "entrance": MessageLookupByLibrary.simpleMessage("Подъезд"),
        "errorPlsAgain": MessageLookupByLibrary.simpleMessage(
            "Что-то пошло не так, попробуйте еще раз"),
        "error_message": MessageLookupByLibrary.simpleMessage(
            "Извините, произошла ошибка. Мы уже работаем над её исправлением. Попробуйте ещё раз позже."),
        "fats": MessageLookupByLibrary.simpleMessage("жиры"),
        "favorite": MessageLookupByLibrary.simpleMessage("Избранное"),
        "favoriteEmpty": MessageLookupByLibrary.simpleMessage(
            "Список избранных товаров пуст"),
        "fillEntrance": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, заполните поле подъезда"),
        "fillFloor": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, заполните поле этажа"),
        "fillHouse": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, заполните поле кв/офис"),
        "fillName": MessageLookupByLibrary.simpleMessage(
            "Заполните поля \"Имя\" и \"Фамилия\""),
        "floor": MessageLookupByLibrary.simpleMessage("Этаж"),
        "getNewSms": MessageLookupByLibrary.simpleMessage("Получить новый код"),
        "getSms": MessageLookupByLibrary.simpleMessage("Получить код"),
        "getSmsTime": MessageLookupByLibrary.simpleMessage(
            "Получить новый код можно через"),
        "go": MessageLookupByLibrary.simpleMessage("Перейти"),
        "goToBasket": MessageLookupByLibrary.simpleMessage("Перейти в корзину"),
        "goToPay": m1,
        "goToProducts":
            MessageLookupByLibrary.simpleMessage("Перейти к покупкам"),
        "hereWillFavorite": MessageLookupByLibrary.simpleMessage(
            "Здесь будут отображаться лайкнутые вами товары"),
        "hereWillProduct": MessageLookupByLibrary.simpleMessage(
            "Здесь будут лежать товары для покупки"),
        "in100gr": MessageLookupByLibrary.simpleMessage("В 100 граммах"),
        "inactive_products":
            MessageLookupByLibrary.simpleMessage("Товары, которые недоступны:"),
        "incorrectNum":
            MessageLookupByLibrary.simpleMessage("Некорректный номер телефона"),
        "info": MessageLookupByLibrary.simpleMessage("Информация"),
        "insufficient_stock": MessageLookupByLibrary.simpleMessage(
            "Недостаточно товаров на складе"),
        "itemList": MessageLookupByLibrary.simpleMessage("Список товаров"),
        "lastOrderWillHere": MessageLookupByLibrary.simpleMessage(
            "Здесь будут отображаться ваши\nпоследние заказы"),
        "login": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginAccount": MessageLookupByLibrary.simpleMessage("Войти в аккаунт"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "main": MessageLookupByLibrary.simpleMessage("Главная"),
        "maintenance_description": MessageLookupByLibrary.simpleMessage(
            "Мы проводим обновление системы для улучшения работы сервиса. Пожалуйста, попробуйте зайти позже. Спасибо за понимание!"),
        "maintenance_title":
            MessageLookupByLibrary.simpleMessage("🔧 Технические работы"),
        "makeOrder": MessageLookupByLibrary.simpleMessage("Оформление заказа"),
        "maker": MessageLookupByLibrary.simpleMessage("Производитель"),
        "max_number_of_cards": MessageLookupByLibrary.simpleMessage(
            "Максимальное количество карт"),
        "minimum_order_amount": m2,
        "mustFill": MessageLookupByLibrary.simpleMessage(
            "Поле обязательно для заполнения"),
        "myOrders": MessageLookupByLibrary.simpleMessage("Мои заказы"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "noAddress": MessageLookupByLibrary.simpleMessage("У вас нет адресов"),
        "no_saved_cards":
            MessageLookupByLibrary.simpleMessage("У вас нет сохранённых карт"),
        "nonAuthorizedText": MessageLookupByLibrary.simpleMessage(
            "Эта опция доступна для авторизованных пользователей"),
        "notActive": MessageLookupByLibrary.simpleMessage("Неактивен"),
        "notAvailableNow": MessageLookupByLibrary.simpleMessage(
            "Сейчас нет доступного времени"),
        "notDeliverPlace": MessageLookupByLibrary.simpleMessage(
            "Доставка в этот регион не осуществляется"),
        "notFound": MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
        "office": MessageLookupByLibrary.simpleMessage("Кв/офис"),
        "order": MessageLookupByLibrary.simpleMessage("Заказ"),
        "orderAgain": MessageLookupByLibrary.simpleMessage("Повторить заказ"),
        "orderCancel": MessageLookupByLibrary.simpleMessage(
            "Отмена заказа? Ваши покупки почти отправились в путь!"),
        "orderCanceled": MessageLookupByLibrary.simpleMessage(
            "Заказ был отменён по инициативе пользователя"),
        "orderEmpty":
            MessageLookupByLibrary.simpleMessage("Список заказов пуст"),
        "orderHistory": MessageLookupByLibrary.simpleMessage("История заказов"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("Номер заказа"),
        "order_info":
            MessageLookupByLibrary.simpleMessage("Информация о заказе"),
        "order_status": MessageLookupByLibrary.simpleMessage("Статус заказа"),
        "orders": MessageLookupByLibrary.simpleMessage("Заказы"),
        "otherCategory":
            MessageLookupByLibrary.simpleMessage("Попробуйте другие категории"),
        "ourProduct": MessageLookupByLibrary.simpleMessage("Наши продукты"),
        "out_of_stock":
            MessageLookupByLibrary.simpleMessage("Товара нет в наличии"),
        "out_stock": MessageLookupByLibrary.simpleMessage("НЕТ В НАЛИЧИИ"),
        "payFailed": MessageLookupByLibrary.simpleMessage(
            "Оплата не прошла или была отменена. Попробуйте снова."),
        "payOrder": MessageLookupByLibrary.simpleMessage("Оплатить заказ"),
        "paySum": MessageLookupByLibrary.simpleMessage("Сумма к оплате"),
        "payTime": m3,
        "payTimeFinish": MessageLookupByLibrary.simpleMessage(
            "Время на оплату истекло, заказ в процессе отмены"),
        "payment": MessageLookupByLibrary.simpleMessage("Оплата"),
        "paymentOrder": MessageLookupByLibrary.simpleMessage("Оплата заказа"),
        "paymentStatus": MessageLookupByLibrary.simpleMessage("Статус оплаты"),
        "paymentType": MessageLookupByLibrary.simpleMessage("Способ оплаты"),
        "pcs": MessageLookupByLibrary.simpleMessage("шт"),
        "personalData": MessageLookupByLibrary.simpleMessage("Личные данные"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "pinError": MessageLookupByLibrary.simpleMessage(
            "PIN-код не верен, либо истёк."),
        "privacyPol":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Политикой конфиденциальности"),
        "processCancel":
            MessageLookupByLibrary.simpleMessage("В процессе отмены"),
        "processing": MessageLookupByLibrary.simpleMessage("Обработка"),
        "products": MessageLookupByLibrary.simpleMessage("Продукты"),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "proteins": MessageLookupByLibrary.simpleMessage("белки"),
        "public_offer":
            MessageLookupByLibrary.simpleMessage("Публичная оферта"),
        "remaining": MessageLookupByLibrary.simpleMessage("Осталось:"),
        "removed_products": MessageLookupByLibrary.simpleMessage(
            "Товары, которых нет на складе:"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "saveCard": MessageLookupByLibrary.simpleMessage("Сохранение карты"),
        "saveCardSuccess": MessageLookupByLibrary.simpleMessage(
            "Данные карты успешно сохранены"),
        "searchItem": MessageLookupByLibrary.simpleMessage("Поиск товара"),
        "select": MessageLookupByLibrary.simpleMessage("Выбрать адрес"),
        "selectAddress":
            MessageLookupByLibrary.simpleMessage("Укажите адрес доставки"),
        "selectAddressPlease":
            MessageLookupByLibrary.simpleMessage("Выберите адрес доставки"),
        "selectCity": MessageLookupByLibrary.simpleMessage("Укажите город"),
        "selectPaymentPlease":
            MessageLookupByLibrary.simpleMessage("Выберите способ оплаты"),
        "selectTimePlease":
            MessageLookupByLibrary.simpleMessage("Выберите время доставки"),
        "select_payment_method":
            MessageLookupByLibrary.simpleMessage("Выберите способ оплаты"),
        "sentTo": m4,
        "signIn": MessageLookupByLibrary.simpleMessage("Вход в аккаунт"),
        "somethingError":
            MessageLookupByLibrary.simpleMessage("Что-то пошло не так"),
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "street": MessageLookupByLibrary.simpleMessage("Улица, дом*"),
        "sureLogout": MessageLookupByLibrary.simpleMessage(
            "Вы точно хотите выйти? Мы будем скучать."),
        "surname": MessageLookupByLibrary.simpleMessage("Фамилия"),
        "technicalStill": MessageLookupByLibrary.simpleMessage(
            "Технические работы все еще продолжаются"),
        "thanksForOrder": MessageLookupByLibrary.simpleMessage(
            "Спасибо за покупку! Мы свяжемся с вами с деталями для доставки"),
        "toBasket": MessageLookupByLibrary.simpleMessage("В корзину"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "totalSum": MessageLookupByLibrary.simpleMessage("Итоговая сумма"),
        "try_again": MessageLookupByLibrary.simpleMessage("Попробуйте снова"),
        "update_available":
            MessageLookupByLibrary.simpleMessage("Доступно обновление"),
        "update_button":
            MessageLookupByLibrary.simpleMessage("Обновить приложение"),
        "update_message": MessageLookupByLibrary.simpleMessage(
            "В Abricoz новые функции и улучшения. Обновитесь, чтобы не пропустить важное!"),
        "userAgre":
            MessageLookupByLibrary.simpleMessage("Пользовательское соглашение"),
        "userAgreement": MessageLookupByLibrary.simpleMessage(
            "Пользовательским соглашением"),
        "version": MessageLookupByLibrary.simpleMessage("Версия"),
        "wait": MessageLookupByLibrary.simpleMessage("Ожидание"),
        "welcome": MessageLookupByLibrary.simpleMessage("Добро пожаловать в "),
        "write": MessageLookupByLibrary.simpleMessage("Написать"),
        "write_message": MessageLookupByLibrary.simpleMessage(
            "Для удаления аккаунта напишите нам на почту info@abricoz.kz. Ваш запрос будет обработан в ближайшее время."),
        "wrongCurrentPass":
            MessageLookupByLibrary.simpleMessage("Текущий пароль неверен"),
        "yourAddress": MessageLookupByLibrary.simpleMessage("Ваши адреса"),
        "your_cards": MessageLookupByLibrary.simpleMessage("Ваши карты")
      };
}
