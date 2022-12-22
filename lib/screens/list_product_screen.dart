import 'package:flutter/material.dart';
import '../backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/dropdown_button2.dart';
import '../widgets/custom_text_field.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

// late List<dynamic> item();

// List<List<dynamic>> items = await db.query("SELECT isim FROM urunler");

// final List<String> items = [
//   'Item1',
//   'Item2',
//   'Item3',
//   'Item4',
// ];
String? urunValue;
String? kategoriValue;
var rs;
int listCount = 0;

class _ListProductScreenState extends State<ListProductScreen> {
  late TextEditingController _barkodNo;
  late TextEditingController _ad;
  late TextEditingController _tl;
  late TextEditingController _adet;
  late TextEditingController _renk;
  late TextEditingController _beden;
  late TextEditingController _marka;

  @override
  void initState() {
    super.initState();
    _barkodNo = TextEditingController();
    _ad = TextEditingController();
    _tl = TextEditingController();
    _adet = TextEditingController();
    _renk = TextEditingController();
    _beden = TextEditingController();
    _marka = TextEditingController();
  }

  @override
  void dispose() {
    _barkodNo.dispose();
    _ad.dispose();
    _tl.dispose();
    _adet.dispose();
    _renk.dispose();
    _beden.dispose();
    _marka.dispose();
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Kategori Seçin',
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: listKategori
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: kategoriValue,
                      onChanged: (value) {
                        setState(() {
                          kategoriValue = value as String;
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
                            hintText: 'Kategori Arayın',
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
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          // _ad.clear();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                      items: listUrunler
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: urunValue,
                      onChanged: (value) {
                        setState(() {
                          urunValue = value as String;
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
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () async {
                                    // var res = await db.query('''SELECT COUNT(*) FROM urunler WHERE isim LIKE '%@isim%' ''',
                                    // substitutionValues: {'isim': _ad.text});
                                    // res3 = await db.query('''select * from urunler where isim = @isim''',
                                    // substitutionValues: {'isim': i[0].toString()});
                                  })),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value.toString().contains(searchValue));
                      },
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          // _ad.clear();
                        }
                      },
                    ),
                  ),
                ),
                const UrunListele(),
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
    if (urunValue == "Hepsi") {
      var res = await db.query('''
                                SELECT COUNT(*) FROM urunler
                              ''');
      // var res2 = rs = await db.query('''select * from urunler''');
      var forcount = await db.query('''SELECT DISTINCT isim FROM urunler''');
      // print(forcount);
      // List<List> res2 = await db.query('''select * from urunler where isim = @isim''',
      //     substitutionValues: {'isim': forcount[0][0].toString()});
      var res3;
      var res2 = [[]];
      print(res2);
      int forc = 0;
      for (var i in forcount) {
        res3 = await db.query('''select * from urunler where isim = @isim''',
            substitutionValues: {'isim': i[0].toString()});
        print(res3);
        res2.addAll(res3);
        print(res2);
      }
      res2.removeAt(0);
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
        'isim': urunValue.toString(),
      });
      // print("res");
      // print(res);
      var res2 = await db.query('''select * from urunler where isim = @isim''',
          substitutionValues: {'isim': urunValue.toString()});
      // print("res2");
      // print(res2);
      setState(() {
        listCount = res[0][0];
        rs = res2;
        // print(rs);
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

  final TextEditingController _miktar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (urunValue != null) {
      listele();
      // urunValue = null;
      // kategoriValue = null;
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
              Container(
                height: height / 10,
                width: width / 6,
                alignment: Alignment.center,
                // color: gri,
                // child: const Text(
                //   "FİYAT",
                //   style: TextStyle(color: Colors.black),
                //   textAlign: TextAlign.center,
                //   textDirection: TextDirection.ltr,
                // ),
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
            height: MediaQuery.of(context).size.height / 1.5,
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
                      Container(
                          height: height / 10,
                          width: width / 6,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                // <-- ElevatedButton
                                onPressed: () async {
                                  var _rs = await db.query('''
                                      SELECT adet FROM urunler WHERE barkod = @barkod
                                    ''', substitutionValues: {
                                    'barkod': rs[index][3],
                                  });
                                  int rsint = _rs[0][0];
                                  rsint = rsint + (int.parse(_miktar.text));
                                  // print(rsint);
                                  await db.query('''
                                      UPDATE urunler
                                      SET adet = @adet
                                      WHERE barkod = @barkod;
                                    ''', substitutionValues: {
                                    'barkod': rs[index][3],
                                    'adet': rsint,
                                  });
                                  _miktar.clear();
                                },
                                // label: Text('Ekle'),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20)),
                                  shape: MaterialStateProperty.all(
                                    const CircleBorder(),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: textfields(
                                    _miktar, "Adet", "Adet", 0.05, context),
                              ),
                              ElevatedButton(
                                // <-- ElevatedButton
                                onPressed: () async {
                                  var _rs = await db.query('''
                                      SELECT adet FROM urunler WHERE barkod = @barkod
                                    ''', substitutionValues: {
                                    'barkod': rs[index][3],
                                  });
                                  int rsint = _rs[0][0];
                                  rsint = rsint - (int.parse(_miktar.text));
                                  // print(rsint);
                                  await db.query('''
                                      UPDATE urunler
                                      SET adet = @adet
                                      WHERE barkod = @barkod;
                                    ''', substitutionValues: {
                                    'barkod': rs[index][3],
                                    'adet': rsint,
                                  });
                                  _miktar.clear();
                                },
                                // label: Text('Ekle'),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20)),
                                  shape: MaterialStateProperty.all(
                                    const CircleBorder(),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          )),
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
