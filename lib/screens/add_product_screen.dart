import 'package:flutter/material.dart';

import '../backend/methods.dart';
import '../backend/theme.dart';
import '../widgets/dropdown_button2.dart';
import '../widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

// late List<dynamic> item();

// List<List<dynamic>> items = await db.query("SELECT isim FROM urunler");

// final List<String> items = [
//   'Item1',
//   'Item2',
//   'Item3',
//   'Item4',
// ];
String? newProductVal;

class _AddProductScreenState extends State<AddProductScreen> {
  // late TextEditingController _barkodNo;
  late TextEditingController _ad;
  late TextEditingController _tl;
  late TextEditingController _adet;
  late TextEditingController _renk;
  late TextEditingController _beden;
  late TextEditingController _marka;
  late TextEditingController _newProdkategori;

  @override
  void initState() {
    super.initState();
    // _barkodNo = TextEditingController();
    _ad = TextEditingController();
    _tl = TextEditingController();
    _adet = TextEditingController();
    _renk = TextEditingController();
    _beden = TextEditingController();
    _marka = TextEditingController();
    _newProdkategori = TextEditingController();
  }

  @override
  void dispose() {
    // _barkodNo.dispose();
    _ad.dispose();
    _tl.dispose();
    _adet.dispose();
    _renk.dispose();
    _beden.dispose();
    _marka.dispose();
    _newProdkategori.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Yeni Ürün Oluştur",
                  style: TextStyle(
                    fontSize: 26,
                    color: YMColors().lightBlue,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      'Kategori Seçin',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: listKategori
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
                    value: newProductVal,
                    onChanged: (value) {
                      setState(() {
                        newProductVal = value as String;
                        // _kategori.text = value as String;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 200,
                    itemHeight: 40,
                    dropdownMaxHeight: 200,
                    searchController: _newProdkategori,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: _newProdkategori,
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
                    //   }
                    // },
                  ),
                ),
                textfields(_ad, "AD", 'Ürünün adını giriniz', 0.25, context),
                textfields(_tl, "TL", 'Ürünün TL cinsinden fiyatını giriniz',
                    0.25, context),
                textfields(_adet, "ADET", 'Ürünün kaç adet olduğunu giriniz',
                    0.25, context),
                // textfields(
                //     _barkodNo, "BARKOD", 'Ürünün barkodunu okutunuz', context),
                textfields(
                    _renk, "RENK", 'Ürünün rengini giriniz', 0.25, context),
                textfields(
                    _beden, "BEDEN", 'Ürünün bedenini giriniz', 0.25, context),
                textfields(
                    _marka, "MARKA", 'Ürünün markasını giriniz', 0.25, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_ad.text.isNotEmpty &&
                            _tl.text.isNotEmpty &&
                            _adet.text.isNotEmpty &&
                            newProductVal != null) {
                          if (_renk.text.isEmpty) {
                            _renk.text = "-";
                          }
                          if (_beden.text.isEmpty) {
                            _beden.text = "-";
                          }
                          if (_marka.text.isEmpty) {
                            _marka.text = "-";
                          }
                          // if (_barkodNo.text.isEmpty) {
                          //   _renk.text = "-";
                          // }
                          // print(_ad.text);
                          // print(_tl.text);
                          // print(_adet.text);
                          // print(_barkodNo);
                          // print(_renk.text);
                          // print(_beden.text);
                          // print(_marka.text);
                          // print(selectedValue);

                          await db.query('''
                              INSERT INTO urunler (isim ,fiyat , adet, renk, beden, marka, kategori)
                              VALUES (@isim,@tl,@adet,@renk,@beden,@marka,@kategori)
                              ''', substitutionValues: {
                            'isim': _ad.text,
                            'tl': _tl.text,
                            'adet': _adet.text,
                            // 'barkod': _barkodNo.text,
                            'renk': _renk.text,
                            'beden': _beden.text,
                            'marka': _marka.text,
                            'kategori': newProductVal
                          });
                          // print(selectedValue.toString());
                          item(db);
                          // _barkodNo.clear();
                          _ad.clear();
                          _tl.clear();
                          _adet.clear();
                          _renk.clear();
                          _beden.clear();
                          _marka.clear();
                          // print(_kategori.text);
                          // _newProdkategori.clear();
                          // print(newProductVal);
                          // newProductVal = null;
                        } else {
                          print("else");
                          // print(_ad.text.isNotEmpty);
                          // print(_tl.text.isNotEmpty);
                          // print(_adet.text.isNotEmpty);
                          // print(selectedValue.toString());
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: YMColors().lightBlue,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              color: const Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Ürün Oluştur",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Nunito",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Ad, TL, Adet ve Kategori kısımları Boş Olamaz",
                    style: TextStyle(
                        color: YMColors().red,
                        fontFamily: "Nunito",
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
