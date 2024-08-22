import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/category/widgets/category_widget.dart';
import 'package:abricoz_app/src/presentation/view/home/widgets/slider_body_widget.dart';
import 'package:abricoz_app/src/presentation/view/product/screens/search_product_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../common/utils/l10n/generated/l10n.dart';
import '../../bloc/nav_bar_bloc.dart';
import '../../widgets/text_fields/search_text_field.dart';
import '../category/bloc/category_cubit.dart';
import '../product/bloc/search_bloc/search_product_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late PanelController panelController;
  late TextEditingController searchController;

  @override
  void initState() {
    panelController = PanelController();
    searchController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    panelController.close();
    searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        controller: panelController,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        isDraggable: true,
        maxHeight: screenSize.height,
        minHeight: screenSize.height * 0.42,
        panelBuilder: (ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BlocBuilder<NavBarBloc, NavBarState>(
                        builder: (context, state) {
                          return AnimatedContainer(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: 6.0 +
                                    (state.isVisible
                                        ? MediaQuery.of(context).viewPadding.top
                                        : 0),
                                bottom: 10),
                            duration: const Duration(milliseconds: 200),
                            child: SvgPicture.asset(AppAssets.line),
                          );
                        },
                      ),
                      SearchTextFieldWidget(
                        controller: searchController,
                        onSent: (value) {
                          context
                              .read<SearchProductCubit>()
                              .searchItems(value ?? '');
                        },
                        onChanged: (val) {
                          if (panelController.isAttached &&
                              panelController.isPanelClosed) {
                            panelController.open();
                          }
                          if (val != null && val.length >= 2) {
                            context
                                .read<SearchProductCubit>()
                                .fetchSearchHint(val);
                          }
                        },
                        onTap: () {
                          panelController.open();
                        },
                        hintText: S.of(context).searchItem,
                      ),
                      16.height,
                    ],
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: searchController,
                    builder: (context, TextEditingValue value, _) {
                      return value.text.length >= 2
                          ? const SearchProductsView()
                          : SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).category,
                                    style: AppTextStyle.titleBold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      bottom: 32,
                                    ),
                                    child:
                                        BlocBuilder<CategoryCubit, BaseState>(
                                      builder: (context, state) {
                                        if (state.status.isSuccess) {
                                          List<CategoryEntity> categories =
                                              state.entity
                                                  as List<CategoryEntity>;
                                          return GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              return CategoryWidget(
                                                  category: categories[index]);
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  3, // number of items in each row
                                              mainAxisSpacing:
                                                  8.0, // spacing between rows
                                              crossAxisSpacing:
                                                  8.0, // spacing between columns
                                              mainAxisExtent: 124,
                                            ),
                                          );
                                        } else if (state.status.isLoading) {
                                          return const CategoryLoadingWidget();
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                  // Text(
                                  //   S.of(context).ourProduct,
                                  //   style: AppTextStyle.titleBold,
                                  // ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            );
                    }),
              ],
            ),
          );
        },
        onPanelSlide: (position) {
          if (position >= 0.94) {
            context.read<NavBarBloc>().add(ShowNavBar());
          } else {
            context.read<NavBarBloc>().add(HideNavBar());
          }
        },
        body: const SliderBodyWidget(),
      ),
    );
  }
}
