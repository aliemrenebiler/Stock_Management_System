import 'package:flutter/material.dart';

import '../backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/custom_top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          const CustomTopBar(
            title: 'Ana Sayfa',
          ),
          Expanded(
            child: Center(
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
                        (DatabaseService().areTablesExists)
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CustomButton(
                                      text: "Ürünler",
                                      onPressed: () {
                                        routeStack.add('/home');
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
                                        routeStack.add('/home');
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
                                        routeStack.add('/home');
                                        Navigator.pushReplacementNamed(
                                            context, '/list_sales');
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
                                      text: "Kategoriler",
                                      onPressed: () {
                                        routeStack.add('/home');
                                        Navigator.pushReplacementNamed(
                                            context, '/list_categories');
                                      },
                                      textColor: YMColors().white,
                                      bgColor: YMColors().grey,
                                      width: double.infinity,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                margin: const EdgeInsets.all(5),
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
                                      Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Herhangi bir tablo mevcut değil.",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: YMSizes().fontSizeSmall,
                                            color: YMColors().black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CustomButton(
                                          text: "Tabloları Oluştur",
                                          height: 50,
                                          textColor: YMColors().white,
                                          bgColor: YMColors().grey,
                                          width: double.infinity,
                                          onPressed: () {
                                            try {
                                              DatabaseService()
                                                  .createCategoriesTable();
                                              DatabaseService()
                                                  .createProductsTable();
                                              DatabaseService()
                                                  .createSuppliersTable();
                                              DatabaseService()
                                                  .createSalesTable();
                                              DatabaseService()
                                                  .createPurchasesTable();

                                              refresh();

                                              if (mounted) {
                                                showCustomSnackBar(
                                                  context,
                                                  "Tablolar oluşturuldu.",
                                                  YMColors().white,
                                                  YMColors().blue,
                                                );
                                              }
                                            } catch (e) {
                                              if (mounted) {
                                                showCustomSnackBar(
                                                  context,
                                                  "Bir hata oluştu: $e",
                                                  YMColors().white,
                                                  YMColors().red,
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    routeStack.add('/home');
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
                                    routeStack.clear();
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
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
          ),
        ],
      ),
    );
  }
}
