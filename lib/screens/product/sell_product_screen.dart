import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({super.key});

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
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
                  height: 50,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  "Satış Yap",
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
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: YMColors().lightGrey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "ID: ... | İsim ...",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: YMSizes().fontSizeMedium,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                "Fiyat",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize:
                                                      YMSizes().fontSizeMedium,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: TextFieldComponent(
                                                height: 50,
                                                hintText: "(Zorunlu)",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                "Adet",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize:
                                                      YMSizes().fontSizeMedium,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: TextFieldComponent(
                                                height: 50,
                                                hintText:
                                                    "(Zorunlu) Güncel Adet: ...",
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
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: MenuButton(
                                      text: "İptal Et",
                                      onPressed: () {},
                                      bgColor: YMColors().grey,
                                      textColor: YMColors().white,
                                      height: 50,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: MenuButton(
                                      text: "Ekle",
                                      onPressed: () {},
                                      bgColor: YMColors().blue,
                                      textColor: YMColors().white,
                                      height: 50,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
            ),
          ),
        ],
      ),
    );
  }
}
