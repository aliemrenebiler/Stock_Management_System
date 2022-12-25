import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_field.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({super.key});

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
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
                    Navigator.pushReplacementNamed(context, '/list_products');
                  },
                  height: 40,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  "Satın Al",
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
            height: 150,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const TextFieldComponent(
                        height: 40,
                        hintText: "FİYAT",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MenuButton(
                        text: "SATIN AL",
                        onPressed: () {},
                        height: 40,
                        bgColor: YMColors().blue,
                        textColor: YMColors().white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const TextFieldComponent(
                        height: 40,
                        hintText: "ADET",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MenuButton(
                        text: "İPTAL",
                        onPressed: () {},
                        height: 40,
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
