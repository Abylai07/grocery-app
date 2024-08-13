import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_styles/colors.dart';

ExpandableThemeData buildExpandableThemeData() {
  return ExpandableThemeData(
    inkWellBorderRadius: BorderRadius.circular(16.w),
    iconColor: AppColors.mainBlue,
    tapBodyToExpand: true,
    tapHeaderToExpand: true,
    iconPadding: EdgeInsets.zero,
    expandIcon: Icons.keyboard_arrow_down_outlined,
    collapseIcon: Icons.keyboard_arrow_up_rounded,
    iconSize: 30.spMin,
    headerAlignment:
    ExpandablePanelHeaderAlignment.center,
    tapBodyToCollapse: true,
  );
}