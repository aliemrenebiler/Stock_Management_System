import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:postgres/postgres.dart';
import 'package:sqflite/utils/utils.dart';

import 'classes.dart';

String? password;

Database? database;

class SharedPrefsService {
  Future<bool> get passwordExists async {
    final prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password');
    if (password == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password')!;
  }

  setPassword(password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }
}

class SQLiteServices {
  Future<Database> copyAndOpenDB(String dbName) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "database", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    // open the database
    Database db = await openDatabase(path);
    return db;
  }

  Future<int> getDBSize(String dbName) async {
    int size = firstIntValue(
        await database!.rawQuery('SELECT COUNT(*) FROM $dbName'))!;
    return size;
  }

  Future<Product> getProduct(String id) async {
    var newProduct =
        await database!.rawQuery('SELECT * FROM stok WHERE urunKodu = $id');

    return Product(
      id: id,
      name: newProduct[0]["urunAd"] as String,
      brand: (newProduct[0]["marka"] == null)
          ? null
          : newProduct[0]["makra"] as String,
      color: (newProduct[0]["renk"] == null)
          ? null
          : newProduct[0]["renk"] as String,
      size: (newProduct[0]["boyut"] == null)
          ? null
          : newProduct[0]["boyut"] as String,
      sizeType: (newProduct[0]["boyutTur"] == null)
          ? null
          : newProduct[0]["boyutTur"] as String,
      category: newProduct[0]["kategori"] as String,
      amount: newProduct[0]["adet"] as String,
      price: newProduct[0]["adetSatisFiyat"] as double,
    );
  }

  insertProduct(Product product) async {
    int id = await database!.rawInsert(
      'INSERT INTO stok(urunKodu,urunAd,marka,kategori,renk,boyut,boyutTur,adet,adetSatisFiyat) VALUES(?,?,?,?,?,?,?,?,?)',
      [
        product.id,
        product.name,
        product.brand,
        product.category,
        product.color,
        product.size,
        product.sizeType,
        product.amount,
        product.price,
      ],
    );
  }

  updateProduct(Product product) async {
    int id = await database!.rawInsert(
      'UPDATE urunAd=?,marka=?,kategori=?,renk=?,boyut=?,boyutTur=?,adet=?,adetSatisFiyat=? WHERE urunKodu=?',
      [
        product.name,
        product.brand,
        product.category,
        product.color,
        product.size,
        product.sizeType,
        product.amount,
        product.price,
        product.id,
      ],
    );
  }

  Future<Supplier> getSupplier(String id) async {
    var newSupplier = await database!
        .rawQuery('SELECT * FROM tedarikci WHERE firmaKodu = $id');

    return Supplier(
      id: id,
      name: newSupplier[0]["firmaAd"] as String,
      phone: (newSupplier[0]["telefonNo"] == null)
          ? null
          : newSupplier[0]["telefonNo"] as String,
      address: (newSupplier[0]["adres"] == null)
          ? null
          : newSupplier[0]["adres"] as String,
    );
  }

  // TODO: insert, update

  Future<Purchase> getPurchase(String id) async {
    var newPurchase = await database!
        .rawQuery('SELECT * FROM satinAlimKayit WHERE alimKodu = $id');

    return Purchase(
      id: id,
      productID: newPurchase[0]["alinanUrunKodu"] as String,
      supplierID: (newPurchase[0]["tedarikciKodu"] == null)
          ? null
          : newPurchase[0]["tedarikciKodu"] as String,
      amount: newPurchase[0]["urunAdet"] as int,
      price: newPurchase[0]["alimFiyat"] as double,
      date: newPurchase[0]["alimTarih"] as String,
    );
  }

  // TODO: insert, update

  Future<Sale> getSale(String id) async {
    var newSale = await database!
        .rawQuery('SELECT * FROM satisKayit WHERE satisKodu = $id');

    return Sale(
      id: id,
      productID: newSale[0]["satilanUrunKodu"] as String,
      amount: newSale[0]["urunAdet"] as int,
      price: newSale[0]["satisFiyat"] as double,
      date: newSale[0]["satisTarih"] as String,
    );
  }

  // TODO: insert, update

}

bool signIn(input) {
  if (input == password) {
    return true;
  } else {
    return false;
  }
}

// AŞAĞIDAKİLER ESKİ FONKSİYONLAR

var db = PostgreSQLConnection("localhost", 5432, "invman",
    username: "postgres", password: "123456");
List<String> urunler = [];
List<String> listUrunler = [];
List<String> listKategori = ["emre"];
List<String> listKategori2 = [];
List<String> listBarcode = [];
// List<String> listBarcode2 = [];

connect() async {
  try {
    // print("bağlandı");
    await db.open().timeout(const Duration(seconds: 5));
    // return AnaSayfa();
  } catch (e) {
    throw Exception(e);
  }
}

item(PostgreSQLConnection conn) async {
  urunler = [];
  listUrunler = ["Hepsi"];
  try {
    var results = await conn.query("SELECT DISTINCT isim FROM urunler");
    for (final i in results) {
      // print();
      var str = i[0].toString();
      urunler.add(str);
      listUrunler.add(str);
    }
    // for (final i in urunler){
    //   print(i);
    // }
  } catch (e) {
    throw Exception(e);
  }
}

kategori(PostgreSQLConnection conn) async {
  // listKategori = [];
  listKategori2 = [];
  try {
    var results = await conn.query("SELECT isim FROM kategori");
    for (final i in results) {
      // print();
      var str = i[0].toString();
      listKategori2.add(str);
    }
    listKategori = listKategori2;
    // for (final i in urunler){
    //   print(i);
    // }
  } catch (e) {
    throw Exception(e);
  }
}

barcode(PostgreSQLConnection conn, String selectedVal) async {
  // listKategori = [];
  listBarcode = [];
  try {
    var results = await conn.query(
        "SELECT barkod FROM urunler where (isim = \'" + selectedVal + "\');");
    for (final i in results) {
      // print();
      var str = i[0].toString();
      listBarcode.add(str);
    }
    // listBarcode = listBarcode2;
    // for (final i in urunler){
    //   print(i);
    // }
  } catch (e) {
    throw Exception(e);
  }
}
