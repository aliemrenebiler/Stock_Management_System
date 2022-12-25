import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_field.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';

class EditSupplierScreen extends StatefulWidget {
  const EditSupplierScreen({super.key});

  @override
  State<EditSupplierScreen> createState() => _EditSupplierScreenState();
}

class _EditSupplierScreenState extends State<EditSupplierScreen> {
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
                  "Tedarikçi Düzenle",
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
                      "TELEFON:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "ADRES:",
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
                        hintText: "TELEFON",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "ADRES",
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
