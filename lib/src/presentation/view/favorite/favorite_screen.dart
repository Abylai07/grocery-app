import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/app_styles/assets.dart';
import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).favorite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42.0),
                    child: Image.asset(AppAssets.favoriteEmpty),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 12),
                    child: Text(
                      S.of(context).favoriteEmpty,
                      style: AppTextStyle.titleMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    S.of(context).hereWillFavorite,
                    style: AppTextStyle.bodyLarge
                        .copyWith(color: AppColors.textGray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ) : SizedBox()
            // : GridView.builder(
            //     shrinkWrap: true,
            //     padding: const EdgeInsets.only(top: 12, bottom: 24),
            //     itemCount: 3,
            //     itemBuilder: (context, index) {
            //       return BlocProvider(
            //         create: (context) => BasketBloc(),
            //         child: ProductWidget(),
            //       );
            //     },
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 8.0,
            //       crossAxisSpacing: 8.0,
            //       mainAxisExtent: 360,
            //     ),
            //   ),
      ),
    );
  }
}
