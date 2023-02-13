import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../backend/theme.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

TextEditingController infoController = TextEditingController();

clearAll() {
  currentPage = 1;
  infoController.clear();
}

getAll() {
  int itemCount = DatabaseService().getSuppliers(
    true,
    null,
    (infoController.text.isEmpty) ? null : infoController.text,
    null,
    null,
  );
  totalPage = (itemCount / listedItemCount).ceil();
  listedItems = DatabaseService().getSuppliers(
    false,
    null,
    (infoController.text.isEmpty) ? null : infoController.text,
    listedItemCount,
    (currentPage - 1) * listedItemCount,
  );
}

class ListSuppliersScreen extends StatefulWidget {
  final bool isSelectionModeActive;
  const ListSuppliersScreen({
    super.key,
    required this.isSelectionModeActive,
  });

  @override
  State<ListSuppliersScreen> createState() => _ListSuppliersScreenState();
}

class _ListSuppliersScreenState extends State<ListSuppliersScreen> {
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
            title: (widget.isSelectionModeActive)
                ? "Tedarikçi Seç"
                : "Tedarikçiler",
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, routeStack.removeLast());
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SuppliersListSearchBar(
                      notifyParent: refresh,
                      isSelectionModeActive: widget.isSelectionModeActive,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ItemTable(
                        titlesBar: SuppliersListTitlesBar(
                          isSelectionModeActive: widget.isSelectionModeActive,
                        ),
                        items: [
                          for (int i = 0; i < listedItems.length; i++)
                            SuppliersListItem(
                              supplier: listedItems[i],
                              isSelectionModeActive:
                                  widget.isSelectionModeActive,
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

class SuppliersListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  final bool isSelectionModeActive;
  const SuppliersListSearchBar({
    super.key,
    required this.notifyParent,
    required this.isSelectionModeActive,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: "Yeni Ekle",
                onPressed: () {
                  if (isSelectionModeActive) {
                    routeStack.add("/select_supplier");
                  } else {
                    routeStack.add("/list_suppliers");
                  }
                  Navigator.pushReplacementNamed(context, '/add_supplier');
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
                          hintText: "İsim, Telefon veya Adres",
                          height: 50,
                          controller: infoController,
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
                        currentPage = 1;
                        getAll();
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

class SuppliersListTitlesBar extends StatelessWidget {
  final bool isSelectionModeActive;
  const SuppliersListTitlesBar({
    super.key,
    required this.isSelectionModeActive,
  });

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
                flex: 1,
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
                flex: 1,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Telefon",
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
                    "Adres",
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
                width: (isSelectionModeActive) ? 100 : 120,
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

class SuppliersListItem extends StatelessWidget {
  final Map<dynamic, dynamic> supplier;
  final bool isSelectionModeActive;
  const SuppliersListItem({
    super.key,
    required this.supplier,
    required this.isSelectionModeActive,
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
                    (supplier[Supplier().id] != null)
                        ? supplier[Supplier().id].toString()
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
                  flex: 1,
                  child: Text(
                    (supplier[Supplier().name] != null)
                        ? supplier[Supplier().name].toString()
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
                  flex: 1,
                  child: Text(
                    (supplier[Supplier().phone] != null)
                        ? supplier[Supplier().phone].toString()
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
                    (supplier[Supplier().address] != null)
                        ? supplier[Supplier().address].toString()
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
                  child: (isSelectionModeActive)
                      ? CustomButton(
                          text: "Seç",
                          bgColor: YMColors().blue,
                          textColor: YMColors().white,
                          onPressed: () {
                            selectedItem = supplier;
                            Navigator.pushReplacementNamed(
                                context, routeStack.removeLast());
                          },
                          height: 50,
                          width: 80,
                        )
                      : CustomButton(
                          text: "Düzenle",
                          bgColor: YMColors().grey,
                          textColor: YMColors().white,
                          onPressed: () {
                            editedItem = supplier;
                            routeStack.add('/list_suppliers');
                            Navigator.pushReplacementNamed(
                                context, '/edit_supplier');
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
