import 'package:flutter/material.dart';

import '../backend/methods.dart';
import '../backend/theme.dart';
import 'custom_button.dart';

class CustomSelectionField extends StatelessWidget {
  final String? selectionText;
  final double? width;
  final double? height;
  final void Function() onPressed;
  final Function() notifyParent;
  final bool? isRequired;
  const CustomSelectionField({
    super.key,
    required this.selectionText,
    required this.onPressed,
    required this.notifyParent,
    this.width,
    this.height,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: YMColors().white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: YMColors().grey,
                  width: 2,
                ),
              ),
              child: (selectionText == null)
                  ? Text(
                      (isRequired == true) ? "(Zorunlu)" : "(Seçilmedi)",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeSmall,
                        color: YMColors().grey,
                      ),
                    )
                  : Text(
                      selectionText!,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeSmall,
                        color: YMColors().black,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: (selectionText == null)
                ? CustomButton(
                    text: "Seç",
                    onPressed: onPressed,
                    textColor: YMColors().white,
                    bgColor: YMColors().blue,
                    height: 50,
                    width: 80,
                  )
                : CustomButton(
                    text: "Kaldır",
                    onPressed: () {
                      selectedItem = null;
                      notifyParent();
                    },
                    textColor: YMColors().white,
                    bgColor: YMColors().grey,
                    height: 50,
                    width: 80,
                  ),
          ),
        ],
      ),
    );
  }
}
