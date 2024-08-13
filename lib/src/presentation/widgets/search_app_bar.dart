import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_styles/assets.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import 'text_fields/custom_text_field.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key, this.onChanged, this.controller});
  final TextEditingController? controller;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.only(left: 8, right: 16),
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(AppAssets.back),
              onPressed: () {
                context.router.maybePop();
              },
            ),
            Expanded(
              child: SearchTextFieldWidget(
                isNotFilled: false,
                controller: controller,
                hintText: S.of(context).searchItem,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(onChanged == null ? 56 : 106);
}
