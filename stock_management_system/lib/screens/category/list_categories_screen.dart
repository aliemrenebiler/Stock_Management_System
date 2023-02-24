import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

TextEditingController nameController = TextEditingController();

clearAll() {
  currentPage = 1;
  nameController.clear();
}

getAll() {
  int itemCount = DatabaseService().getCategories(
    true,
    null,
    nameController.text,
    null,
    null,
  );
  totalPage = (itemCount / listedItemCount).ceil();
  listedItems = DatabaseService().getCategories(
    false,
    null,
    nameController.text,
    listedItemCount,
    (currentPage - 1) * listedItemCount,
  );
}

class ListCategoriesScreen extends StatefulWidget {
  final bool isSelectionModeActive;
  const ListCategoriesScreen({
    super.key,
    required this.isSelectionModeActive,
  });

  @override
  State<ListCategoriesScreen> createState() => _ListCategoriesScreenState();
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen> {
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
            title:
                (widget.isSelectionModeActive) ? "Kategori Seç" : 'Kategoriler',
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
                    child: CategoriesListSearchBar(
                      notifyParent: refresh,
                      isSelectionModeActive: widget.isSelectionModeActive,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ItemTable(
                        titlesBar: CategoriesListTitlesBar(
                          isSelectionModeActive: widget.isSelectionModeActive,
                        ),
                        items: [
                          for (int i = 0; i < listedItems.length; i++)
                            CategoriesListItem(
                              category: listedItems[i],
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

class CategoriesListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  final bool isSelectionModeActive;
  const CategoriesListSearchBar({
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
                    routeStack.add("/select_category");
                  } else {
                    routeStack.add("/list_categories");
                  }
                  Navigator.pushReplacementNamed(context, '/add_category');
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

class CategoriesListTitlesBar extends StatelessWidget {
  final bool isSelectionModeActive;
  const CategoriesListTitlesBar({
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

class CategoriesListItem extends StatelessWidget {
  final Map<dynamic, dynamic> category;
  final bool isSelectionModeActive;
  const CategoriesListItem({
    super.key,
    required this.category,
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
                    (category[Category().id] != null)
                        ? category[Category().id].toString()
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
                    (category[Category().name] != null)
                        ? category[Category().name].toString()
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
                (isSelectionModeActive)
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomButton(
                          text: "Seç",
                          bgColor: YMColors().blue,
                          textColor: YMColors().white,
                          onPressed: () {
                            selectedItem = category;
                            Navigator.pushReplacementNamed(
                                context, routeStack.removeLast());
                          },
                          height: 50,
                          width: 80,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomButton(
                          text: "Düzenle",
                          bgColor: YMColors().grey,
                          textColor: YMColors().white,
                          onPressed: () {
                            editedItem = category;
                            routeStack.add("/list_categories");
                            Navigator.pushReplacementNamed(
                                context, '/edit_category');
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
