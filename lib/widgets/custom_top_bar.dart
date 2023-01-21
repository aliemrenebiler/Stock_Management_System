import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/widgets/custom_pop_up.dart';

import '../backend/theme.dart';
import 'custom_button.dart';

class CustomTopBar extends StatelessWidget {
  final String title;
  final String? leftButtonText;
  final void Function()? leftButtonAction;
  final String? rightButtonText;
  final void Function()? rightButtonAction;
  const CustomTopBar({
    super.key,
    required this.title,
    this.leftButtonText,
    this.leftButtonAction,
    this.rightButtonText,
    this.rightButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    CustomButton? leftButton;
    CustomButton? rightButton;
    CustomButton? menuButton;
    if (leftButtonText != null) {
      leftButton = CustomButton(
        text: leftButtonText!,
        textColor: YMColors().white,
        bgColor: YMColors().darkGrey,
        onPressed: leftButtonAction ?? () {},
        height: 50,
        width: 180,
      );
    }
    if (rightButtonText != null) {
      rightButton = CustomButton(
        text: rightButtonText!,
        textColor: YMColors().white,
        bgColor: YMColors().darkGrey,
        onPressed: rightButtonAction ?? () {},
        height: 50,
        width: 180,
      );
    }
    if (leftButton != null || rightButton != null) {
      menuButton = CustomButton(
        text: "Menü",
        textColor: YMColors().white,
        bgColor: YMColors().darkGrey,
        onPressed: () {
          showCustomPopUp(
            context,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CustomButton(
                    text: "Menüyü Kapat",
                    textColor: YMColors().white,
                    bgColor: YMColors().grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    height: 50,
                    width: double.infinity,
                  ),
                ),
                (leftButtonText != null)
                    ? Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomButton(
                          text: leftButtonText!,
                          textColor: YMColors().white,
                          bgColor: YMColors().darkGrey,
                          onPressed: leftButtonAction ?? () {},
                          height: 50,
                          width: double.infinity,
                        ),
                      )
                    : Container(),
                (rightButtonText != null)
                    ? Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomButton(
                          text: rightButtonText!,
                          textColor: YMColors().white,
                          bgColor: YMColors().darkGrey,
                          onPressed: rightButtonAction ?? () {},
                          height: 50,
                          width: double.infinity,
                        ),
                      )
                    : Container(),
              ],
            ),
            barrierDismissible: true,
          );
        },
        height: 50,
        width: 80,
      );
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: YMColors().grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: (MediaQuery.of(context).size.width < 700)
                ? menuButton ?? const SizedBox(width: 80)
                : leftButton ?? const SizedBox(width: 180),
          ),
          Expanded(
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: YMColors().white,
                  fontSize: YMSizes().fontSizeLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: (MediaQuery.of(context).size.width < 700)
                ? const SizedBox(width: 80)
                : rightButton ?? const SizedBox(width: 180),
          ),
        ],
      ),
    );
  }
}
