import 'package:flutter/material.dart';

import '../backend/theme.dart';

class TopBar extends StatelessWidget {
  final List<Widget>? widgets;
  const TopBar({
    super.key,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: YMColors().darkRed,
      ),
      child: (widgets != null || widgets!.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < widgets!.length; i++) widgets![i],
                ],
              ),
            )
          : null,
    );
  }
}
