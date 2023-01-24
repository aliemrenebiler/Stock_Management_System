import 'package:flutter/material.dart';

class ItemTable extends StatelessWidget {
  final Widget titlesBar;
  final List<Widget> items;
  const ItemTable({
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
