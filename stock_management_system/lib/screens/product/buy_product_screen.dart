import 'package:flutter/material.dart';

import '../../widgets/custom_select_form_field.dart';
import '../../widgets/custom_stable_form_field.dart';
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
    priceController.text = editedItem[Purchase.price["database"]];
    amountController.text = editedItem[Purchase.amount["database"]];
    dayController.text = editedItem[Purchase.date["database"]].split("-")[2];
    monthController.text =
        editedItem[Purchase.date["database"]].split("-")[1].padLeft(2, "0");
    yearController.text =
        editedItem[Purchase.date["database"]].split("-")[0].padLeft(2, "0");
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
              Navigator.pushReplacementNamed(context, routeStack.removeLast());
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
                                            "Ürün",
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
                                          child: CustomStableField(
                                            height: 50,
                                            selectionText:
                                                "[${stableItem[Product.id["database"]]}] ${stableItem[Product.name["database"]]}",
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
                                          child: CustomStableField(
                                            height: 50,
                                            selectionText: stableItem[
                                                Product.brand["database"]],
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
                                          child: CustomStableField(
                                            height: 50,
                                            selectionText: stableItem[Product
                                                .categoryName["database"]],
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
                                          child: CustomStableField(
                                            height: 50,
                                            selectionText: stableItem[
                                                Product.color["database"]],
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
                                          child: CustomStableField(
                                            height: 50,
                                            selectionText: (stableItem[Product
                                                        .size["database"]] ==
                                                    null)
                                                ? null
                                                : (stableItem[Product.sizeUnit[
                                                            "database"]] ==
                                                        null)
                                                    ? stableItem[Product
                                                        .size["database"]]
                                                    : "${stableItem[Product.size["database"]]} (${stableItem[Product.sizeUnit["database"]]})",
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
                                            "Tedarikçi",
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
                                          child: CustomSelectionField(
                                            selectionText: (selectedItem ==
                                                    null)
                                                ? null
                                                : selectedItem![
                                                    Supplier.name["database"]],
                                            onPressed: () {
                                              editedItem[Purchase
                                                      .price["database"]] =
                                                  priceController.text;
                                              editedItem[Purchase
                                                      .amount["database"]] =
                                                  amountController.text;
                                              editedItem[Purchase
                                                      .date["database"]] =
                                                  "${yearController.text}-${monthController.text}-${dayController.text}";
                                              routeStack.add('/buy_product');
                                              Navigator.pushReplacementNamed(
                                                  context, "/select_supplier");
                                            },
                                            notifyParent: refresh,
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
                                          Purchase.id["database"]: null,
                                          Purchase.supplierID["database"]:
                                              (selectedItem != null)
                                                  ? selectedItem![
                                                      Supplier.id["database"]]
                                                  : null,
                                          Purchase.productID["database"]:
                                              stableItem[
                                                  Product.id["database"]],
                                          Purchase.price["database"]:
                                              double.parse(
                                                  priceController.text),
                                          Purchase.amount["database"]:
                                              int.parse(amountController.text),
                                          Purchase.date["database"]: date,
                                        },
                                      );
                                      DatabaseService().updateProduct(
                                        {
                                          Product.id["database"]: stableItem[
                                              Product.id["database"]],
                                          Product.name["database"]: stableItem[
                                              Product.name["database"]],
                                          Product.brand["database"]: stableItem[
                                              Product.brand["database"]],
                                          Product.categoryID["database"]:
                                              stableItem[Product
                                                  .categoryID["database"]],
                                          Product.color["database"]: stableItem[
                                              Product.color["database"]],
                                          Product.size["database"]: stableItem[
                                              Product.size["database"]],
                                          Product.sizeUnit["database"]:
                                              stableItem[
                                                  Product.sizeUnit["database"]],
                                          Product.price["database"]: stableItem[
                                              Product.price["database"]],
                                          Product
                                              .amount["database"]: stableItem[
                                                  Product.amount["database"]] +
                                              int.parse(amountController.text),
                                          Product.visible["database"]:
                                              stableItem[
                                                  Product.visible["database"]],
                                        },
                                      );
                                      showCustomSnackBar(
                                        context,
                                        "Alım işlemi başarılı.",
                                        YMColors().white,
                                        YMColors().blue,
                                      );
                                      Navigator.pushReplacementNamed(
                                          context, routeStack.removeLast());
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
