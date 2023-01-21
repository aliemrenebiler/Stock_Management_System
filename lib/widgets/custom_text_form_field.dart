import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../backend/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? hideText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Type? inputType;
  final int? maxInputLength;
  final double? height;
  final double? width;
  final TextInputAction? action;
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    this.inputType,
    this.maxInputLength,
    this.controller,
    this.hintText,
    this.hideText,
    this.validator,
    this.height,
    this.width,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? formatter = [];
    if (inputType == int) {
      formatter.add(
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]+'),
        ),
      );
    } else if (inputType == double) {
      formatter.add(
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]+[.]{0,1}[0-9]*'),
        ),
      );
    }

    if (maxInputLength != null) {
      formatter.add(
        LengthLimitingTextInputFormatter(maxInputLength),
      );
    }

    if (formatter.isEmpty) {
      formatter = null;
    }

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: YMColors().white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: YMColors().grey,
          width: 2,
        ),
      ),
      child: TextFormField(
        obscureText: hideText ?? false,
        controller: controller,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: YMColors().black,
          fontSize: YMSizes().fontSizeSmall,
        ),
        cursorColor: YMColors().darkGrey,
        autofocus: false,
        inputFormatters: formatter,
        textInputAction: action ?? TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: YMColors().grey,
            fontSize: YMSizes().fontSizeSmall,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: Colors.transparent,
        ),
      ),
    );
  }
}
