import 'package:flutter/material.dart';

import '../backend/theme.dart';

showCustomSnackBar(
  BuildContext context,
  String text,
  Color textColor,
  Color bgColor,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: textColor,
          fontSize: YMSizes().fontSizeMedium,
        ),
      ),
      backgroundColor: bgColor,
    ),
  );
}
