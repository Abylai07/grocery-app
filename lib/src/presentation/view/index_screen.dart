import 'dart:math';

import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/order/active_orders_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';

import '../../common/app_styles/assets.dart';
import '../../common/app_styles/colors.dart';
import '../../common/epay_service.dart';
import '../../common/utils/firebase_api/notifications.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import '../bloc/nav_bar_bloc.dart';
import '../widgets/modal_bottoms/non_authorize_modal.dart';
import '../widgets/snack_bar.dart';
import '../widgets/upgrader_widget.dart';
import 'basket/bloc/basket_bloc/basket_bloc.dart';

// @RoutePage()
// class IndexScreen extends StatefulWidget {
//   const IndexScreen({super.key});
//
//   @override
//   State<IndexScreen> createState() => _IndexScreenState();
// }
//
// class _IndexScreenState extends State<IndexScreen> {
//
//   @override
//   void initState() {
//     Notifications().init(context);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return UpgradeWidget(
//       dialogStyle: UpgradeDialogStyle.cupertino,
//       showIgnore: false,
//       showLater: false,
//       upgrader: Upgrader(
//         durationUntilAlertAgain: const Duration(minutes: 1),
//         debugLogging: false,
//       ),
//       child: AutoTabsRouter(
//         routes: const [
//           HomeRoute(),
//           BasketRoute(),
//           FavoriteRoute(),
//           ProfileRoute(),
//         ],
//         builder: (context, child) {
//           final tabsRouter = AutoTabsRouter.of(context);
//
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: child,
//             bottomNavigationBar: BlocBuilder<NavBarBloc, NavBarState>(
//               builder: (context, state) {
//                 return AnimatedContainer(
//                   margin: EdgeInsets.only(
//                       bottom: state.isVisible
//                           ? MediaQuery.of(context).padding.bottom
//                           : 0),
//                   duration: const Duration(milliseconds: 300),
//                   height: state.isVisible ? kBottomNavigationBarHeight : 0,
//                   child: Wrap(
//                     children: [
//                       BottomNavigationBar(
//                         unselectedLabelStyle: AppTextStyle.displayMedium
//                             .copyWith(fontWeight: FontWeight.w500),
//                         selectedLabelStyle: AppTextStyle.displayMedium
//                             .copyWith(fontWeight: FontWeight.w500),
//                         type: BottomNavigationBarType.fixed,
//                         currentIndex: tabsRouter.activeIndex,
//                         onTap: (value)  {
//                           String? token = SharedPrefs().getAccessToken();
//                           if (value == 1 && token != null) {
//                             context.read<BasketBloc>().add(const CheckBasketItems());
//                             context.read<ActiveOrdersCubit>().fetchActiveOrders();
//                           } else if (value == 1 && token == null) {
//                             context.read<BasketBloc>().add(const RefreshBasket());
//                           } else if (value == 2 && token == null) {
//                             nonAuthorizeModal(context);
//                             return;
//                           } else if (value == 2 && token != null) {
//                             context.read<FavoriteCubit>().checkFavorites();
//                           }
//                           tabsRouter.setActiveIndex(value);
//                         },
//                         iconSize: 26,
//                         items: [
//                           BottomNavigationBarItem(
//                             icon: SvgPicture.asset(AppAssets.icon1),
//                             activeIcon: SvgPicture.asset(AppAssets.iconActive1),
//                             label: S.of(context).main,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: getBadgeIcon(false),
//                             activeIcon: getBadgeIcon(true),
//                             label: S.of(context).basket,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: SvgPicture.asset(AppAssets.icon4),
//                             activeIcon: SvgPicture.asset(AppAssets.iconActive4),
//                             label: S.of(context).favorite,
//                           ),
//                           BottomNavigationBarItem(
//                             icon: SvgPicture.asset(AppAssets.icon5),
//                             activeIcon: SvgPicture.asset(AppAssets.iconActive5),
//                             label: S.of(context).profile,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget getBadgeIcon(bool active) {
//     return BlocBuilder<BasketBloc, BasketState>(
//       builder: (context, state) {
//         int count = state.allProducts?.length ?? 0;
//         return count < 1
//             ? SvgPicture.asset(active ? AppAssets.iconActive3 : AppAssets.icon3)
//             : badges.Badge(
//                 position: BadgePosition.topEnd(top: -12, end: -10),
//                 badgeAnimation: const BadgeAnimation.slide(
//                   colorChangeAnimationDuration: Duration(milliseconds: 300),
//                 ),
//                 badgeContent: Text(
//                   count.toString(),
//                   style:
//                       AppTextStyle.labelSmall.copyWith(color: AppColors.white),
//                 ),
//                 child: SvgPicture.asset(
//                   active ? AppAssets.iconActive3 : AppAssets.icon3,
//                 ),
//               );
//       },
//     );
//   }
// }


@RoutePage()
class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final TextEditingController _cardNumberController = TextEditingController(text: '4400430229762114');
  final TextEditingController _expDateController = TextEditingController(text: '0426');
  final TextEditingController _cvcController = TextEditingController(text: '874');
  final TextEditingController _nameController = TextEditingController(text: 'ABYLAY ANAYAT');
  final TextEditingController _emailController = TextEditingController(text: 'abylaianayat@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+77714424343');

  final EpayService _epayService = EpayService();
  bool _isLoading = false;
  String? _responseMessage;

  /// Сохранение карты
  Future<void> _saveCard() async {
    setState(() {
      _isLoading = true;
      _responseMessage = null;
    });

    try {
      String cryptogram = await _epayService.encryptCardData(
        cardNumber: _cardNumberController.text,
        expDate: _expDateController.text,
        cvc: _cvcController.text,
      );

      String generateInvoiceId() {
        final Random random = Random();
        return (100000 + random.nextInt(900000)).toString(); // Generates a number between 100000 and 999999
      }

      Map<String, dynamic> response = await _epayService.saveCard(
        encryptedCryptogram: cryptogram,
        invoiceId: generateInvoiceId(),
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      print('response ${response}');
      if (response.containsKey('cardID')) {
        String cardId = response['cardID']; // ✅ Получаем cardID

        setState(() {
          _responseMessage = "Карта успешно сохранена! Card ID: $cardId";
        });

        // 🔹 Запускаем оплату после сохранения карты
      } else {
        throw Exception("Ошибка: Не получен cardID");
      }

    } catch (e) {
      setState(() {
        _responseMessage = "Ошибка: $e";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  /// Выполняет оплату с сохраненной карты
  Future<void> _processPayment(String cardId, String invoiceId) async {
    try {
      Map<String, dynamic> paymentResponse = await _epayService.processPayment(
        cardId: cardId,
        amount: 100, // ✅ Сумма в KZT
        invoiceId: invoiceId,
        accountId: "user_123456",
        email: _emailController.text,
        phone: _phoneController.text,
      );

      setState(() {
        _responseMessage = "💳 Оплата успешна! Транзакция: ${paymentResponse['reference']}";
      });
    } catch (e) {
      setState(() {
        _responseMessage = "❌ Ошибка оплаты: $e";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Сохранение карты")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _cardNumberController, decoration: InputDecoration(labelText: "Номер карты")),
            TextField(controller: _expDateController, decoration: InputDecoration(labelText: "Срок действия (MMYY)")),
            TextField(controller: _cvcController, decoration: InputDecoration(labelText: "CVC")),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Имя владельца")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: "Телефон")),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: _saveCard, child: Text("Сохранить карту")),
            SizedBox(height: 20),
            if (_responseMessage != null) Text(_responseMessage!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
