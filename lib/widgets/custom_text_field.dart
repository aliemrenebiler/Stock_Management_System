import 'package:flutter/material.dart';

Widget textfields(TextEditingController cnt, String lbl, String hnt, double x,
    BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * x,
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: cnt,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: lbl,
        hintText: hnt,
      ),
    ),
  );
}
