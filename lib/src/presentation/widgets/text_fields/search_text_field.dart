import 'package:grocery_app/src/common/app_styles/text_styles.dart';
import 'package:grocery_app/src/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_styles/assets.dart';
import '../../../common/app_styles/colors.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? autoFocus;
  final Function(String? value)? valid;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final String? errorText;
  final int maxLines;
  final int minLines;
  final TextInputType? keyboardType;
  final bool hide;
  final bool readOnly;
  final bool isNotFilled;
  final Widget? suffixIcon;
  final Function(String? value)? onSent;
  final Function()? onTap;
  final Function(String? value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const SearchTextFieldWidget({
    super.key,
    this.controller,
    this.autoFocus,
    this.valid,
    this.hintText,
    this.inputFormatters,
    this.onTap,
    this.initialValue,
    this.keyboardType,
    this.onSent,
    this.hide = false,
    this.isNotFilled = true,
    this.readOnly = false,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.labelText,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.background),
      child: Row(
        children: [
          12.width,
          SvgPicture.asset(
            AppAssets.search,
            height: 20,
          ),
          Expanded(
            child: Center(
                child: TextFormField(
              onTap: onTap,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              obscureText: hide,
              readOnly: readOnly,
              controller: controller,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              textInputAction: TextInputAction.search,
              autocorrect: false,
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              onFieldSubmitted: onSent,
              cursorColor: AppColors.main,
              cursorHeight: 20,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                errorText: errorText,
                filled: false,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.only(
                  left: 12,
                  top: 8,
                  bottom: 12,
                ),
                hintText: hintText,
                hintStyle: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.gray,
                ),
                border: InputBorder.none,
                label: labelText != null
                    ? Text(
                        labelText!,
                        style: TextStyle(
                            color:
                                isNotFilled ? AppColors.gray : AppColors.main),
                      )
                    : null,
              ),
              maxLines: maxLines,
              minLines: minLines,
              style: AppTextStyle.labelLarge,
              validator: (value) => valid!(value),
            )),
          ),
        ],
      ),
    );
  }
}
