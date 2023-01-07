import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';
import 'package:yildiz_motor_v2/widgets/top_bar.dart';

import '../../widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController sizeController = TextEditingController();
    TextEditingController sizeTypeController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          TopBar(
            widgets: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: MenuButton(
                    text: "Geri",
                    bgColor: YMColors().red,
                    textColor: YMColors().white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Ürün Ekle",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().white,
                      fontSize: YMSizes().fontSizeLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                        Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: YMColors().lightGrey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "İsim",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
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
                                            child: MenuButton(
                                              text: "Otomatik Doldur",
                                              onPressed: () {
                                                Map<dynamic, dynamic>
                                                    autoProduct = autoFill(
                                                        nameController.text);

                                                if (autoProduct[
                                                        Product().brand] !=
                                                    null) {
                                                  brandController.text =
                                                      autoProduct[
                                                          Product().brand];
                                                }

                                                if (autoProduct[
                                                        Product().color] !=
                                                    null) {
                                                  colorController.text =
                                                      autoProduct[
                                                          Product().color];
                                                }

                                                if (autoProduct[
                                                        Product().size] !=
                                                    null) {
                                                  sizeController.text =
                                                      autoProduct[
                                                          Product().size];
                                                }

                                                if (autoProduct[
                                                        Product().sizeType] !=
                                                    null) {
                                                  sizeTypeController.text =
                                                      autoProduct[
                                                          Product().sizeType];
                                                }
                                              },
                                              bgColor: YMColors().red,
                                              textColor: YMColors().white,
                                              height: 50,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomTextField(
                                        height: 50,
                                        controller: nameController,
                                        hintText:
                                            '(Zorunlu) "Otomatik Doldur" ile diğer alanları doldurun!',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                height: 2,
                                thickness: 2,
                                color: YMColors().grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "Marka",
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
                                              controller: brandController,
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
                                              "Kategori",
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
                                              controller: categoryController,
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
                                              "Renk",
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
                                              controller: colorController,
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
                                              "Boyut",
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
                                              controller: sizeController,
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
                                              "Birim",
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
                                              controller: sizeTypeController,
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
                                  ],
                                ),
                              )
                            ],
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
                                    nameController.clear();
                                    brandController.clear();
                                    categoryController.clear();
                                    colorController.clear();
                                    sizeController.clear();
                                    sizeTypeController.clear();
                                    priceController.clear();
                                    amountController.clear();
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
                                  text: "Kaydet",
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty &&
                                        categoryController.text.isNotEmpty &&
                                        priceController.text.isNotEmpty &&
                                        amountController.text.isNotEmpty) {
                                      DatabaseService().insertProduct({
                                        Product().id: null,
                                        Product().name: nameController.text,
                                        Product().brand:
                                            (brandController.text.isEmpty)
                                                ? null
                                                : brandController.text,
                                        Product().category:
                                            categoryController.text,
                                        Product().color:
                                            (colorController.text.isEmpty)
                                                ? null
                                                : colorController.text,
                                        Product().size:
                                            (sizeController.text.isEmpty)
                                                ? null
                                                : sizeController.text,
                                        Product().sizeType:
                                            (sizeTypeController.text.isEmpty)
                                                ? null
                                                : sizeTypeController.text,
                                        Product().price:
                                            double.parse(priceController.text),
                                        Product().amount:
                                            int.parse(amountController.text),
                                      });
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
