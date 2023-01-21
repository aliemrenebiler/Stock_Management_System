import 'package:flutter/material.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_pop_up.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class EditSaleScreen extends StatefulWidget {
  const EditSaleScreen({super.key});

  @override
  State<EditSaleScreen> createState() => _EditSaleScreenState();
}

class _EditSaleScreenState extends State<EditSaleScreen> {
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    productController.text = editedItem[Sale().productID].toString();
    priceController.text = editedItem[Sale().price].toString();
    amountController.text = editedItem[Sale().amount].toString();
    dateController.text = editedItem[Sale().date];
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
            title: 'Satış Düzenle',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/list_sales');
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
                                        showCustomPopUp(
                                          context,
                                          SizedBox(
                                            width: YMSizes().maxWidth,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  height: 50,
                                                  child: Text(
                                                    "Bu satış silinecek.",
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: YMColors().black,
                                                      fontSize: YMSizes()
                                                          .fontSizeSmall,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomButton(
                                                          text: "İptal Et",
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          bgColor:
                                                              YMColors().grey,
                                                          textColor:
                                                              YMColors().white,
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomButton(
                                                          text: "Sil",
                                                          onPressed: () {
                                                            DatabaseService()
                                                                .deleteSale(
                                                                    editedItem[
                                                                        Sale()
                                                                            .id]);
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    "/list_sales");
                                                          },
                                                          bgColor:
                                                              YMColors().red,
                                                          textColor:
                                                              YMColors().white,
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
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
                                          DatabaseService().updateSale(
                                            {
                                              Sale().id: editedItem[Sale().id],
                                              Sale().productID: int.parse(
                                                  productController.text),
                                              Sale().date: dateController.text,
                                              Sale().price: double.parse(
                                                  priceController.text),
                                              Sale().amount: int.parse(
                                                  amountController.text),
                                            },
                                          );
                                          Navigator.pushReplacementNamed(
                                              context, "/list_sales");
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
