import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';

showCustomPopUp(
  BuildContext context,
  Widget content,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: YMColors().white,
        scrollable: true,
        content: content,
      );
    },
  );
}
