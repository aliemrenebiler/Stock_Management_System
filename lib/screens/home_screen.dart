import 'package:flutter/material.dart';
import '../backend/methods.dart';
import '../widgets/dropdown_button2.dart';
import '../widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? selectedValue;

class _HomeScreenState extends State<HomeScreen> {
  // late TextEditingController _barkodNo;
  late TextEditingController _ad;
  late TextEditingController _tl;
  late TextEditingController _adet;

  @override
  void initState() {
    super.initState();
    // _barkodNo = TextEditingController();
    _ad = TextEditingController();
    _tl = TextEditingController();
    _adet = TextEditingController();
  }

  @override
  void dispose() {
    // _barkodNo.dispose();
    _ad.dispose();
    _tl.dispose();
    _adet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      'Ürünün Adını Seçin',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: urunler
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
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 200,
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
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        _ad.clear();
                      }
                    },
                  ),
                ),
                // textfields(_fiyat, "Fiyat", 'Ürünün fiyatını giriniz', context),
                textfields(_adet, "Adet", 'Ürünün kaç adet olduğunu giriniz',
                    0.25, context),
                // textfields(
                //     _barkodNo, "Barkod", 'Ürünün barkodunu okutunuz', context),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary),
                          child: const Text(
                            'Ekle',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // print(_barkodNo.value.text +
                            //     "," +
                            //     _ad.value.text +
                            //     "," +
                            //     _fiyat.value.text);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary),
                          child: const Text(
                            'Çıkar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // print(_barkodNo.value.text +
                            //     "," +
                            //     _ad.value.text +
                            //     "," +
                            //     _fiyat.value.text);
                          }),
                    ),
                  ],
                ),
                // TextField(
                //   controller: _barkodNo,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Ürünün barkodunu okutunuz',
                //   ),
                //   onSubmitted: (String value) async {
                //     await showDialog<void>(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text('Thanks!'),
                //           content: Text(
                //               'You typed "$value", which has length ${value.characters.length}.'),
                //           actions: <Widget>[
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('OK'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
                // TextField(
                //   controller: _ad,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Ürünün adını yazınız',
                //   ),
                //   onSubmitted: (String value) async {
                //     await showDialog<void>(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text('Thanks!'),
                //           content: Text(
                //               'You typed "$value", which has length ${value.characters.length}.'),
                //           actions: <Widget>[
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('OK'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
                // TextField(
                //   controller: _fiyat,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Ürünün fiyatını giriniz',
                //   ),
                //   onSubmitted: (String value) async {
                //     await showDialog<void>(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text('Thanks!'),
                //           content: Text(
                //               'You typed "$value", which has length ${value.characters.length}.'),
                //           actions: <Widget>[
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: const Text('OK'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Yeni Ürün Oluştur",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                textfields(_ad, "Ad", 'Ürünün adını giriniz', 0.25, context),
                textfields(_tl, "TL", 'Ürünün TL cinsinden fiyatını giriniz',
                    0.25, context),
                textfields(_adet, "Adet", 'Ürünün kaç adet olduğunu giriniz',
                    0.25, context),
                // textfields(_barkodNo, "Barkod", 'Ürünün barkodunu okutunuz',
                //     context),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary),
                    child: const Text(
                      'Ürün Oluştur',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await db.query('''
                              INSERT INTO urunler
                              VALUES (@isim,@tl,@adet)
                            ''', substitutionValues: {
                        'isim': _ad.text,
                        'tl': _tl.text,
                        'adet': _adet.text,
                        // 'barkod': _barkodNo.text,
                      });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
