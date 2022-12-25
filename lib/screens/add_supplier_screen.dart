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
                    hintText: "SOYAD",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "TELEFON",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "E-MAIL",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextFieldComponent(
                    height: 50,
                    width: 320,
                    hintText: "ŞİRKET",
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
