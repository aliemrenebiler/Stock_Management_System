import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_field.dart';

import '../../backend/theme.dart';
import '../../widgets/list_table.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

List<Map<dynamic, dynamic>> listedProducts = [];
bool showDeletedItems = false;

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
    listedProducts = DatabaseService()
        .getProducts(null, null, null, null, null, null, null, true);
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
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: MenuButton(
                    text: "Ana Sayfa",
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
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Ürünler",
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
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: MenuButton(
                    text: showDeletedItems ? "Geri" : "Silinenler",
                    onPressed: () {
                      listedProducts = DatabaseService().getProducts(null, null,
                          null, null, null, null, null, showDeletedItems);
                      showDeletedItems = !showDeletedItems;
                      refresh();
                    },
                    height: 50,
                    textColor: YMColors().white,
                    bgColor: YMColors().red,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: MenuButton(
                    text: "Ürün Ekle",
                    bgColor: YMColors().red,
                    textColor: YMColors().white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/add_product');
                    },
                    height: 50,
                  ),
                ),
              ),
            ],
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
                      child: ListTable(
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
    TextEditingController nameController = TextEditingController();
    TextEditingController specController = TextEditingController();
    TextEditingController minAmountController = TextEditingController();
    TextEditingController maxAmountController = TextEditingController();
    TextEditingController minPriceController = TextEditingController();
    TextEditingController maxPriceController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MenuButton(
                  text: "Temizle",
                  onPressed: () {
                    listedProducts = DatabaseService().getProducts(
                        null, null, null, null, null, null, null, null);
                    notifyParent();
                  },
                  height: 50,
                  textColor: YMColors().white,
                  bgColor: YMColors().grey,
                ),
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
                        child: CustomTextField(
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
                        child: CustomTextField(
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
                        child: CustomTextField(
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
                        child: CustomTextField(
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
                        child: CustomTextField(
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
                        child: CustomTextField(
                          hintText: "Adet (En Fazla)",
                          height: 50,
                          controller: maxAmountController,
                          inputType: int,
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MenuButton(
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
                      false,
                    );
                    notifyParent();
                  },
                  height: 50,
                  textColor: YMColors().white,
                  bgColor: YMColors().red,
                ),
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
      decoration: BoxDecoration(
        color: YMColors().lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const ListTableTitlesBarItem(text: "ID", flex: 1),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "İsim", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Marka", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Kategori", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Renk", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Boyut", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Birim", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Fiyat", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Adet", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "İşlemler", flex: 6),
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
                ListTableItemPart(
                  value: (product[Product().id] != null)
                      ? product[Product().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().name] != null)
                      ? product[Product().name].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().brand] != null)
                      ? product[Product().brand].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().category] != null)
                      ? product[Product().category].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().color] != null)
                      ? product[Product().color].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().size] != null)
                      ? product[Product().size].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().sizeType] != null)
                      ? product[Product().sizeType].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().price] != null)
                      ? product[Product().price].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (product[Product().amount] != null)
                      ? product[Product().amount].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Düzenle",
                              bgColor: YMColors().grey,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = product;
                                Navigator.pushReplacementNamed(
                                    context, '/edit_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Alım",
                              bgColor: YMColors().blue,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = product;
                                Navigator.pushReplacementNamed(
                                    context, '/buy_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satış",
                              bgColor: YMColors().red,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = product;
                                Navigator.pushReplacementNamed(
                                    context, '/sell_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
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
