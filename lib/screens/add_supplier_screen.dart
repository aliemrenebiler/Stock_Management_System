import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';
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
                  "Tedarikçi Ekle",
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
                      "AD:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "SOYAD:",
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
                      "E-MAIL:",
                      style: TextStyle(
                        fontSize: YMSizes().fontSizeMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "ŞİRKET:",
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
                        hintText: "SOYAD",
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
                        hintText: "E-MAIL",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldComponent(
                        hintText: "ŞİRKET",
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MenuButton(
                        text: "TEDARİKÇİ EKLE",
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
