import 'package:flutter/material.dart';

import '../backend/theme.dart';

class CustomTopBar extends StatelessWidget {
  final List<Widget>? widgets;
  const CustomTopBar({
    super.key,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: YMColors().grey,
      ),
      child: (widgets != null || widgets!.isNotEmpty)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < widgets!.length; i++) widgets![i],
              ],
            )
          : null,
    );
  }
}
