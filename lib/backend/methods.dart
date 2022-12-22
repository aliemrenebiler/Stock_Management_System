import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? password;

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

bool signIn(input) {
  if (input == password) {
    return true;
  } else {
    return false;
  }
}

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
