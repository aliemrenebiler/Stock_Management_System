import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_text_field.dart';
import '../../backend/theme.dart';
import '../../widgets/list_table.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

List<Map<dynamic, dynamic>> listedSuppliers = [];

class ListSuppliersScreen extends StatefulWidget {
  const ListSuppliersScreen({Key? key}) : super(key: key);

  @override
  State<ListSuppliersScreen> createState() => _ListSuppliersScreenState();
}

class _ListSuppliersScreenState extends State<ListSuppliersScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    listedSuppliers = DatabaseService().getSuppliers(null, null);
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
                  "Tedarikçiler",
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
                    child: SuppliersListSearchBar(
                      notifyParent: refresh,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListTable(
                        titlesBar: const SuppliersListTitlesBar(),
                        items: [
                          for (int i = 0; i < listedSuppliers.length; i++)
                            SuppliersListItem(
                              supplier: listedSuppliers[i],
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

class SuppliersListSearchBar extends StatelessWidget {
  final Function() notifyParent;
  const SuppliersListSearchBar({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    TextEditingController infoController = TextEditingController();
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
                    listedSuppliers =
                        DatabaseService().getSuppliers(null, null);
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
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFieldComponent(
                  hintText: "İsim, Telefon Numarası veya Adres",
                  height: 50,
                  controller: infoController,
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
                    listedSuppliers = DatabaseService().getSuppliers(
                      null,
                      (infoController.text.isEmpty)
                          ? null
                          : infoController.text,
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

class SuppliersListTitlesBar extends StatelessWidget {
  const SuppliersListTitlesBar({super.key});

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
              const ListTableTitlesBarItem(text: "İsim", flex: 3),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Telefon Numarası", flex: 3),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "Adres", flex: 5),
              ListTableVerticalSeperator(
                color: YMColors().grey,
                space: 10,
              ),
              const ListTableTitlesBarItem(text: "İşlemler", flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class SuppliersListItem extends StatelessWidget {
  final Map<dynamic, dynamic> supplier;
  const SuppliersListItem({
    super.key,
    required this.supplier,
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
                  value: (supplier[Supplier().id] != null)
                      ? supplier[Supplier().id].toString()
                      : null,
                  flex: 1,
                  textColor: YMColors().grey,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (supplier[Supplier().name] != null)
                      ? supplier[Supplier().name].toString()
                      : null,
                  flex: 3,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (supplier[Supplier().phone] != null)
                      ? supplier[Supplier().phone].toString()
                      : null,
                  flex: 3,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                ListTableItemPart(
                  value: (supplier[Supplier().address] != null)
                      ? supplier[Supplier().address].toString()
                      : null,
                  flex: 5,
                ),
                ListTableVerticalSeperator(
                  color: YMColors().lightGrey,
                  space: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: MenuButton(
                      text: "Düzenle",
                      bgColor: YMColors().grey,
                      textColor: YMColors().white,
                      onPressed: () {
                        editedItem = supplier;
                        Navigator.pushReplacementNamed(
                            context, '/edit_supplier');
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
