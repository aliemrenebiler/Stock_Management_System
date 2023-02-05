import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({super.key});

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    DateTime today = DateTime.now();
    dayController.text = today.day.toString().padLeft(2, "0");
    monthController.text = today.month.toString().padLeft(2, "0");
    yearController.text = today.year.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Ürün Al',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/list_products');
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
                                            "Ürün ID:",
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
                                          child: Text(
                                            editedItem[Product().id].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
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
                                            "Ürün İsmi:",
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
                                          child: Text(
                                            editedItem[Product().name]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
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
                                            "Marka:",
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
                                          child: Text(
                                            editedItem[Product().brand]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
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
                                            "Kategori:",
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
                                          child: Text(
                                            editedItem[Product().categoryName]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
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
                                            "Renk:",
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
                                          child: Text(
                                            editedItem[Product().color]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
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
                                            "Boyut:",
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
                                          child: Text(
                                            "${editedItem[Product().size]} (${editedItem[Product().sizeType]})",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  (selectedItem == null)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  "Tedarikçi",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: YMSizes()
                                                        .fontSizeMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: CustomButton(
                                                  text: "Seç",
                                                  onPressed: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            "/select_supplier");
                                                  },
                                                  textColor: YMColors().white,
                                                  bgColor: YMColors().grey,
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  "Tedarikçi",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: YMSizes()
                                                        .fontSizeMedium,
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
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 50,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: YMColors().white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              YMColors().grey,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "(${selectedItem![Supplier().id]}) ${selectedItem![Supplier().name]}",
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: YMSizes()
                                                              .fontSizeMedium,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CustomButton(
                                                      text: "Kaldır",
                                                      onPressed: () {
                                                        selectedItem = null;
                                                        refresh();
                                                      },
                                                      textColor:
                                                          YMColors().white,
                                                      bgColor: YMColors().grey,
                                                      height: 50,
                                                      width: 80,
                                                    ),
                                                  ),
                                                ],
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
                                          child: CustomTextFormField(
                                            hintText: "(Zorunlu)",
                                            controller: priceController,
                                            inputType: double,
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
                                            hintText: "(Zorunlu)",
                                            controller: amountController,
                                            inputType: int,
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
                                  text: "Temizle",
                                  onPressed: () {
                                    priceController.clear();
                                    amountController.clear();
                                    dayController.clear();
                                    monthController.clear();
                                    yearController.clear();
                                    selectedItem = null;
                                    refresh();
                                  },
                                  bgColor: YMColors().grey,
                                  textColor: YMColors().white,
                                  width: double.infinity,
                                  height: 50,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CustomButton(
                                  text: "Al",
                                  onPressed: () {
                                    if (priceController.text.isEmpty ||
                                        amountController.text.isEmpty ||
                                        dayController.text.isEmpty ||
                                        monthController.text.isEmpty ||
                                        yearController.text.isEmpty) {
                                      showCustomSnackBar(
                                        context,
                                        "Lütfen zorunlu alanları doldurunuz.",
                                        YMColors().white,
                                        YMColors().red,
                                      );
                                    } else if (!validDate(
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
                                          "${yearController.text}-${monthController.text.padLeft(2, "0")}-${dayController.text.padLeft(2, "0")}";
                                      DatabaseService().insertPurchase(
                                        {
                                          Purchase().id: null,
                                          Purchase().supplierID:
                                              (selectedItem != null)
                                                  ? selectedItem![Supplier().id]
                                                  : null,
                                          Purchase().productID:
                                              editedItem[Product().id],
                                          Purchase().price: double.parse(
                                              priceController.text),
                                          Purchase().amount:
                                              int.parse(amountController.text),
                                          Purchase().date: date,
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
                                          Product().categoryName: editedItem[
                                              Product().categoryName],
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
                                          Product().visible:
                                              editedItem[Product().visible],
                                        },
                                      );
                                      showCustomSnackBar(
                                        context,
                                        "Alım işlemi başarılı.",
                                        YMColors().white,
                                        YMColors().blue,
                                      );
                                    }
                                  },
                                  bgColor: YMColors().blue,
                                  textColor: YMColors().white,
                                  width: double.infinity,
                                  height: 50,
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
