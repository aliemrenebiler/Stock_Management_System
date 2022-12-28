import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_text_field.dart';
import '../../backend/theme.dart';
import '../../widgets/list_table.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

List<Map<dynamic, dynamic>> listedPurchases = [];
List<Map<dynamic, dynamic>> listedSales = [];

class ListFinancialsScreen extends StatefulWidget {
  const ListFinancialsScreen({Key? key}) : super(key: key);

  @override
  State<ListFinancialsScreen> createState() => _ListFinancialsScreenState();
}

class _ListFinancialsScreenState extends State<ListFinancialsScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    listedPurchases = DatabaseService().getPurchases(null, null, null);
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
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  height: 50,
                ),
              ),
              Expanded(
                flex: 10,
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
              Expanded(
                flex: 1,
                child: Container(),
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
                    child: FinancialsListSearchBar(notifyParent: refresh),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListTable(
                        titlesBar: const PurchasesTitlesBar(),
                        items: [
                          for (int i = 0; i < listedPurchases.length; i++)
                            PurchasesListItem(
                              income: listedPurchases[i],
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

class FinancialsListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  const FinancialsListSearchBar({super.key, required this.notifyParent});

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
                    listedPurchases = DatabaseService()
                        .getProducts(null, null, null, null, null, null, null);
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
                        child: TextFieldComponent(
                          hintText: "İsim",
                          height: 50,
                          controller: nameController,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Özellik",
                          height: 50,
                          controller: specController,
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
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Az)",
                          height: 50,
                          controller: minPriceController,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Fazla)",
                          height: 50,
                          controller: maxPriceController,
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
                        child: TextFieldComponent(
                          hintText: "Adet (En Az)",
                          height: 50,
                          controller: minAmountController,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Adet (En Fazla)",
                          height: 50,
                          controller: maxAmountController,
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
                    listedPurchases = DatabaseService().getProducts(
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

class PurchasesTitlesBar extends StatelessWidget {
  const PurchasesTitlesBar({super.key});

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
              const ListTableTitlesBarItem(text: "İşlemler", flex: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesTitlesBar extends StatelessWidget {
  const SalesTitlesBar({super.key});

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
              const ListTableTitlesBarItem(text: "İşlemler", flex: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchasesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> income;
  const PurchasesListItem({
    super.key,
    required this.income,
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
                  value: (income[Product().id] != null)
                      ? income[Product().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().name] != null)
                      ? income[Product().name].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().brand] != null)
                      ? income[Product().brand].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().category] != null)
                      ? income[Product().category].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().color] != null)
                      ? income[Product().color].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().size] != null)
                      ? income[Product().size].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().sizeType] != null)
                      ? income[Product().sizeType].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().price] != null)
                      ? income[Product().price].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (income[Product().amount] != null)
                      ? income[Product().amount].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Düzenle",
                              bgColor: YMColors().grey,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = income;
                                Navigator.pushReplacementNamed(
                                    context, '/edit_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satın Alım",
                              bgColor: YMColors().blue,
                              textColor: YMColors().white,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/buy_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satış Yap",
                              bgColor: YMColors().red,
                              textColor: YMColors().white,
                              onPressed: () {
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

class SalesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> outgoing;
  const SalesListItem({
    super.key,
    required this.outgoing,
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
                  value: (outgoing[Product().id] != null)
                      ? outgoing[Product().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().name] != null)
                      ? outgoing[Product().name].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().brand] != null)
                      ? outgoing[Product().brand].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().category] != null)
                      ? outgoing[Product().category].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().color] != null)
                      ? outgoing[Product().color].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().size] != null)
                      ? outgoing[Product().size].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().sizeType] != null)
                      ? outgoing[Product().sizeType].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().price] != null)
                      ? outgoing[Product().price].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (outgoing[Product().amount] != null)
                      ? outgoing[Product().amount].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Düzenle",
                              bgColor: YMColors().grey,
                              textColor: YMColors().white,
                              onPressed: () {
                                editedItem = outgoing;
                                Navigator.pushReplacementNamed(
                                    context, '/edit_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satın Alım",
                              bgColor: YMColors().blue,
                              textColor: YMColors().white,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/buy_product');
                              },
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Satış Yap",
                              bgColor: YMColors().red,
                              textColor: YMColors().white,
                              onPressed: () {
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
