import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';

class LabelInTextFieldWidget extends StatelessWidget {
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
  final Function()? change;
  final Function(String? value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const LabelInTextFieldWidget({
    super.key,
    this.controller,
    this.autoFocus,
    this.valid,
    this.hintText,
    this.inputFormatters,
    this.initialValue,
    this.keyboardType,
    this.change,
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
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        obscureText: hide,
        readOnly: readOnly,
        controller: controller,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        onTapOutside: (event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: keyboardType,
        autocorrect: false,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        cursorColor: AppColors.main,
        cursorHeight: 20,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorText: errorText,
          filled: false,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 8, left: 12, top: 4),
          hintText: hintText,
          hintStyle: AppTextStyle.labelLarge.copyWith(
            color: AppColors.gray,
          ),
          label: labelText != null
              ? Text(
            labelText!,
            style: TextStyle(
                color: isNotFilled ? AppColors.gray : AppColors.main),
          )
              : null,
        ),
        maxLines: maxLines,
        minLines: minLines,
        style: AppTextStyle.labelLarge.copyWith(color: AppColors.black),
        validator: (value) => valid!(value),
      ),
    );
  }
}