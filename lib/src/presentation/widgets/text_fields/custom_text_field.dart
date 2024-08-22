import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';

class CustomTextFieldWidget extends StatelessWidget {
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
  const CustomTextFieldWidget({
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
    return TextFormField(
      obscureText: hide,
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onTapOutside: (event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
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
        filled: true,
        // fillColor: AppColors.lightGrey
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(
          left: 12,
          top: 8,
          bottom: 8,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isNotFilled ? AppColors.gray1 : AppColors.main,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorRedColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isNotFilled ? AppColors.gray1 : AppColors.main,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isNotFilled ? AppColors.gray1 : AppColors.main,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.gray1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.gray1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
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
    );
  }
}
