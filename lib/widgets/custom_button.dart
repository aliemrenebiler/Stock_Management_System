import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final bool? isTextBold;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.textColor,
    this.bgColor,
    this.isTextBold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: YMColors().black,
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
            fontWeight:
                (isTextBold == false) ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
