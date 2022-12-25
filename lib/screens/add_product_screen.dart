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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "AD",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "FİYAT",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "ADET",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "RENK",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "BEDEN",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "MARKA",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MenuButton(
                    text: "TEDARİKÇİ EKLE",
                    onPressed: () {},
                    width: 320,
                    height: 50,
                    bgColor: YMColors().red,
                    textColor: YMColors().white,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
