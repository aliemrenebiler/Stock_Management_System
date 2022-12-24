import 'dart:async';
import 'dart:io';
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

class DatabaseService {
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

  createProducts() async {
    await db.execute(
      'CREATE TABLE ${Product().tableName}(${Product().id} TEXT not null,${Product().name} TEXT not null,${Product().brand} TEXT,${Product().category} TEXT,${Product().color} TEXT,${Product().size} TEXT,${Product().sizeType} TEXT,${Product().amount} INTEGER,${Product().price} REAL,primary key (${Product().id}),)',
    );
  }

  Future<List<Map<dynamic, dynamic>>> getProducts(
    String? id,
    String? name,
    String? brand,
    String? category,
    String? color,
    double? size,
    String? sizeType,
  ) async {
    String query = 'SELECT * FROM ${Product().tableName}';
    bool isSearching = false;

    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Product().id}="$id"';
    }
    if (name != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().name}="$name"';
    }
    if (brand != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().brand}="$brand"';
    }
    if (category != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().category}="$category"';
    }
    if (color != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().color}="$color"';
    }
    if (size != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().size}=$size';
    }
    if (sizeType != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().sizeType}="$sizeType"';
    }

    var products = await database!.rawQuery(query);

    return products;
  }

  insertProduct(Map<dynamic, dynamic> product) async {
    await database!.rawInsert(
      'INSERT INTO product(id,name,brand,category,color,size,sizeType,amount,price) VALUES(?,?,?,?,?,?,?,?,?)',
      [
        product["id"] as String,
        product["name"] as String,
        product["brand"] as String,
        product["category"] as String,
        product["color"] as String,
        product["size"] as double,
        product["sizeType"] as String,
        product["amount"] as int,
        product["price"] as double,
      ],
    );
  }

  updateProduct(Map<dynamic, dynamic> product) async {
    await database!.rawUpdate(
      'UPDATE ${Product().tableName} SET ${Product().name}=?,${Product().brand}=?,${Product().category}=?,${Product().color}=?,${Product().size}=?,${Product().sizeType}=?,${Product().amount}=?,${Product().price}=? WHERE ${Product().id}=?',
      [
        product[Product().name] as String,
        product[Product().brand] as String,
        product[Product().category] as String,
        product[Product().color] as String,
        product[Product().size] as double,
        product[Product().sizeType] as String,
        product[Product().amount] as int,
        product[Product().price] as double,
        product[Product().id] as String,
      ],
    );
  }

  deleteProduct(String id) async {
    await database!.rawDelete(
        'DELETE FROM ${Product().tableName} WHERE ${Product().id}=$id');
  }

  createSuppliers() async {
    await db.execute(
      'CREATE TABLE ${Supplier().tableName}(${Supplier().id} TEXT not null, ${Supplier().name} TEXT not null, ${Supplier().phone} TEXT,${Supplier().address} TEXT,primary key (${Supplier().id}),)',
    );
  }

  Future<List<Map<dynamic, dynamic>>> getSuppliers(
    String? id,
    String? name,
    String? phone,
  ) async {
    String query = 'SELECT * FROM ${Supplier().tableName}';
    bool isSearching = false;
    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Supplier().id}="$id"';
    }
    if (name != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Supplier().name}="$name"';
    }
    if (phone != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Supplier().phone}="$phone"';
    }

    var suppliers = await database!.rawQuery(query);

    return suppliers;
  }

  insertSupplier(Map<dynamic, dynamic> supplier) async {
    await database!.rawInsert(
      'INSERT INTO ${Supplier().tableName}(${Supplier().id},${Supplier().name},${Supplier().phone},${Supplier().address}) VALUES(?,?,?,?)',
      [
        supplier[Supplier().id],
        supplier[Supplier().name],
        supplier[Supplier().phone],
        supplier[Supplier().address],
      ],
    );
  }

  updateSupplier(Map<dynamic, dynamic> supplier) async {
    await database!.rawUpdate(
      'UPDATE ${Supplier().tableName} SET ${Supplier().name}=?,${Supplier().phone}=?,${Supplier().address}=? WHERE ${Supplier().id}=?',
      [
        supplier[Supplier().name],
        supplier[Supplier().phone],
        supplier[Supplier().address],
        supplier[Supplier().id],
      ],
    );
  }

  deleteSupplier(String id) async {
    await database!.rawDelete(
        'DELETE FROM ${Supplier().tableName} WHERE ${Supplier().id}=$id');
  }

  createPurchases() async {
    await db.execute(
      'CREATE TABLE ${Purchase().tableName}(${Purchase().id} TEXT not null,${Purchase().supplierID} TEXT,${Purchase().productID} TEXT not null,${Purchase().amount} INTEGER,${Purchase().price} REAL,${Purchase().date} DATE,primary key (${Purchase().id}),foreign key (${Purchase().supplierID}) references ${Supplier().tableName}(${Supplier().id}),foreign key (${Purchase().productID}) references ${Product().tableName}(${Product().id}),)',
    );
  }

  Future<List<Map<dynamic, dynamic>>> getPurchases(
    String? id,
    String? supplierID,
    String? productID,
  ) async {
    String query = 'SELECT * FROM ${Purchase().tableName}';
    bool isSearching = false;

    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Purchase().id}="$id"';
    }
    if (supplierID != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().supplierID}="$supplierID"';
    }
    if (productID != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().productID}="$productID"';
    }

    var purchases = await database!.rawQuery(query);

    return purchases;
  }

  insertPurchase(Map<dynamic, dynamic> purchase) async {
    await database!.rawInsert(
      'INSERT INTO ${Purchase().tableName}(${Purchase().id},${Purchase().supplierID},${Purchase().productID},${Purchase().amount},${Purchase().price},${Purchase().date}) VALUES(?,?,?,?,?,?)',
      [
        purchase[Purchase().id],
        purchase[Purchase().supplierID],
        purchase[Purchase().productID],
        purchase[Purchase().amount],
        purchase[Purchase().price],
        purchase[Purchase().date],
      ],
    );
  }

  updatePurchase(Map<dynamic, dynamic> purchase) async {
    await database!.rawUpdate(
      'UPDATE ${Purchase().tableName} SET ${Purchase().supplierID}=?,${Purchase().productID}=?,${Purchase().amount}=?,${Purchase().price}=?,${Purchase().date}=? WHERE ${Purchase().id}=?',
      [
        purchase[Purchase().supplierID],
        purchase[Purchase().productID],
        purchase[Purchase().amount],
        purchase[Purchase().price],
        purchase[Purchase().date],
        purchase[Purchase().id],
      ],
    );
  }

  deletePurchase(String id) async {
    await database!.rawDelete(
        'DELETE FROM ${Purchase().tableName} WHERE ${Purchase().id}=$id');
  }

  createSales() async {
    await db.execute(
      'CREATE TABLE ${Sale().tableName}(${Purchase().id} TEXT not null,${Sale().productID} TEXT not null,${Sale().amount} INTEGER,${Sale().price} REAL,${Sale().date} DATE,primary key (${Sale().id}),foreign key (${Sale().productID}) references ${Product().tableName}(${Product().id}),)',
    );
  }

  Future<List<Map<dynamic, dynamic>>> getSales(
    String? id,
    String? productID,
  ) async {
    String query = 'SELECT * FROM ${Sale().tableName}';
    bool isSearching = false;

    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Sale().id}="$id"';
    }
    if (productID != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Sale().productID}="$productID"';
    }
    var sales = await database!.rawQuery(query);

    return sales;
  }

  insertSale(Map<dynamic, dynamic> sale) async {
    await database!.rawInsert(
      'INSERT INTO ${Sale().tableName}(${Sale().id},${Sale().productID},${Sale().amount},${Sale().price},${Sale().date}) VALUES(?,?,?,?,?)',
      [
        sale[Sale().id],
        sale[Sale().productID],
        sale[Sale().amount],
        sale[Sale().price],
        sale[Sale().date],
      ],
    );
  }

  updateSale(Map<dynamic, dynamic> sale) async {
    await database!.rawUpdate(
      'UPDATE ${Sale().tableName} SET ${Sale().productID}=?,${Sale().amount}=?,${Sale().price}=?,${Sale().date}=? WHERE ${Sale().id}=?',
      [
        sale[Sale().productID],
        sale[Sale().amount],
        sale[Sale().price],
        sale[Sale().date],
        sale[Sale().id],
      ],
    );
  }

  deleteSale(String id) async {
    await database!
        .rawDelete('DELETE FROM ${Sale().tableName} WHERE ${Sale().id}=$id');
  }
}

bool signIn(input) {
  if (input == password) {
    return true;
  } else {
    return false;
  }
}

//------------------------------------------------------------------------------
// AŞAĞIDAKİLER ESKİ FONKSİYONLAR
//------------------------------------------------------------------------------

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
    var results = await conn
        .query("SELECT barkod FROM urunler where (isim = '$selectedVal');");
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
