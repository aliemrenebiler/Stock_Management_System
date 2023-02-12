import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/item_table.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';
import '../../widgets/custom_pop_up.dart';

TextEditingController nameController = TextEditingController();
TextEditingController specController = TextEditingController();
TextEditingController minAmountController = TextEditingController();
TextEditingController maxAmountController = TextEditingController();
TextEditingController minPriceController = TextEditingController();
TextEditingController maxPriceController = TextEditingController();

clearAll() {
  currentPage = 1;
  nameController.clear();
  specController.clear();
  minAmountController.clear();
  maxAmountController.clear();
  minPriceController.clear();
  maxPriceController.clear();
}

getAll(bool listVisibleItems) {
  int itemCount = DatabaseService().getProducts(
    true,
    null,
    (nameController.text.isEmpty) ? null : nameController.text,
    (specController.text.isEmpty) ? null : specController.text,
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
    listVisibleItems,
    null,
    null,
  );
  totalPage = (itemCount / listedItemCount).ceil();
  listedItems = DatabaseService().getProducts(
    false,
    null,
    (nameController.text.isEmpty) ? null : nameController.text,
    (specController.text.isEmpty) ? null : specController.text,
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
    listVisibleItems,
    listedItemCount,
    (currentPage - 1) * listedItemCount,
  );
}

class ListProductsScreen extends StatefulWidget {
  final bool listVisibleItems;
  const ListProductsScreen({super.key, required this.listVisibleItems});

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    clearAll();
    getAll(widget.listVisibleItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: (widget.listVisibleItems) ? "Ürünler" : "Silinen Ürünler",
            leftButtonText: (widget.listVisibleItems) ? "Ana Sayfa" : "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, routeStack.removeLast());
            },
            rightButtonText:
                (widget.listVisibleItems) ? "Silinen Ürünler" : null,
            rightButtonAction: () {
              if (widget.listVisibleItems) {
                routeStack.add('/list_products');
                Navigator.pushReplacementNamed(
                    context, '/list_deleted_products');
              }
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
                      listVisibleItems: widget.listVisibleItems,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ItemTable(
                        titlesBar: ProductsListTitlesBar(
                          listVisibleItems: widget.listVisibleItems,
                        ),
                        items: [
                          for (int i = 0; i < listedItems.length; i++)
                            ProductsListItem(
                              product: listedItems[i],
                              notifyParent: refresh,
                              listVisibleItems: widget.listVisibleItems,
                            ),
                        ],
                        currentPage: currentPage,
                        totalPage: totalPage,
                        onPressedPrev: () {
                          if (currentPage > 1) {
                            currentPage--;
                            getAll(widget.listVisibleItems);
                            refresh();
                          }
                        },
                        onPressedNext: () {
                          if (currentPage < totalPage) {
                            currentPage++;
                            getAll(widget.listVisibleItems);
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

class ProductsListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  final bool listVisibleItems;
  const ProductsListSearchBar({
    super.key,
    required this.notifyParent,
    required this.listVisibleItems,
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
            (listVisibleItems)
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomButton(
                          text: "Ürün Ekle",
                          onPressed: () {
                            editedItem = Map.from(emptyProduct);
                            selectedItem = null;
                            routeStack.add('/list_products');
                            Navigator.pushReplacementNamed(
                                context, '/add_product');
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
                    ],
                  )
                : Container(),
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
                        currentPage = 1;
                        getAll(listVisibleItems);
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
                        getAll(listVisibleItems);
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
  final bool listVisibleItems;
  const ProductsListTitlesBar({super.key, required this.listVisibleItems});

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
              Container(
                height: 70,
                width: (listVisibleItems) ? 300 : 230,
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
  final Function() notifyParent;
  final bool listVisibleItems;
  const ProductsListItem({
    super.key,
    required this.product,
    required this.notifyParent,
    required this.listVisibleItems,
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
                    (product[Product().size] == null)
                        ? "-"
                        : (product[Product().sizeType] == null)
                            ? product[Product().size]
                            : "${product[Product().size]} (${product[Product().sizeType]})",
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
                  child: (listVisibleItems)
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CustomButton(
                                text: "Düzenle",
                                bgColor: YMColors().grey,
                                textColor: YMColors().white,
                                onPressed: () {
                                  editedItem = Map.from(product);
                                  selectedItem =
                                      DatabaseService().getCategories(
                                    false,
                                    editedItem[Product().categoryID],
                                    null,
                                    null,
                                    null,
                                  )[0];
                                  routeStack.add('/list_products');
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
                                  stableItem = product;
                                  editedItem = Map.from(emptyPurchase);
                                  DateTime today = DateTime.now();
                                  editedItem[Purchase().date] =
                                      "${today.year}-${today.month}-${today.day}";
                                  selectedItem = null;
                                  routeStack.add('/list_products');
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
                                  stableItem = product;
                                  selectedItem = null;
                                  routeStack.add('/list_products');
                                  Navigator.pushReplacementNamed(
                                      context, '/sell_product');
                                },
                                height: 50,
                                width: 80,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CustomButton(
                                text: "Sil",
                                bgColor: YMColors().red,
                                textColor: YMColors().white,
                                onPressed: () {
                                  showCustomPopUp(
                                    context,
                                    SizedBox(
                                      width: YMSizes().maxWidth,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5),
                                            height: 50,
                                            child: Text(
                                              "Bu ürün ve ona ait olan tüm alımlar/satışlar kalıcı olarak silinecek.",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: YMColors().black,
                                                fontSize:
                                                    YMSizes().fontSizeSmall,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomButton(
                                                    text: "İptal Et",
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    bgColor: YMColors().grey,
                                                    textColor: YMColors().white,
                                                    width: double.infinity,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomButton(
                                                    text: "Sil",
                                                    onPressed: () {
                                                      DatabaseService()
                                                          .deleteProduct(
                                                        product[Product().id],
                                                      );
                                                      currentPage = 1;
                                                      getAll(listVisibleItems);
                                                      Navigator.pop(context);
                                                      notifyParent();
                                                    },
                                                    bgColor: YMColors().red,
                                                    textColor: YMColors().white,
                                                    width: double.infinity,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                height: 50,
                                width: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CustomButton(
                                text: "Geri Getir",
                                bgColor: YMColors().blue,
                                textColor: YMColors().white,
                                onPressed: () {
                                  showCustomPopUp(
                                    context,
                                    SizedBox(
                                      width: YMSizes().maxWidth,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5),
                                            height: 50,
                                            child: Text(
                                              "Bu ürün geri getirilecek.",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: YMColors().black,
                                                fontSize:
                                                    YMSizes().fontSizeSmall,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomButton(
                                                    text: "İptal Et",
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    bgColor: YMColors().grey,
                                                    textColor: YMColors().white,
                                                    width: double.infinity,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CustomButton(
                                                    text: "Geri Getir",
                                                    onPressed: () {
                                                      DatabaseService()
                                                          .changeProductVisibility(
                                                        product[Product().id],
                                                        true,
                                                      );
                                                      currentPage = 1;
                                                      getAll(listVisibleItems);
                                                      Navigator.pop(context);
                                                      notifyParent();
                                                    },
                                                    bgColor: YMColors().blue,
                                                    textColor: YMColors().white,
                                                    width: double.infinity,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                height: 50,
                                width: 120,
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
