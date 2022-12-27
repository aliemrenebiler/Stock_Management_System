import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/menu_button.dart';
import '../widgets/top_bar.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController sizeTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    nameController.text = editedItem[Product().name];
    brandController.text = editedItem[Product().brand];
    categoryController.text = editedItem[Product().category];
    colorController.text = editedItem[Product().color];
    sizeController.text = editedItem[Product().size];
    sizeTypeController.text = editedItem[Product().sizeType];
    priceController.text = editedItem[Product().price].toString();
    amountController.text = editedItem[Product().amount].toString();
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
                  "Ürün Düzenle",
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
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                "İsim",
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
                                              child: TextFieldComponent(
                                                height: 50,
                                                hintText: "(Zorunlu)",
                                                controller: nameController,
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                              child: TextFieldComponent(
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
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: MenuButton(
                                      text: "Sil",
                                      onPressed: () {
                                        DatabaseService().deleteProduct(
                                            editedItem[Product().id]);
                                        Navigator.pushReplacementNamed(
                                            context, "/list_products");
                                      },
                                      bgColor: YMColors().red,
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
                                        DatabaseService().updateProduct({
                                          Product().id:
                                              editedItem[Product().id],
                                          Product().name:
                                              (nameController.text.isEmpty)
                                                  ? null
                                                  : nameController.text,
                                          Product().brand:
                                              (brandController.text.isEmpty)
                                                  ? null
                                                  : brandController.text,
                                          Product().category:
                                              (categoryController.text.isEmpty)
                                                  ? null
                                                  : categoryController.text,
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
                                              (priceController.text.isEmpty)
                                                  ? null
                                                  : double.parse(
                                                      priceController.text),
                                          Product().amount:
                                              (amountController.text.isEmpty)
                                                  ? null
                                                  : int.parse(
                                                      amountController.text),
                                        });
                                        nameController.clear();
                                        brandController.clear();
                                        categoryController.clear();
                                        colorController.clear();
                                        sizeController.clear();
                                        sizeTypeController.clear();
                                        priceController.clear();
                                        amountController.clear();
                                        Navigator.pushReplacementNamed(
                                            context, "/list_products");
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
