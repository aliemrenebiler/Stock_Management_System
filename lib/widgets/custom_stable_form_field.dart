import 'package:flutter/material.dart';

import '../backend/methods.dart';
import '../backend/theme.dart';
import 'custom_button.dart';

class CustomStableField extends StatelessWidget {
  final String? selectionText;
  final double? width;
  final double? height;
  const CustomStableField({
    super.key,
    required this.selectionText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: YMColors().white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: YMColors().grey,
          width: 2,
        ),
      ),
      child: Text(
        selectionText ?? "-",
        overflow: TextOverflow.visible,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: TextStyle(
          fontSize: YMSizes().fontSizeSmall,
          color: YMColors().black,
        ),
      ),
    );
  }
}
