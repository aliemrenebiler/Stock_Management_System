import 'package:flutter/material.dart';

import '../backend/theme.dart';

class ListTable extends StatelessWidget {
  final Widget titlesBar;
  final List<Widget> items;
  const ListTable({
    super.key,
    required this.titlesBar,
    required this.items,
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
      ],
    );
  }
}

class ListTableTitlesBarItem extends StatelessWidget {
  final String text;
  final int flex;
  const ListTableTitlesBarItem({
    super.key,
    required this.text,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: YMColors().black,
            fontSize: YMSizes().fontSizeMedium,
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
