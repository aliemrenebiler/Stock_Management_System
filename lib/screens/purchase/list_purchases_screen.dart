import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../backend/theme.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

List<Map<dynamic, dynamic>> listedPurchases = [];

class ListPurchasesScreen extends StatefulWidget {
  const ListPurchasesScreen({Key? key}) : super(key: key);

  @override
  State<ListPurchasesScreen> createState() => _ListPurchasesScreenState();
}

class _ListPurchasesScreenState extends State<ListPurchasesScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    listedPurchases =
        DatabaseService().getPurchases(null, null, null, null, null, null);
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
            widgets: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CustomButton(
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
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Alımlar",
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
                  child: CustomButton(
                    text: "Tedarikçiler",
                    bgColor: YMColors().red,
                    textColor: YMColors().white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/list_suppliers');
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
                    child: PurchasesListSearchBar(notifyParent: refresh),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ItemTable(
                        titlesBar: const PurchasesListTitlesBar(),
                        items: [
                          for (int i = 0; i < listedPurchases.length; i++)
                            PurchasesListItem(
                              purchase: listedPurchases[i],
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

class PurchasesListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  const PurchasesListSearchBar({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
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
                child: CustomButton(
                  text: "Temizle",
                  onPressed: () {
                    listedPurchases = DatabaseService()
                        .getPurchases(null, null, null, null, null, null);
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
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextFormField(
                  hintText: "Tarih",
                  height: 50,
                  controller: dateController,
                  action: TextInputAction.next,
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
                child: CustomButton(
                  text: "Ara",
                  onPressed: () {
                    listedPurchases = DatabaseService().getPurchases(
                      null,
                      (dateController.text.isEmpty)
                          ? null
                          : dateController.text,
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

class PurchasesListTitlesBar extends StatelessWidget {
  const PurchasesListTitlesBar({super.key});

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
              const ItemTableTitlesBarItem(text: "ID", flex: 1),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "Tedarikçi", flex: 3),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "Ürün", flex: 8),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "Fiyat", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "Adet", flex: 2),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "Tarih", flex: 3),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ItemTableTitlesBarItem(text: "İşlemler", flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchasesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> purchase;
  const PurchasesListItem({
    super.key,
    required this.purchase,
  });

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic>? product;
    Map<dynamic, dynamic>? supplier;
    String productInfo = "-";
    String supplierInfo = "-";

    if (purchase[Purchase().supplierID] != null) {
      try {
        supplier = DatabaseService().getSuppliers(
          purchase[Purchase().supplierID],
          null,
        )[0];
      } catch (_) {
        supplier = null;
      }

      if (supplier != null) {
        supplierInfo = supplier[Supplier().name];
      }
    }

    try {
      product = DatabaseService().getProducts(purchase[Purchase().productID],
          null, null, null, null, null, null, null)[0];
    } catch (_) {
      product = null;
    }

    if (product != null) {
      productInfo = "${product[Product().name]}";

      if (product[Product().brand] != null) {
        productInfo += " - ${product[Product().brand]} Marka";
      }
      if (product[Product().color] != null) {
        productInfo += " - ${product[Product().color]} Renk";
      }
      if (product[Product().color] != null) {
        productInfo +=
            " - ${product[Product().size]} ${product[Product().sizeType]}";
      }
    }

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
                  value: (purchase[Purchase().id] != null)
                      ? purchase[Purchase().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: supplierInfo,
                  flex: 3,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: productInfo,
                  flex: 8,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (purchase[Purchase().price] != null)
                      ? purchase[Purchase().price].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (purchase[Purchase().amount] != null)
                      ? purchase[Purchase().amount].toString()
                      : null,
                  flex: 2,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (purchase[Purchase().date] != null)
                      ? purchase[Purchase().date].toString()
                      : null,
                  flex: 3,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      text: "Düzenle",
                      bgColor: YMColors().grey,
                      textColor: YMColors().white,
                      onPressed: () {
                        editedItem = purchase;
                        Navigator.pushReplacementNamed(
                            context, '/edit_purchase');
                      },
                      height: 50,
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
