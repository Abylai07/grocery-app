// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(sum) => "Confirm order: ${sum} ₸";

  static String m1(sum) => "Proceed to checkout: ${sum} ₸";

  static String m2(price) => "Minimum order amount: ${price} KZT";

  static String m3(time) =>
      "Complete payment within ${time} or the order will be canceled";

  static String m4(num) => "Code sent to ${num}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "abricoz": MessageLookupByLibrary.simpleMessage("Grocery App"),
    "account_blocked": MessageLookupByLibrary.simpleMessage(
      "Account is blocked.",
    ),
    "activeOrder": MessageLookupByLibrary.simpleMessage("Active order"),
    "addAddress": MessageLookupByLibrary.simpleMessage("Add address"),
    "addNewAddress": MessageLookupByLibrary.simpleMessage("Add new address"),
    "addNewCard": MessageLookupByLibrary.simpleMessage("Add new card"),
    "add_new_card": MessageLookupByLibrary.simpleMessage("Add a new card"),
    "address": MessageLookupByLibrary.simpleMessage("Addresses"),
    "addressSaveHere": MessageLookupByLibrary.simpleMessage(
      "Your addresses will be saved here",
    ),
    "againOtherWord": MessageLookupByLibrary.simpleMessage(
      "Try other keywords or check the spelling",
    ),
    "allProducts": MessageLookupByLibrary.simpleMessage("All products"),
    "and": MessageLookupByLibrary.simpleMessage(" and "),
    "appLanguage": MessageLookupByLibrary.simpleMessage("App language"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "bannerLocal": MessageLookupByLibrary.simpleMessage(
      "Order fresh strawberries in our new app!",
    ),
    "basket": MessageLookupByLibrary.simpleMessage("Basket"),
    "basketEmpty": MessageLookupByLibrary.simpleMessage("Your basket is empty"),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "calories": MessageLookupByLibrary.simpleMessage("calories"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel order"),
    "cancel_order_confirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel the order?",
    ),
    "canceled": MessageLookupByLibrary.simpleMessage("Canceled"),
    "carbohydrates": MessageLookupByLibrary.simpleMessage("carbohydrates"),
    "card_pay": MessageLookupByLibrary.simpleMessage("Payment by bank card"),
    "cards_will_be_stored_here": MessageLookupByLibrary.simpleMessage(
      "Your cards will be stored here",
    ),
    "cart_update": MessageLookupByLibrary.simpleMessage("Cart Update"),
    "carts": MessageLookupByLibrary.simpleMessage("Cards"),
    "cashToCourier": MessageLookupByLibrary.simpleMessage("In Cash/Kaspi QR"),
    "catalog": MessageLookupByLibrary.simpleMessage("Catalog"),
    "category": MessageLookupByLibrary.simpleMessage("Categories"),
    "changeAddress": MessageLookupByLibrary.simpleMessage(
      "Change address list",
    ),
    "changed_quantity": MessageLookupByLibrary.simpleMessage(
      "The quantity of the product has been changed:",
    ),
    "check_status": MessageLookupByLibrary.simpleMessage("Check status"),
    "city": MessageLookupByLibrary.simpleMessage("City"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "commentToAddress": MessageLookupByLibrary.simpleMessage(
      "Comment to address",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPay": m0,
    "consent_to_personal_data_processing": MessageLookupByLibrary.simpleMessage(
      "Consent to Personal Data Processing",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "contact_admin": MessageLookupByLibrary.simpleMessage(
      "To find out the reasons, contact the app administration.",
    ),
    "continueAgree": MessageLookupByLibrary.simpleMessage(
      "By continuing, you agree to the ",
    ),
    "createDate": MessageLookupByLibrary.simpleMessage("Registration date"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete an account?"),
    "deleteAccountSure": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete your account?",
    ),
    "deleteAddress": MessageLookupByLibrary.simpleMessage(
      "No longer need this address? Saying goodbye is never easy.",
    ),
    "deleteAllBasket": MessageLookupByLibrary.simpleMessage(
      "Delete selected items from the basket?",
    ),
    "delete_account_email_body": MessageLookupByLibrary.simpleMessage(
      "Hello, I would like to delete my account. Please delete my account.\n\nMy number: ",
    ),
    "delete_account_email_subject": MessageLookupByLibrary.simpleMessage(
      "Request for Account Deletion",
    ),
    "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "delivery30min": MessageLookupByLibrary.simpleMessage(
      "Delivery from 30 minutes",
    ),
    "deliveryAddress": MessageLookupByLibrary.simpleMessage("Delivery Address"),
    "deliveryBefore": MessageLookupByLibrary.simpleMessage("Delivery before"),
    "deliveryDate": MessageLookupByLibrary.simpleMessage(
      "Date and time of delivery",
    ),
    "deliveryPrice": MessageLookupByLibrary.simpleMessage("Delivery cost"),
    "deliveryTime": MessageLookupByLibrary.simpleMessage("Delivery time"),
    "deliveryTo": MessageLookupByLibrary.simpleMessage("Delivery to"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "district": MessageLookupByLibrary.simpleMessage("District"),
    "editAddress": MessageLookupByLibrary.simpleMessage("Edit address"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_invalid": MessageLookupByLibrary.simpleMessage(
      "Invalid email format. Example: example@mail.com",
    ),
    "empty": MessageLookupByLibrary.simpleMessage("Empty"),
    "enterCode": MessageLookupByLibrary.simpleMessage(
      "Enter the verification code",
    ),
    "enterName": MessageLookupByLibrary.simpleMessage(
      "Enter your first and last name",
    ),
    "enterNum": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number to continue",
    ),
    "enter_name_surname_email": MessageLookupByLibrary.simpleMessage(
      "Please enter your name, surname, and email. These details are required for order processing and receipt delivery.",
    ),
    "entrance": MessageLookupByLibrary.simpleMessage("Entrance"),
    "errorPlsAgain": MessageLookupByLibrary.simpleMessage(
      "Something went wrong, try again",
    ),
    "error_message": MessageLookupByLibrary.simpleMessage(
      "Sorry, an error occurred. We are already working to fix it. Please try again later.",
    ),
    "fats": MessageLookupByLibrary.simpleMessage("fats"),
    "favorite": MessageLookupByLibrary.simpleMessage("Favorite"),
    "favoriteEmpty": MessageLookupByLibrary.simpleMessage(
      "Favorite items list is empty",
    ),
    "fillEntrance": MessageLookupByLibrary.simpleMessage(
      "Please fill in the entrance field",
    ),
    "fillFloor": MessageLookupByLibrary.simpleMessage(
      "Please fill in the floor field",
    ),
    "fillHouse": MessageLookupByLibrary.simpleMessage(
      "Please fill in the apt/office field",
    ),
    "fillName": MessageLookupByLibrary.simpleMessage(
      "Fill in the first and last name fields",
    ),
    "floor": MessageLookupByLibrary.simpleMessage("Floor"),
    "getNewSms": MessageLookupByLibrary.simpleMessage("Get a new code"),
    "getSms": MessageLookupByLibrary.simpleMessage("Get code"),
    "getSmsTime": MessageLookupByLibrary.simpleMessage(
      "You can get a new code in",
    ),
    "go": MessageLookupByLibrary.simpleMessage("Go over"),
    "goToBasket": MessageLookupByLibrary.simpleMessage("Go to cart"),
    "goToPay": m1,
    "goToProducts": MessageLookupByLibrary.simpleMessage("Go to shopping"),
    "hereWillFavorite": MessageLookupByLibrary.simpleMessage(
      "Liked items will be displayed here",
    ),
    "hereWillProduct": MessageLookupByLibrary.simpleMessage(
      "Items for purchase will be here",
    ),
    "in100gr": MessageLookupByLibrary.simpleMessage("In 100 grams"),
    "inactive_products": MessageLookupByLibrary.simpleMessage(
      "Products that are unavailable:",
    ),
    "incorrectNum": MessageLookupByLibrary.simpleMessage(
      "Invalid phone number",
    ),
    "info": MessageLookupByLibrary.simpleMessage("Information"),
    "insufficient_stock": MessageLookupByLibrary.simpleMessage(
      "Insufficient stock available",
    ),
    "itemList": MessageLookupByLibrary.simpleMessage("Item list"),
    "lastOrderWillHere": MessageLookupByLibrary.simpleMessage(
      "Your last orders will be displayed here",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginAccount": MessageLookupByLibrary.simpleMessage("Log in to account"),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "main": MessageLookupByLibrary.simpleMessage("Home"),
    "maintenance_description": MessageLookupByLibrary.simpleMessage(
      "We are updating our system to improve service quality. Please try again later. Thank you for your patience!",
    ),
    "maintenance_title": MessageLookupByLibrary.simpleMessage(
      "🔧 Maintenance Work",
    ),
    "makeOrder": MessageLookupByLibrary.simpleMessage("Place order"),
    "maker": MessageLookupByLibrary.simpleMessage("Manufacturer"),
    "max_number_of_cards": MessageLookupByLibrary.simpleMessage(
      "Maximum number of cards",
    ),
    "minimum_order_amount": m2,
    "mustFill": MessageLookupByLibrary.simpleMessage("This field is required"),
    "myOrders": MessageLookupByLibrary.simpleMessage("My orders"),
    "name": MessageLookupByLibrary.simpleMessage("First name"),
    "noAddress": MessageLookupByLibrary.simpleMessage("You have no addresses"),
    "no_saved_cards": MessageLookupByLibrary.simpleMessage(
      "You have no saved cards",
    ),
    "nonAuthorizedText": MessageLookupByLibrary.simpleMessage(
      "This option is available to authorized users only",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Not active"),
    "notAvailableNow": MessageLookupByLibrary.simpleMessage(
      "No available time slots at the moment",
    ),
    "notDeliverPlace": MessageLookupByLibrary.simpleMessage(
      "Delivery to this region is not carried out",
    ),
    "notFound": MessageLookupByLibrary.simpleMessage("Nothing found"),
    "office": MessageLookupByLibrary.simpleMessage("Apt/office"),
    "order": MessageLookupByLibrary.simpleMessage("Order"),
    "orderAgain": MessageLookupByLibrary.simpleMessage("Order again"),
    "orderCancel": MessageLookupByLibrary.simpleMessage(
      "Cancel order? Your items are almost on their way!",
    ),
    "orderCanceled": MessageLookupByLibrary.simpleMessage(
      "The order was canceled at the user\'s request",
    ),
    "orderEmpty": MessageLookupByLibrary.simpleMessage("Order list is empty"),
    "orderHistory": MessageLookupByLibrary.simpleMessage("Order History"),
    "orderNumber": MessageLookupByLibrary.simpleMessage("Order number"),
    "order_info": MessageLookupByLibrary.simpleMessage("Order Information"),
    "order_status": MessageLookupByLibrary.simpleMessage("Order Status"),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "otherCategory": MessageLookupByLibrary.simpleMessage(
      "Try other categories",
    ),
    "ourProduct": MessageLookupByLibrary.simpleMessage("Our products"),
    "out_of_stock": MessageLookupByLibrary.simpleMessage(
      "Product is out of stock",
    ),
    "out_stock": MessageLookupByLibrary.simpleMessage("OUT OF STOCK"),
    "payFailed": MessageLookupByLibrary.simpleMessage(
      "Payment failed or was canceled. Please try again.",
    ),
    "payOrder": MessageLookupByLibrary.simpleMessage("Pay order"),
    "paySum": MessageLookupByLibrary.simpleMessage("Amount to pay"),
    "payTime": m3,
    "payTimeFinish": MessageLookupByLibrary.simpleMessage(
      "Payment time is up, the order is being canceled",
    ),
    "payment": MessageLookupByLibrary.simpleMessage("Payment"),
    "paymentOrder": MessageLookupByLibrary.simpleMessage("Order payment"),
    "paymentStatus": MessageLookupByLibrary.simpleMessage("Payment status"),
    "paymentType": MessageLookupByLibrary.simpleMessage("Payment method"),
    "pcs": MessageLookupByLibrary.simpleMessage("pcs"),
    "personalData": MessageLookupByLibrary.simpleMessage("Personal Data"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "pinError": MessageLookupByLibrary.simpleMessage(
      "The PIN code is incorrect or expired.",
    ),
    "privacyPol": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "processCancel": MessageLookupByLibrary.simpleMessage(
      "In process of cancellation",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Processing"),
    "products": MessageLookupByLibrary.simpleMessage("Products"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "proteins": MessageLookupByLibrary.simpleMessage("proteins"),
    "public_offer": MessageLookupByLibrary.simpleMessage("Public Offer"),
    "remaining": MessageLookupByLibrary.simpleMessage("Remaining:"),
    "removed_products": MessageLookupByLibrary.simpleMessage(
      "Products that are out of stock:",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveCard": MessageLookupByLibrary.simpleMessage("Saving the card"),
    "saveCardSuccess": MessageLookupByLibrary.simpleMessage(
      "The card data has been saved successfully",
    ),
    "searchItem": MessageLookupByLibrary.simpleMessage("Search for item"),
    "select": MessageLookupByLibrary.simpleMessage("Select address"),
    "selectAddress": MessageLookupByLibrary.simpleMessage(
      "Specify delivery address",
    ),
    "selectAddressPlease": MessageLookupByLibrary.simpleMessage(
      "Please select a delivery address",
    ),
    "selectCity": MessageLookupByLibrary.simpleMessage("Specify the city"),
    "selectPaymentPlease": MessageLookupByLibrary.simpleMessage(
      "Please select a payment method",
    ),
    "selectTimePlease": MessageLookupByLibrary.simpleMessage(
      "Please select a delivery time",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Select payment method",
    ),
    "sentTo": m4,
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in to account"),
    "somethingError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "street": MessageLookupByLibrary.simpleMessage("Street, house*"),
    "sureLogout": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out? We will miss you.",
    ),
    "surname": MessageLookupByLibrary.simpleMessage("Last name"),
    "technicalStill": MessageLookupByLibrary.simpleMessage(
      "Technical work is still underway",
    ),
    "temporarily_not_accepting_orders": MessageLookupByLibrary.simpleMessage(
      "We are temporarily not accepting orders",
    ),
    "thanksForOrder": MessageLookupByLibrary.simpleMessage(
      "Thank you for your purchase! We will contact you with delivery details",
    ),
    "toBasket": MessageLookupByLibrary.simpleMessage("Add to basket"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
    "totalSum": MessageLookupByLibrary.simpleMessage("Total sum"),
    "try_again": MessageLookupByLibrary.simpleMessage("Try again"),
    "update_available": MessageLookupByLibrary.simpleMessage(
      "Update available",
    ),
    "update_button": MessageLookupByLibrary.simpleMessage("Update the app"),
    "update_message": MessageLookupByLibrary.simpleMessage(
      "New features and improvements in Grocery App. Update now to stay up to date!",
    ),
    "userAgre": MessageLookupByLibrary.simpleMessage("User Agreement"),
    "userAgreement": MessageLookupByLibrary.simpleMessage("User Agreement"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "wait": MessageLookupByLibrary.simpleMessage("Waiting"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome to "),
    "write": MessageLookupByLibrary.simpleMessage("Write"),
    "write_message": MessageLookupByLibrary.simpleMessage(
      "To delete your account, please contact us at support@example.com. Your request will be processed shortly.",
    ),
    "wrongCurrentPass": MessageLookupByLibrary.simpleMessage(
      "The current password is incorrect",
    ),
    "yourAddress": MessageLookupByLibrary.simpleMessage("Your addresses"),
    "your_cards": MessageLookupByLibrary.simpleMessage("Your cards"),
  };
}
