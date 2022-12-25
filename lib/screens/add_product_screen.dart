import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';

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
      body: Column(
        children: [
          TopBar(
            widgets: [
              Expanded(
                flex: 1,
                child: MenuButton(
                  text: "Geri",
                  bgColor: YMColors().red,
                  textColor: YMColors().white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  height: 40,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  "Ürün Ekle",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: YMColors().white,
                    fontSize: YMSizes().fontSizeLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "AD:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "FİYAT:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "ADET:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "RENK:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "BEDEN:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "MARKA:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const TextFieldComponent(
                        hintText: "AD",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "FİYAT",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "ADET",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "RENK",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "BEDEN",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "MARKA",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MenuButton(
                        text: "ÜRÜN EKLE",
                        onPressed: () {},
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        height: 40,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
