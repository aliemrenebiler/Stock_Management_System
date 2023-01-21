import 'package:flutter/material.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class EditPurchaseScreen extends StatefulWidget {
  const EditPurchaseScreen({super.key});

  @override
  State<EditPurchaseScreen> createState() => _EditPurchaseScreenState();
}

class _EditPurchaseScreenState extends State<EditPurchaseScreen> {
  TextEditingController supplierController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    if (editedItem[Purchase().supplierID] != null) {
      supplierController.text = editedItem[Purchase().supplierID].toString();
    }
    productController.text = editedItem[Purchase().productID].toString();
    priceController.text = editedItem[Purchase().price].toString();
    amountController.text = editedItem[Purchase().amount].toString();
    dateController.text = editedItem[Purchase().date];
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
          CustomTopBar(
            title: 'Alım Düzenle',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/list_purchases');
            },
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
                                                "Tedarikçi ID",
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
                                              child: CustomTextFormField(
                                                height: 50,
                                                controller: supplierController,
                                                action: TextInputAction.next,
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
                                                "Ürün ID",
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
                                              child: CustomTextFormField(
                                                height: 50,
                                                hintText: "(Zorunlu)",
                                                controller: productController,
                                                action: TextInputAction.next,
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
                                              child: CustomTextFormField(
                                                height: 50,
                                                hintText: "(Zorunlu)",
                                                controller: priceController,
                                                action: TextInputAction.next,
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
                                              child: CustomTextFormField(
                                                height: 50,
                                                hintText: "(Zorunlu)",
                                                controller: amountController,
                                                action: TextInputAction.next,
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
                                              child: CustomTextFormField(
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
                                    child: CustomButton(
                                      text: "Sil",
                                      onPressed: () {
                                        DatabaseService().deletePurchase(
                                            editedItem[Purchase().id]);
                                        Navigator.pushReplacementNamed(
                                            context, "/list_purchases");
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
                                    child: CustomButton(
                                      text: "Kaydet",
                                      onPressed: () {
                                        if (productController.text.isNotEmpty &&
                                            dateController.text.isNotEmpty &&
                                            priceController.text.isNotEmpty &&
                                            amountController.text.isNotEmpty) {
                                          DatabaseService().updatePurchase({
                                            Purchase().id:
                                                editedItem[Purchase().id],
                                            Purchase()
                                                .supplierID: (supplierController
                                                    .text.isEmpty)
                                                ? null
                                                : int.parse(
                                                    supplierController.text),
                                            Purchase().productID: int.parse(
                                                productController.text),
                                            Purchase().date:
                                                dateController.text,
                                            Purchase().price: double.parse(
                                                priceController.text),
                                            Purchase().amount: int.parse(
                                                amountController.text),
                                          });
                                          Navigator.pushReplacementNamed(
                                              context, "/list_purchases");
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
