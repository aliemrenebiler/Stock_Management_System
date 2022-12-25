import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_field.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  "Ürün Düzenle",
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "İSİM:",
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
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "KATEGORİ:",
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
                      "BOYUT:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "BİRİM:",
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
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const TextFieldComponent(
                        hintText: "İSİM",
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
                      const TextFieldComponent(
                        hintText: "KATEGORİ",
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
                        hintText: "BOYUT",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "BİRİM",
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
                      MenuButton(
                        text: "KAYDET",
                        onPressed: () {},
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        height: 40,
                        width: double.infinity,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
