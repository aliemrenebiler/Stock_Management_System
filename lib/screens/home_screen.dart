import 'package:flutter/material.dart';

import '../backend/theme.dart';
import '../widgets/menu_button.dart';

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
      backgroundColor: YMColors().white,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/images/yildiz_motor_logo.png",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Ürünler",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/list_products');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Tedarikçiler",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/list_suppliers');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Alımlar",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/list_purchases');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Satışlar",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/list_sales');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Ayarlar",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/settings');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: MenuButton(
                      text: "Çıkış Yap",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      bgColor: YMColors().red,
                      textColor: YMColors().white,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
