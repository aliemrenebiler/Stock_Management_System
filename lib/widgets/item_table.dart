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
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          children: [
            titlesBar,
            Expanded(
              child: (items.isNotEmpty)
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            for (int i = 0; i < items.length; i++) items[i],
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "Herhangi bir veri mevcut değil.",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: YMSizes().fontSizeMedium,
                          color: YMColors().grey,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ItemTablePageControls(
            currentPage: currentPage,
            totalPage: totalPage,
            onPressedPrev: onPressedPrev,
            onPressedNext: onPressedNext,
          ),
        )
      ],
    );
  }
}

class ItemTablePageControls extends StatefulWidget {
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
  State<ItemTablePageControls> createState() => _ItemTablePageControlsState();
}

class _ItemTablePageControlsState extends State<ItemTablePageControls> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        visible = true;
        setState(() {});
      },
      onExit: (event) {
        visible = false;
        setState(() {});
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: (visible) ? 1 : 0,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: YMColors().lightGrey,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: CustomButton(
                    width: 40,
                    height: 40,
                    textColor: YMColors().lightGrey,
                    bgColor: YMColors().grey,
                    text: "<",
                    isTextBold: false,
                    onPressed: widget.onPressedPrev,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
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
                      "${widget.currentPage}/${widget.totalPage}",
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
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: CustomButton(
                    width: 40,
                    height: 40,
                    textColor: YMColors().lightGrey,
                    bgColor: YMColors().grey,
                    text: ">",
                    isTextBold: false,
                    onPressed: widget.onPressedNext,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
