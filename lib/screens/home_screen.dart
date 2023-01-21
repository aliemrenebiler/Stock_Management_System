import 'package:flutter/material.dart';

import '../backend/theme.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    child: CustomButton(
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
                    child: CustomButton(
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
                    child: CustomButton(
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
                    child: CustomButton(
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
                    child: CustomButton(
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
