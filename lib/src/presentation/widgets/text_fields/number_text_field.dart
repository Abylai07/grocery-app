import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_styles/colors.dart';

class NumberTextFieldWidget extends StatelessWidget {
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
  const NumberTextFieldWidget({
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightGrey)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.gray3,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft:  Radius.circular(6))
              ),
              child: Text(
                '+7',
                style: AppTextStyle.bodyLarge,
              )),
          Expanded(
            child: Center(
                child: TextFormField(
              obscureText: hide,
              readOnly: readOnly,
              controller: controller,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
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
                contentPadding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  bottom: 12,
                ),
                hintText: hintText,
                hintStyle: AppTextStyle.labelLarge.copyWith(
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
