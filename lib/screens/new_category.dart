import 'package:flutter/material.dart';
import '../backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/custom_text_field.dart';

var rs;

class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

String? selectedValue;

class _NewCategoryState extends State<NewCategory> {
  late TextEditingController _category;

  @override
  void initState() {
    super.initState();
    _category = TextEditingController();
  }

  @override
  void dispose() {
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.10, 0, 0),
              child: Row(
                children: [
                  textfields(
                      _category,
                      "KATEGORİ",
                      'Oluşturmak istediğiniz kategorinin giriniz',
                      0.25,
                      context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: YMColors().lightBlue),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Kategori Oluştur',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onPressed: () async {
                          // print(rsint);
                          if (_category.text.isNotEmpty) {
                            await db.query('''
                              INSERT INTO kategori
                              VALUES (@kategori)
                            ''', substitutionValues: {
                              'kategori': _category.text,
                            });
                          }
                          await kategori(db);
                          _category.clear();
                          // print(_barkodNo.value.text +
                          //     "," +
                          //     _ad.value.text +
                          //     "," +
                          //     _fiyat.value.text);
                        }),
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
