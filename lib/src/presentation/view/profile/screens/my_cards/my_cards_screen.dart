import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/user/card_entity.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../common/app_styles/assets.dart';
import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../bloc/my_cards/cards_cubit.dart';

@RoutePage()
class MyCardsScreen extends StatelessWidget {
  const MyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).your_cards,
      ),
      backgroundColor: AppColors.background,
      body: BlocBuilder<CardsCubit, CardsState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            List<CardEntity> cards = state.entity ?? [];
            return cards.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.card,
                                        height: 20,
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: RichText(
                                          text: TextSpan(
                                            text: cards[index].issuer,
                                            style:  AppTextStyle.bodyLarge,
                                            children: [
                                              TextSpan(
                                                text: ' ~ ${cards[index].lastNumbers}',
                                                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.gray),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          AppAssets.remove,
                                          height: 20,
                                          width: 20,
                                        ),
                                        onPressed: () async {
                                          // context
                                          //     .read<CardsCubit>()
                                          //     .deleteCard(cards[index].id);
                                        },
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 16,
                                    color: AppColors.grayContainer,
                                  ),
                                ],
                              );
                            }),
                        TextButton(
                            onPressed: () async {
                              await context.router.push(const SaveCardRoute());
                              context.read<CardsCubit>().fetchMyCards();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).add_new_card,
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: AppColors.main,
                                  ),
                                ),
                                4.width,
                                const Icon(
                                  Icons.add,
                                  color: AppColors.main,
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                : buildEmptyAddress(context);
          } else if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Column buildEmptyAddress(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Image.asset(AppAssets.noCard),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 12),
          child: Text(
            S.of(context).no_saved_cards,
            style:
                AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          S.of(context).cards_will_be_stored_here,
          style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
          textAlign: TextAlign.center,
        ),
        16.height,
        InkWell(
          onTap: () async {
            await context.router.push(const SaveCardRoute());
            context.read<CardsCubit>().fetchMyCards();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.main,
            ),
            child: Text(
              S.of(context).add_new_card,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
