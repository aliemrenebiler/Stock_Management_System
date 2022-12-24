import 'package:flutter/material.dart';

import '../backend/theme.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.validator,
  });
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: YMColors().black),
      ),
      width: 320,
      child: TextFormField(
        cursorColor: YMColors().black,
        autofocus: false,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: Colors.transparent,
        ),
      ),
    );
  }
}
