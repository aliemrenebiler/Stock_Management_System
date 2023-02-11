import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/custom_button.dart';
import 'package:yildiz_motor_v2/widgets/custom_select_form_field.dart';
import 'package:yildiz_motor_v2/widgets/custom_top_bar.dart';

import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController sizeTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    nameController.text = editedItem[Product().name];
    brandController.text = editedItem[Product().brand];
    colorController.text = editedItem[Product().color];
    sizeController.text = editedItem[Product().size];
    sizeTypeController.text = editedItem[Product().sizeType];
    priceController.text = editedItem[Product().price];
    amountController.text = editedItem[Product().amount];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Ürün Ekle',
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
                                            child: CustomButton(
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
                                      child: CustomTextFormField(
                                        height: 50,
                                        controller: nameController,
                                        hintText:
                                            '(Zorunlu) "Otomatik Doldur" ile diğer alanları doldurun!',
                                        action: TextInputAction.next,
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
                                            child: CustomSelectionField(
                                              selectionText:
                                                  (selectedItem == null)
                                                      ? null
                                                      : selectedItem![
                                                          Category().name],
                                              onPressed: () {
                                                editedItem[Product().name] =
                                                    nameController.text;
                                                editedItem[Product().brand] =
                                                    brandController.text;
                                                editedItem[Product().color] =
                                                    colorController.text;
                                                editedItem[Product().size] =
                                                    sizeController.text;
                                                editedItem[Product().sizeType] =
                                                    sizeTypeController.text;
                                                editedItem[Product().price] =
                                                    priceController.text;
                                                editedItem[Product().amount] =
                                                    amountController.text;
                                                routeStack.add("/add_product");
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    "/select_category");
                                              },
                                              notifyParent: refresh,
                                              isRequired: true,
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
                                            child: CustomTextFormField(
                                              height: 50,
                                              controller: brandController,
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
                                            child: CustomTextFormField(
                                              height: 50,
                                              controller: colorController,
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
                                            child: CustomTextFormField(
                                              height: 50,
                                              controller: sizeController,
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
                                            child: CustomTextFormField(
                                              height: 50,
                                              controller: sizeTypeController,
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
                                              height: 50,
                                              hintText: "(Zorunlu)",
                                              controller: amountController,
                                              inputType: int,
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
                                child: CustomButton(
                                  text: "Temizle",
                                  onPressed: () {
                                    nameController.clear();
                                    brandController.clear();
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
                                child: CustomButton(
                                  text: "Ekle",
                                  onPressed: () {
                                    if (nameController.text.isEmpty ||
                                        priceController.text.isEmpty ||
                                        amountController.text.isEmpty ||
                                        selectedItem == null) {
                                      showCustomSnackBar(
                                        context,
                                        "Lütfen zorunlu alanları doldurunuz.",
                                        YMColors().white,
                                        YMColors().red,
                                      );
                                    } else {
                                      DatabaseService().insertProduct({
                                        Product().id: null,
                                        Product().name: nameController.text,
                                        Product().brand:
                                            (brandController.text.isEmpty)
                                                ? null
                                                : brandController.text,
                                        Product().categoryID:
                                            selectedItem![Category().id],
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
                                        Product().visible: 1,
                                      });
                                      showCustomSnackBar(
                                        context,
                                        "Yeni ürün eklendi.",
                                        YMColors().white,
                                        YMColors().blue,
                                      );
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
