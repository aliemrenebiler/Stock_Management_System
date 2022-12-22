import 'package:flutter/material.dart';
import '../backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/dropdown_button2.dart';
import '../widgets/custom_text_field.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

// late List<dynamic> item();

// List<List<dynamic>> items = await db.query("SELECT isim FROM urunler");

final List<String> editItems = [
  'isim',
  'fiyat',
  'adet',
  'renk',
  'beden',
  'marka',
];

String? listeValue;
String? editValue;
String? barkodValue;
var rs;
int listCount = 0;

class _EditProductScreenState extends State<EditProductScreen> {
  // late TextEditingController _barkodNo;
  late TextEditingController _ad;
  late TextEditingController _kategori;
  late TextEditingController _barcode;
  late TextEditingController _changeVal;
  // late TextEditingController _beden;
  // late TextEditingController _marka;

  @override
  void initState() {
    super.initState();
    // _barkodNo = TextEditingController();
    _ad = TextEditingController();
    _kategori = TextEditingController();
    _barcode = TextEditingController();
    _changeVal = TextEditingController();
    // _beden = TextEditingController();
    // _marka = TextEditingController();
  }

  @override
  void dispose() {
    // _barkodNo.dispose();
    _ad.dispose();
    _kategori.dispose();
    _barcode.dispose();
    _changeVal.dispose();
    // _beden.dispose();
    // _marka.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Ürünün Adını Seçin',
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: urunler
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: listeValue,
                      onChanged: (value) {
                        setState(() {
                          // _barcode.clear();
                          barkodValue = null;
                          editValue = null;
                          // listBarcode = [];
                          listeValue = value as String;
                          barcode(db, listeValue.toString());
                          // UrunListele;
                          // listele;
                        });
                      },
                      buttonHeight: 50,
                      buttonWidth: 300,
                      itemHeight: 40,
                      dropdownMaxHeight: 200,
                      searchController: _ad,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: _ad,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Ürün Arayın',
                            hintStyle: const TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value.toString().contains(searchValue));
                      },
                      //This to clear the search value when you close the menu
                      // onMenuStateChange: (isOpen) {
                      //   if (!isOpen) {
                      //     _ad.clear();
                      //   }
                      // },
                    ),
                  ),
                ),
                UrunListele(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Değiştirmek İstediğiniz Değeri Seçin',
                            style: TextStyle(
                              // fontSize: 15,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: editItems
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: editValue,
                          onChanged: (value) {
                            setState(() {
                              editValue = value as String;
                              // _barcode.clear();
                              // barkodValue = null;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 200,
                          itemHeight: 40,
                          dropdownMaxHeight:
                              MediaQuery.of(context).size.height / 2,
                          searchController: _kategori,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              controller: _kategori,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText:
                                    'Değiştirmek İstediğiniz Değeri Seçin',
                                hintStyle: const TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                          //This to clear the search value when you close the menu
                          // onMenuStateChange: (isOpen) {
                          //   if (!isOpen) {
                          //     _ad.clear();
                          //   }
                          // },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Barkodu Seçin',
                            style: TextStyle(
                              // fontSize: 20,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: listBarcode
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: barkodValue,
                          onChanged: (value) {
                            setState(() {
                              barkodValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 200,
                          itemHeight: 40,
                          dropdownMaxHeight: 200,
                          searchController: _barcode,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              controller: _barcode,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Barkodu Arayın',
                                hintStyle: const TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                          //This to clear the search value when you close the menu
                          // onMenuStateChange: (isOpen) {
                          //   if (!isOpen) {
                          //     _ad.clear();
                          //   }
                          // },
                        ),
                      ),
                    ),
                    // textfields(_fiyat, "Fiyat", 'Ürünün fiyatını giriniz', context),
                    textfields(_changeVal, "ADET",
                        'Ürünün kaç adet olduğunu giriniz', 0.25, context),
                    // textfields(
                    //     _barkodNo, "Barkod", 'Ürünün barkodunu okutunuz', context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: YMColors().lightBlue),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Değiştir',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          onPressed: () async {
                            if (barkodValue != null &&
                                editValue != null &&
                                _changeVal != null) {
                              await db.query(
                                  " UPDATE urunler SET " +
                                      editValue.toString() +
                                      " = \'" +
                                      _changeVal.text +
                                      "\' WHERE barkod = @barkod",
                                  substitutionValues: {
                                    'barkod': barkodValue.toString(),
                                  });
                              item(db);
                            }
                            // int rsint = rs[0][0];
                            // rsint = rsint + int.parse(_changeVal.text);
                            // // print(rsint);
                            // await db.query('''
                            //     UPDATE urunler
                            //     SET adet = @adet
                            //     WHERE isim = @isim;
                            //   ''', substitutionValues: {
                            //   'isim': listeValue.toString(),
                            //   'adet': rsint,
                            // });
                            // print(_barkodNo.value.text +
                            //     "," +
                            //     _ad.value.text +
                            //     "," +
                            //     _fiyat.value.text);
                          }),
                    ),
                  ],
                ),
                // Card(
                //   child: FittedBox(
                //     child: Center(
                //       child: Column(
                //         children: [

                //         ],
                //       ),
                //     ),
                //   ),
                // );
                // ListView.builder(
                //   padding: EdgeInsets.all(8),

                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UrunListele extends StatefulWidget {
  const UrunListele({Key? key}) : super(key: key);

  @override
  State<UrunListele> createState() => _UrunListeleState();
}

class _UrunListeleState extends State<UrunListele> {
  listele() async {
    if (listeValue == "Hepsi") {
      var res = await db.query('''
                                SELECT COUNT(*) FROM urunler
                              ''');
      var res2 = rs = await db.query('''select * from urunler''');
      setState(() {
        listCount = res[0][0];
        rs = res2;
      });
      // print("hepsi");
      // print(listCount);
      // print(rs);
    } else {
      var res = await db.query('''
                                SELECT COUNT(*) FROM urunler WHERE isim = @isim
                              ''', substitutionValues: {
        'isim': listeValue.toString(),
      });
      // print("res");
      // print(res);
      var res2 = await db.query('''select * from urunler where isim = @isim''',
          substitutionValues: {'isim': listeValue.toString()});
      // print("res2");
      // print(res2);
      setState(() {
        listCount = res[0][0];
        rs = res2;
      });
      // print("tek");
      // print(listCount);
      // print(rs);
    }
    // print("selected value");
    // print(selectedValue);
    // print("count");
    // print(listCount);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (listeValue != null) {
      listele();
    }
    return Column(
      children: [
        if (rs != null) ...[
          // Text(rs.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: YMColors().gray,
                child: const Text(
                  "AD",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "ADET",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: YMColors().gray,
                child: const Text(
                  "BARKOD",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "RENK",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: YMColors().gray,
                child: const Text(
                  "BEDEN",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "MARKA",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Container(
                height: height / 10,
                width: width / 10,
                alignment: Alignment.center,
                color: YMColors().gray,
                child: const Text(
                  "FİYAT",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              // Text("Ad : ${rs[index][0]}"),
              // Text("Adet : ${rs[index][2]}"),
              // Text("Barkod : ${rs[index][3]}"),
              // Text("Renk : ${rs[index][4]}"),
              // Text("Beden : ${rs[index][5]}"),
              // Text("Marka : ${rs[index][6]}"),
              // Text("Fiyat : ${rs[index][1]}"),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width - 15,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: listCount,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: YMColors().gray,
                        child: Text(
                          "${rs[index][0]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(
                          "${rs[index][2]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: YMColors().gray,
                        child: Text(
                          "${rs[index][3]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(
                          "${rs[index][4]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: YMColors().gray,
                        child: Text(
                          "${rs[index][5]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(
                          "${rs[index][6]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: height / 10,
                        width: width / 10,
                        alignment: Alignment.center,
                        color: YMColors().gray,
                        child: Text(
                          "${rs[index][1]}",
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      // Text("Ad : ${rs[index][0]}"),
                      // Text("Adet : ${rs[index][2]}"),
                      // Text("Barkod : ${rs[index][3]}"),
                      // Text("Renk : ${rs[index][4]}"),
                      // Text("Beden : ${rs[index][5]}"),
                      // Text("Marka : ${rs[index][6]}"),
                      // Text("Fiyat : ${rs[index][1]}"),
                    ],
                  );
                }),
          )
          // print("UrunListele"),
        ] else ...[
          Text(
            "LİSTELEMEK İSTEDİĞİNİZ ÜRÜNÜ SEÇİN",
            style: TextStyle(
                color: Theme.of(context).errorColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ]
      ],
    );
  }
}
