import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/asset_constant.dart';
import '../theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final Widget? prefix;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obsecure;
  final VoidCallback? onPressed;
  final bool hideTitle;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputFormatter? inputFormatter;
  final int? maxLines;
  final bool readOnly;
  final Function(String)? onChanged;
  final bool isReversedGradient;
  final bool isEnabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.title,
    this.prefix,
    required this.hintText,
    required this.controller,
    this.obsecure = false,
    this.keyboardType = TextInputType.text,
    this.onPressed,
    this.validator,
    this.hideTitle = false,
    this.decoration,
    this.maxLength,
    this.focusNode,
    this.inputFormatter,
    this.maxLines,
    this.readOnly = false,
    this.onChanged,
    this.isReversedGradient = true,
    this.isEnabled = true,
    this.suffixIcon,
    this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      readOnly: readOnly,
      obscureText: obsecure,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLength,
      focusNode: focusNode,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      maxLines: maxLines,
      onTap: readOnly ? onPressed : null,
      decoration:
      decoration ??
          InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppTheme.textFormFieldOutlineClr),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black), // customize
            ),
            filled: true,
            // fillColor: AppColors.textFieldBg,
            // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            counter: const SizedBox.shrink(),
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(color: AppTheme.stepperTextColor, fontSize: 14, fontFamily: AssetConstant.roboto),
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefix: prefix,
          ),
    );
  }
}
