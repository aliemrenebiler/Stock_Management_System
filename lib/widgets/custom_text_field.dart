import 'package:flutter/material.dart';

import '../backend/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? hideText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  const CustomTextField({
    super.key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.hideText,
    this.validator,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
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
        cursorColor: YMColors().darkBlue,
        autofocus: false,
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
