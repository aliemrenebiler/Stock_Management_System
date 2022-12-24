import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../backend/theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/menu_button.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 300, right: 300, top: 150, bottom: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const TextFieldComponent(
                  hintText: "AD",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "SOYAD",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "TELEFON",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "E-MAİL",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "ŞİRKET",
                ),
                const SizedBox(
                  height: 24,
                ),
                MenuButton(
                  text: "TEDARİKÇİ EKLE",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
