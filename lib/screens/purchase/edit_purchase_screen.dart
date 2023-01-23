import 'package:flutter/material.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_pop_up.dart';
import '../../widgets/custom_snack_bar.dart';
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
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    if (editedItem[Purchase().supplierID] != null) {
      supplierController.text = editedItem[Purchase().supplierID].toString();
    }
    List<String> dateList = editedItem[Purchase().date].toString().split(".");
    productController.text = editedItem[Purchase().productID].toString();
    priceController.text = editedItem[Purchase().price].toString();
    amountController.text = editedItem[Purchase().amount].toString();
    dayController.text = dateList[0];
    monthController.text = dateList[1];
    yearController.text = dateList[2];
    super.initState();
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
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: YMSizes().maxWidth,
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
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: CustomTextFormField(
                                                  height: 50,
                                                  hintText: "(Gün)",
                                                  controller: dayController,
                                                  inputType: int,
                                                  maxInputLength: 2,
                                                  action: TextInputAction.next,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: CustomTextFormField(
                                                  height: 50,
                                                  hintText: "(Ay)",
                                                  controller: monthController,
                                                  inputType: int,
                                                  maxInputLength: 2,
                                                  action: TextInputAction.next,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: CustomTextFormField(
                                                  height: 50,
                                                  hintText: "(Yıl)",
                                                  controller: yearController,
                                                  inputType: int,
                                                  maxInputLength: 4,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                              padding: const EdgeInsets.all(5),
                                              height: 50,
                                              child: Text(
                                                "Bu alım silinecek.",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: YMColors().black,
                                                  fontSize:
                                                      YMSizes().fontSizeSmall,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CustomButton(
                                                      text: "İptal Et",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      bgColor: YMColors().grey,
                                                      textColor:
                                                          YMColors().white,
                                                      width: double.infinity,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CustomButton(
                                                      text: "Sil",
                                                      onPressed: () {
                                                        DatabaseService()
                                                            .deletePurchase(
                                                                editedItem[
                                                                    Purchase()
                                                                        .id]);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/list_purchases");
                                                      },
                                                      bgColor: YMColors().red,
                                                      textColor:
                                                          YMColors().white,
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
                                    if (productController.text.isNotEmpty ||
                                        dayController.text.isNotEmpty ||
                                        monthController.text.isNotEmpty ||
                                        yearController.text.isNotEmpty ||
                                        priceController.text.isNotEmpty ||
                                        amountController.text.isNotEmpty) {
                                      showCustomSnackBar(
                                        context,
                                        "Lütfen zorunlu alanları doldurunuz.",
                                        YMColors().white,
                                        YMColors().red,
                                      );
                                    } else if (validDate(
                                      dayController.text,
                                      monthController.text,
                                      yearController.text,
                                    )) {
                                      showCustomSnackBar(
                                        context,
                                        "Lütfen geçerli bir tarih giriniz.",
                                        YMColors().white,
                                        YMColors().red,
                                      );
                                    } else {
                                      String date =
                                          "${dayController.text.padLeft(2, "0")}.${monthController.text.padLeft(2, "0")}.${yearController.text}";
                                      DatabaseService().updatePurchase({
                                        Purchase().id:
                                            editedItem[Purchase().id],
                                        Purchase().supplierID:
                                            (supplierController.text.isEmpty)
                                                ? null
                                                : int.parse(
                                                    supplierController.text),
                                        Purchase().productID:
                                            int.parse(productController.text),
                                        Purchase().date: date,
                                        Purchase().price:
                                            double.parse(priceController.text),
                                        Purchase().amount:
                                            int.parse(amountController.text),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
