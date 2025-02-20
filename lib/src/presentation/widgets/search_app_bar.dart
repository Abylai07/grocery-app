import 'package:abricoz_app/src/presentation/widgets/text_fields/search_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_styles/assets.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import '../bloc/search_bloc/search_bloc.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar(
      {super.key,
      this.onChanged,
      this.controller,
      this.onSent,
      this.onBackPressed,
      this.title});
  final TextEditingController? controller;
  final String? title;
  final Function()? onBackPressed;
  final Function(String?)? onChanged;
  final Function(String?)? onSent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isVisible) {
          return SafeArea(
            child: Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(AppAssets.back),
                    onPressed: onBackPressed ??
                        () {
                          context.router.maybePop();
                        },
                  ),
                  Expanded(
                    child: SearchTextFieldWidget(
                      isNotFilled: false,
                      controller: controller,
                      hintText: S.of(context).searchItem,
                      onChanged: onChanged,
                      onSent: onSent,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller?.clear();
                          context
                              .read<SearchBloc>()
                              .add(CloseSearch());
                        },
                        icon: SvgPicture.asset(AppAssets.close, height: 14,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return AppBar(
            centerTitle: true,
            title: Text(title ?? ''),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    context.read<SearchBloc>().add(ToggleSearchVisibility());
                  },
                  icon: SvgPicture.asset(AppAssets.search),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
