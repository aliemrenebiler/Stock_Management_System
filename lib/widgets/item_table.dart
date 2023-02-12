import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/custom_button.dart';

class ItemTable extends StatelessWidget {
  final Widget titlesBar;
  final List<Widget> items;
  final int currentPage;
  final int totalPage;
  final Function() onPressedPrev;
  final Function() onPressedNext;
  const ItemTable({
    super.key,
    required this.titlesBar,
    required this.items,
    required this.currentPage,
    required this.totalPage,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titlesBar,
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  for (int i = 0; i < items.length; i++) items[i],
                ],
              ),
            ),
          ),
        ),
        if (totalPage > 1)
          Padding(
              padding: const EdgeInsets.all(15),
              child: ItemTablePageControls(
                currentPage: currentPage,
                totalPage: totalPage,
                onPressedPrev: onPressedPrev,
                onPressedNext: onPressedNext,
              ))
      ],
    );
  }
}

class ItemTablePageControls extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Function() onPressedPrev;
  final Function() onPressedNext;
  const ItemTablePageControls({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          width: 40,
          height: 40,
          textColor: YMColors().darkGrey,
          bgColor: YMColors().lightGrey,
          text: "<",
          isTextBold: false,
          onPressed: onPressedPrev,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            height: 40,
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: YMColors().white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: YMColors().grey,
                width: 2,
              ),
            ),
            child: Text(
              "$currentPage/$totalPage",
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: YMSizes().fontSizeSmall,
                color: YMColors().black,
              ),
            ),
          ),
        ),
        CustomButton(
          width: 40,
          height: 40,
          textColor: YMColors().darkGrey,
          bgColor: YMColors().lightGrey,
          text: ">",
          isTextBold: false,
          onPressed: onPressedNext,
        ),
      ],
    );
  }
}

class ListTableVerticalSeperator extends StatelessWidget {
  final Color color;
  final double space;
  const ListTableVerticalSeperator({
    super.key,
    required this.color,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: 2,
      width: 2,
      color: color,
      indent: space,
      endIndent: space,
    );
  }
}
