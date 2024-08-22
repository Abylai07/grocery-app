import 'package:abricoz_app/src/presentation/widgets/text_fields/search_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_styles/assets.dart';
import '../../common/utils/l10n/generated/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onBackPressed, required this.title});
  final Function()? onBackPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(AppAssets.back),
        onPressed: () {
          context.router.maybePop();
        },
      ),
      centerTitle: true,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
