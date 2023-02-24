import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';
import '../../widgets/custom_snack_bar.dart';

TextEditingController day1Controller = TextEditingController();
TextEditingController month1Controller = TextEditingController();
TextEditingController year1Controller = TextEditingController();
TextEditingController day2Controller = TextEditingController();
TextEditingController month2Controller = TextEditingController();
TextEditingController year2Controller = TextEditingController();
TextEditingController minAmountController = TextEditingController();
TextEditingController maxAmountController = TextEditingController();
TextEditingController minPriceController = TextEditingController();
TextEditingController maxPriceController = TextEditingController();

String? date1, date2;

clearAll() {
  currentPage = 1;
  day1Controller.clear();
  month1Controller.clear();
  year1Controller.clear();
  day2Controller.clear();
  month2Controller.clear();
  year2Controller.clear();
  minAmountController.clear();
  maxAmountController.clear();
  minPriceController.clear();
  maxPriceController.clear();
  date1 = null;
  date2 = null;
}

getAll() {
  int itemCount = DatabaseService().getPurchases(
    true,
    null,
    date1,
    date2,
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
    null,
    null,
  );
  totalPage = (itemCount / listedItemCount).ceil();
  listedItems = DatabaseService().getPurchases(
    false,
    null,
    date1,
    date2,
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
    listedItemCount,
    (currentPage - 1) * listedItemCount,
  );
}

class ListPurchasesScreen extends StatefulWidget {
  const ListPurchasesScreen({super.key});

  @override
  State<ListPurchasesScreen> createState() => _ListPurchasesScreenState();
}

class _ListPurchasesScreenState extends State<ListPurchasesScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    clearAll();
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Alımlar',
            leftButtonText: "Ana Sayfa",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, routeStack.removeLast());
            },
            rightButtonText: "Tedarikçiler",
            rightButtonAction: () {
              routeStack.add('/list_purchases');
              Navigator.pushReplacementNamed(context, '/list_suppliers');
            },
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
                          for (int i = 0; i < listedItems.length; i++)
                            PurchasesListItem(
                              purchase: listedItems[i],
                            ),
                        ],
                        currentPage: currentPage,
                        totalPage: totalPage,
                        onPressedPrev: () {
                          if (currentPage > 1) {
                            currentPage--;
                            getAll();
                            refresh();
                          }
                        },
                        onPressedNext: () {
                          if (currentPage < totalPage) {
                            currentPage++;
                            getAll();
                            refresh();
                          }
                        },
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
  const PurchasesListSearchBar({
    super.key,
    required this.notifyParent,
  });

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
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Gün)",
                          controller: day1Controller,
                          inputType: int,
                          maxInputLength: 2,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Ay)",
                          controller: month1Controller,
                          inputType: int,
                          maxInputLength: 2,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Yıl)",
                          controller: year1Controller,
                          inputType: int,
                          maxInputLength: 4,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                "—",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: YMSizes().fontSizeMedium,
                  color: YMColors().grey,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Gün)",
                          controller: day2Controller,
                          inputType: int,
                          maxInputLength: 2,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Ay)",
                          controller: month2Controller,
                          inputType: int,
                          maxInputLength: 2,
                          action: TextInputAction.next,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomTextFormField(
                          height: 50,
                          hintText: "(Yıl)",
                          controller: year2Controller,
                          inputType: int,
                          maxInputLength: 4,
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
                        bool searchable = true;
                        if (day1Controller.text.isNotEmpty ||
                            month1Controller.text.isNotEmpty ||
                            year1Controller.text.isNotEmpty) {
                          if (!validDate(
                            day1Controller.text,
                            month1Controller.text,
                            year1Controller.text,
                          )) {
                            searchable = false;
                            showCustomSnackBar(
                              context,
                              "Lütfen geçerli bir tarih giriniz.",
                              YMColors().white,
                              YMColors().red,
                            );
                          } else {
                            date1 =
                                "${year1Controller.text}-${month1Controller.text.padLeft(2, "0")}-${day1Controller.text.padLeft(2, "0")}";
                          }
                        }
                        if (day2Controller.text.isNotEmpty ||
                            month2Controller.text.isNotEmpty ||
                            year2Controller.text.isNotEmpty) {
                          if (!validDate(
                            day2Controller.text,
                            month2Controller.text,
                            year2Controller.text,
                          )) {
                            searchable = false;
                            showCustomSnackBar(
                              context,
                              "Lütfen geçerli bir tarih giriniz.",
                              YMColors().white,
                              YMColors().red,
                            );
                          } else {
                            date2 =
                                "${year2Controller.text}-${month2Controller.text.padLeft(2, "0")}-${day2Controller.text.padLeft(2, "0")}";
                          }
                        }
                        if (searchable) {
                          currentPage = 1;
                          getAll();
                          notifyParent();
                        }
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
                        clearAll();
                        getAll();
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
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "Tedarikçi",
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
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Tarih",
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
                width: 120,
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

class PurchasesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> purchase;
  const PurchasesListItem({
    super.key,
    required this.purchase,
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
                    (purchase[Purchase().id] != null)
                        ? purchase[Purchase().id].toString()
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
                    (purchase[Purchase().supplierName] != null)
                        ? purchase[Purchase().supplierName].toString()
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
                    (purchase[Purchase().productName] != null)
                        ? purchase[Purchase().productName].toString()
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
                    (purchase[Product().brand] != null)
                        ? purchase[Product().brand].toString()
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
                    (purchase[Product().color] != null)
                        ? purchase[Product().color].toString()
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
                    (purchase[Product().size] == null)
                        ? "-"
                        : (purchase[Product().sizeType] == null)
                            ? purchase[Product().size]
                            : "${purchase[Product().size]} (${purchase[Product().sizeType]})",
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
                    (purchase[Purchase().price] != null)
                        ? purchase[Purchase().price].toString()
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
                    (purchase[Purchase().amount] != null)
                        ? purchase[Purchase().amount].toString()
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
                    (purchase[Purchase().formattedDate] != null)
                        ? purchase[Purchase().formattedDate].toString()
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
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    text: "Düzenle",
                    bgColor: YMColors().grey,
                    textColor: YMColors().white,
                    onPressed: () {
                      editedItem = Map.from(purchase);
                      if (editedItem[Purchase().supplierID] != null) {
                        selectedItem = DatabaseService().getSuppliers(
                          false,
                          editedItem[Purchase().supplierID],
                          null,
                          null,
                          null,
                        )[0];
                      } else {
                        selectedItem = null;
                      }
                      routeStack.add('/list_purchases');
                      Navigator.pushReplacementNamed(context, '/edit_purchase');
                    },
                    height: 50,
                    width: 100,
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
