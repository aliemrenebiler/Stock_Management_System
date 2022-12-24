import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/classes.dart';
import 'package:yildiz_motor_v2/widgets/custom_text_field.dart';

import '../backend/theme.dart';
import '../widgets/list_table.dart';
import '../widgets/menu_button.dart';
import '../widgets/top_bar.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  void initState() {
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
                  height: 40,
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
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ProductListSearchBar(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListTable(
                        titlesBar: ProductListTitlesBar(),
                        items: [
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
                          ),
                          ProductListItem(
                            product: {
                              "id": 1,
                              "name": "Kask",
                              "category": "Baş",
                              "brand": "Nike",
                              "color": "Kırmızı",
                              "size": "M",
                              "sizeType": "Beden",
                              "amount": 2,
                              "price": 200,
                            },
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

class ProductListSearchBar extends StatelessWidget {
  const ProductListSearchBar({super.key});

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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MenuButton(
                  text: "Temizle",
                  onPressed: () {},
                  height: 40,
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
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "İsim veya ID",
                          height: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Özellik",
                          height: 40,
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
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Az)",
                          height: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Fiyat (En Fazla)",
                          height: 40,
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
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Adet (En Az)",
                          height: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFieldComponent(
                          hintText: "Adet (En Fazla)",
                          height: 40,
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
                  onPressed: () {},
                  height: 40,
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

class ProductListTitlesBar extends StatelessWidget {
  const ProductListTitlesBar({super.key});

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

class ProductListItem extends StatelessWidget {
  final Map<dynamic, dynamic> product;
  const ProductListItem({
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
            height: 60,
            decoration: BoxDecoration(
              color: YMColors().white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    product[Product().id].toString(),
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
                    product[Product().name].toString(),
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
                    product[Product().brand].toString(),
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
                    product[Product().category].toString(),
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
                    product[Product().color].toString(),
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
                    product[Product().size].toString(),
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
                    product[Product().sizeType].toString(),
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
                    product[Product().price].toString(),
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
                    product[Product().amount].toString(),
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
                              onPressed: () {},
                              height: 40,
                              width: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: MenuButton(
                              text: "Alış Ekle",
                              bgColor: YMColors().blue,
                              textColor: YMColors().white,
                              onPressed: () {},
                              height: 40,
                              width: 120,
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
                              onPressed: () {},
                              height: 40,
                              width: 120,
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
