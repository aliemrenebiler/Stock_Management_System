import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/screens/add_product_screen.dart';
import 'package:yildiz_motor_v2/screens/add_supplier_screen.dart';
import 'package:yildiz_motor_v2/screens/list_product_screen.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Container(
        padding:
            const EdgeInsets.only(left: 300, right: 300, top: 150, bottom: 150),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      width: 600,
                      decoration: const BoxDecoration(),
                      child: Image.asset(
                        "assets/images/ym_logo.jpeg",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuButton(
                      text: "ÜRÜNLERİ LİSTELE",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/list_products');
                      },
                      width: 320,
                      height: 50,
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MenuButton(
                      text: "TEDARİKÇİ LİSTELE",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/list_suppliers');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: 320,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MenuButton(
                      text: "ÜRÜN EKLE",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/add_product');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: 320,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MenuButton(
                      text: "TEDARİKÇİ EKLE",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/add_supplier');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: 320,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
