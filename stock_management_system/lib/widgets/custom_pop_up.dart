import 'package:flutter/material.dart';

import '../../backend/theme.dart';

showCustomPopUp(BuildContext context, Widget content,
    {bool barrierDismissible = false}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
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
