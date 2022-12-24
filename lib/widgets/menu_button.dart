import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color? bgColor;
  final Color? textColor;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        fixedSize: const Size(320, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
      ),
    );
  }
}
