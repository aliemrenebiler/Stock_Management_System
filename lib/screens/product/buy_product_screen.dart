import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({super.key});

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController dateController = TextEditingController();
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
                  "Alım Yap",
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
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: YMColors().lightGrey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Ürün ID: ${editedItem[Product().id]} | İsim: ${editedItem[Product().name]}",
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
                                            "Alım Fiyatı",
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
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CustomTextField(
                                            height: 50,
                                            hintText: "(Zorunlu)",
                                            controller: priceController,
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
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CustomTextField(
                                            height: 50,
                                            hintText: "(Zorunlu)",
                                            controller: amountController,
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
                                            "Tarih",
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
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CustomTextField(
                                            height: 50,
                                            hintText: "(Zorunlu)",
                                            controller: dateController,
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
                                  text: "Temizle",
                                  onPressed: () {
                                    priceController.clear();
                                    amountController.clear();
                                    dateController.clear();
                                  },
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
                                  onPressed: () {
                                    if (priceController.text.isNotEmpty &&
                                        amountController.text.isNotEmpty &&
                                        dateController.text.isNotEmpty) {
                                      DatabaseService().insertPurchase(
                                        {
                                          Purchase().id: null,
                                          Purchase().supplierID: null,
                                          Purchase().productID:
                                              editedItem[Product().id],
                                          Purchase().price: double.parse(
                                              priceController.text),
                                          Purchase().amount:
                                              int.parse(amountController.text),
                                          Purchase().date: dateController.text,
                                        },
                                      );
                                      DatabaseService().updateProduct(
                                        {
                                          Product().id:
                                              editedItem[Product().id],
                                          Product().name:
                                              editedItem[Product().name],
                                          Product().brand:
                                              editedItem[Product().brand],
                                          Product().category:
                                              editedItem[Product().category],
                                          Product().color:
                                              editedItem[Product().color],
                                          Product().size:
                                              editedItem[Product().size],
                                          Product().sizeType:
                                              editedItem[Product().sizeType],
                                          Product().price:
                                              editedItem[Product().price],
                                          Product().amount: editedItem[
                                                  Product().amount] +
                                              int.parse(amountController.text),
                                        },
                                      );
                                      Navigator.pushReplacementNamed(
                                          context, "/list_products");
                                    }
                                  },
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
