import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_form_field.dart';

import '../../backend/theme.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

List<Map<dynamic, dynamic>> listedProducts = [];

TextEditingController nameController = TextEditingController();
TextEditingController specController = TextEditingController();
TextEditingController minAmountController = TextEditingController();
TextEditingController maxAmountController = TextEditingController();
TextEditingController minPriceController = TextEditingController();
TextEditingController maxPriceController = TextEditingController();

class ListProductsScreen extends StatefulWidget {
  const ListProductsScreen({Key? key}) : super(key: key);

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    nameController.clear();
    specController.clear();
    minAmountController.clear();
    maxAmountController.clear();
    minPriceController.clear();
    maxPriceController.clear();
    listedProducts = DatabaseService()
        .getProducts(null, null, null, null, null, null, null, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Ürünler',
            leftButtonText: "Ana Sayfa",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            rightButtonText: "Silinen Ürünler",
            rightButtonAction: () {
              Navigator.pushReplacementNamed(context, '/list_deleted_products');
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ProductsListSearchBar(
                      notifyParent: refresh,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ItemTable(
                        titlesBar: const ProductsListTitlesBar(),
                        items: [
                          for (int i = 0; i < listedProducts.length; i++)
                            ProductsListItem(
                              product: listedProducts[i],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  const ProductsListSearchBar({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: "Ürün Ekle",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/add_product');
                },
                height: 50,
                width: 120,
                textColor: YMColors().white,
                bgColor: YMColors().grey,
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "İsim",
                          height: 50,
                          controller: nameController,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "Özellik",
                          height: 50,
                          controller: specController,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "Fiyat (En Az)",
                          height: 50,
                          controller: minPriceController,
                          inputType: double,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "Fiyat (En Fazla)",
                          height: 50,
                          controller: maxPriceController,
                          inputType: double,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "Adet (En Az)",
                          height: 50,
                          controller: minAmountController,
                          inputType: int,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          hintText: "Adet (En Fazla)",
                          height: 50,
                          controller: maxAmountController,
                          inputType: int,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTableVerticalSeperator(
              color: YMColors().grey,
              space: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CustomButton(
                      text: "Ara",
                      onPressed: () {
                        listedProducts = DatabaseService().getProducts(
                          null,
                          (nameController.text.isEmpty)
                              ? null
                              : nameController.text,
                          (specController.text.isEmpty)
                              ? null
                              : specController.text,
                          (minPriceController.text.isEmpty)
                              ? null
                              : double.parse(minPriceController.text),
                          (maxPriceController.text.isEmpty)
                              ? null
                              : double.parse(maxPriceController.text),
                          (minAmountController.text.isEmpty)
                              ? null
                              : int.parse(minAmountController.text),
                          (maxAmountController.text.isEmpty)
                              ? null
                              : int.parse(maxAmountController.text),
                          true,
                        );
                        notifyParent();
                      },
                      height: 50,
                      width: 80,
                      textColor: YMColors().white,
                      bgColor: YMColors().blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CustomButton(
                      text: "Sıfırla",
                      onPressed: () {
                        nameController.clear();
                        specController.clear();
                        minAmountController.clear();
                        maxAmountController.clear();
                        minPriceController.clear();
                        maxPriceController.clear();
                        listedProducts = DatabaseService().getProducts(
                            null, null, null, null, null, null, null, true);
                        notifyParent();
                      },
                      height: 50,
                      width: 80,
                      textColor: YMColors().white,
                      bgColor: YMColors().red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsListTitlesBar extends StatelessWidget {
  const ProductsListTitlesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  "ID",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: YMColors().black,
                    fontSize: YMSizes().fontSizeMedium,
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "İsim",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Marka",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Kategori",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Renk",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Boyut",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Fiyat",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Adet",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
              ),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              Container(
                height: 70,
                width: 300,
                alignment: Alignment.center,
                child: Text(
                  "İşlemler",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: YMColors().black,
                    fontSize: YMSizes().fontSizeMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsListItem extends StatelessWidget {
  final Map<dynamic, dynamic> product;
  const ProductsListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: YMColors().white,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    (product[Product().id] != null)
                        ? product[Product().id].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().grey,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().name] != null)
                        ? product[Product().name].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().brand] != null)
                        ? product[Product().brand].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().categoryName] != null)
                        ? product[Product().categoryName].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().color] != null)
                        ? product[Product().color].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().size] != null &&
                            product[Product().sizeType] != null)
                        ? "${product[Product().size]} (${product[Product().sizeType]})"
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().price] != null)
                        ? product[Product().price].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (product[Product().amount] != null)
                        ? product[Product().amount].toString()
                        : "-",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: YMColors().black,
                      fontSize: YMSizes().fontSizeMedium,
                    ),
                  ),
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomButton(
                          text: "Düzenle",
                          bgColor: YMColors().grey,
                          textColor: YMColors().white,
                          onPressed: () {
                            editedItem = product;
                            Navigator.pushReplacementNamed(
                                context, '/edit_product');
                          },
                          height: 50,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomButton(
                          text: "Al",
                          bgColor: YMColors().blue,
                          textColor: YMColors().white,
                          onPressed: () {
                            editedItem = product;
                            selectedItem = null;
                            Navigator.pushReplacementNamed(
                                context, '/buy_product');
                          },
                          height: 50,
                          width: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomButton(
                          text: "Sat",
                          bgColor: YMColors().red,
                          textColor: YMColors().white,
                          onPressed: () {
                            editedItem = product;
                            Navigator.pushReplacementNamed(
                                context, '/sell_product');
                          },
                          height: 50,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            height: 2,
            thickness: 2,
            color: YMColors().lightGrey,
          ),
        ],
      ),
    );
  }
}
