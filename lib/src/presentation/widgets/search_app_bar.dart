import 'package:abricoz_app/src/presentation/widgets/text_fields/search_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_styles/assets.dart';
import '../../common/utils/l10n/generated/l10n.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key, this.onChanged, this.controller, this.onSent, this.onBackPressed});
  final TextEditingController? controller;
  final Function()? onBackPressed;
  final Function(String?)? onChanged;
  final Function(String?)? onSent;

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
              onPressed: onBackPressed ?? () {
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
