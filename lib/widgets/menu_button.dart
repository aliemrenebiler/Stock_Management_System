import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.textColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontSize: YMSizes().fontSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
