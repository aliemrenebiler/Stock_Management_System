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
              width: YMSizes().maxWidth,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
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
                      textColor: YMColors().white,
                      bgColor: YMColors().grey,
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
                      textColor: YMColors().white,
                      bgColor: YMColors().grey,
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
                      textColor: YMColors().white,
                      bgColor: YMColors().grey,
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomButton(
                            text: "Ayarlar",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/settings');
                            },
                            textColor: YMColors().white,
                            bgColor: YMColors().blue,
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomButton(
                            text: "Çıkış Yap",
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            textColor: YMColors().white,
                            bgColor: YMColors().red,
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
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
