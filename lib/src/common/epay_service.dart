import 'dart:convert';
import 'dart:developer';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart'; // ✅ Correct import for RSAPublicKey
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:http/http.dart' as http;

class EpayService {
  final String _tokenUrl = "https://epay-oauth.homebank.kz/oauth2/token";
  final String _saveCardUrl = "https://epay-api.homebank.kz/payment/cryptopay";
  final String _paymentUrl = "https://epay-api.homebank.kz/payments/cards/auth";
  final String _publicKeyUrl = "https://epay-api.homebank.kz/public.rsa";

  final String _clientId = "ABRICOZ"; // Ваш Client ID
  final String _clientSecret = "p54uhaSO!3KNhZt3"; // Ваш Client Secret
  final String _terminalId = "661b56fc-f3cf-494b-bc8e-0108c484b4aa"; // Ваш Terminal ID
  //final String _terminalId = "98957191"; // Ваш Terminal ID

  String? _accessToken; // Кешируем токен

  /// Получает новый Access Token перед каждым платежом
  Future<void> _fetchAccessToken({required String invoiceId}) async {
    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "grant_type": "client_credentials",
          "scope": "webapi usermanagement email_send verification statement statistics payment",
          "client_id": _clientId,
          "client_secret": _clientSecret,
          "invoiceID": invoiceId,
          "amount": "5",
          "currency": "KZT",
          "terminal": _terminalId,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _accessToken = data["access_token"];
      } else {
        throw Exception("Ошибка получения токена: ${response.body}");
      }
    } catch (e) {
      print("Ошибка сети: $e");
      throw Exception("Ошибка сети: $e");
    }
  }

  /// Шифрует данные карты перед отправкой
  Future<String> encryptCardData({
    required String cardNumber,
    required String expDate,
    required String cvc,
  }) async {
    try {
      // Запрос RSA-ключа
      final response = await http.get(Uri.parse(_publicKeyUrl));
      if (response.statusCode != 200) throw Exception("Ошибка получения публичного ключа");

      final publicKeyPem = response.body;
      final parser = RSAKeyParser();
      final RSAAsymmetricKey key = parser.parse(publicKeyPem);
      final RSAPublicKey publicKey = key as RSAPublicKey;
      final encrypter = Encrypter(RSA(publicKey: publicKey));

      // Формируем JSON объект
      final Map<String, String> cardData = {
        "hpan": cardNumber,
        "expDate": expDate,
        "cvc": cvc,
        "terminalId": _terminalId,
      };

      // Кодируем в JSON и шифруем
      final encrypted = encrypter.encrypt(jsonEncode(cardData));
      return base64Encode(encrypted.bytes);
    } catch (e) {
      throw Exception("Ошибка шифрования: $e");
    }
  }

  Future<Map<String, dynamic>> getIpDetails() async {
    try {
      final response = await http.get(Uri.parse("https://ipinfo.io/json"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loc = (data["loc"] as String?)?.split(",") ?? ["0", "0"];

        return {
          "ip": data["ip"] ?? "0.0.0.0",
          "ipCountry": data["country"] ?? "Unknown",
          "ipCity": data["city"] ?? "Unknown",
          "ipDistrict": data["region"] ?? "Unknown",
          "ipRegion": data["region"] ?? "Unknown",
          "ipLatitude": loc[0],
          "ipLongitude": loc[1],
        };
      }
    } catch (e) {
      print("IP Fetch Error: $e");
    }
    return {};
  }

  /// Сохраняет карту пользователя
  Future<Map<String, dynamic>> saveCard({
    required String encryptedCryptogram,
    required String invoiceId,
    required String name,
    required String email,
    required String phone,
  }) async {
    // Получаем новый токен
    await _fetchAccessToken(invoiceId: invoiceId);

    final Map<String, dynamic> ipDetails = await getIpDetails();

    final Map<String, dynamic> requestBody = {
      "amount": 5,
      "currency": "KZT",
      "name": name,
      "cryptogram": encryptedCryptogram,
      "invoiceId": invoiceId,
      "description": "Сохранение карты",
      "cardSave": true,
      "email": email,
      "phone": phone,
      "qrReference": '',
      "amountBonus": 0,
      "ip": ipDetails["ip"],
      "ipCountry": ipDetails["ipCountry"],
      "ipCity": ipDetails["ipCity"],
      "ipDistrict": ipDetails["ipDistrict"],
      "ipLatitude": ipDetails["ipLatitude"],
      "ipRegion": ipDetails["ipRegion"],
      "ipLongitude": ipDetails["ipLongitude"],
      "issuerBankCountry": "Kazakhstan",
    };

    try {
      final response = await http.post(
        Uri.parse(_saveCardUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_accessToken",
        },
        body: jsonEncode(requestBody),
      );

      final jsonString = const JsonEncoder.withIndent('  ').convert(requestBody);
      log(jsonString, name: 'Send Json Data');


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Ошибка сохранения карты: ${response.body}");
      }
    } catch (e) {
      print("Ошибка сети: $e");
      throw Exception("Ошибка сети: $e");
    }
  }


  Future<Map<String, dynamic>> processPayment({
    required String cardId,
    required int amount,
    required String invoiceId,
    required String accountId,
    required String email,
    required String phone,
  }) async {
    final String postLink = "https://yourwebsite.com/payment_success";
    final String failurePostLink = "https://yourwebsite.com/payment_failed";
    final String backLink = "https://yourwebsite.com/back";
    final String failureBackLink = "https://yourwebsite.com/fail";
    final String language = "rus";

    // ✅ Fetch new access token
    await _fetchAccessToken(invoiceId: invoiceId);

    final Map<String, dynamic> requestBody = {
      "amount": amount,
      "currency": "KZT",
      "name": "TEST TEST",
      "terminalId": _terminalId,
      "invoiceId": invoiceId,
      "invoiceIdAlt": invoiceId, // Alternative ID
      "description": "Payment for services",
      "accountId": accountId,
      "email": email,
      "phone": phone,
      "backLink": backLink,
      "failureBackLink": failureBackLink,
      "postLink": postLink,
      "failurePostLink": failurePostLink,
      "language": language,
      "paymentType": "cardId",
      "cardId": {
        "id": cardId, // ✅ Card ID received during saving
      }
    };

    try {
      final response = await http.post(
        Uri.parse(_paymentUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_accessToken",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Payment Failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error processing payment: $e");
    }
  }
}
