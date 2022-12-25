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
          child: Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          "assets/images/ym_logo.jpeg",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: MenuButton(
                        text: "Ürünleri Listele",
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/list_products');
                        },
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        width: double.infinity,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: MenuButton(
                        text: "Tedarikçi Listele",
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/list_suppliers');
                        },
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        width: double.infinity,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: MenuButton(
                        text: "Ürün Ekle",
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/add_product');
                        },
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        width: double.infinity,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: MenuButton(
                        text: "Tedarikçi Ekle",
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/add_supplier');
                        },
                        bgColor: YMColors().red,
                        textColor: YMColors().white,
                        width: double.infinity,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
