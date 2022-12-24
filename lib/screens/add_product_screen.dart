import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';

import '../widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
                  hintText: "FİYAT",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "ADET",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "RENK",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "BEDEN",
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextFieldComponent(
                  hintText: "MARKA",
                ),
                const SizedBox(
                  height: 24,
                ),
                MenuButton(
                  text: "ÜRÜN OLUŞTUR",
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
