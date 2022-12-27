class Product {
  String tableName = "stok";
  String id = "urunKodu";
  String name = "urunAd";
  String category = "marka";
  String brand = "kategori";
  String color = "renk";
  String size = "boyut";
  String sizeType = "boyutTur";
  String amount = "adet";
  String price = "adetSatisFiyat";
}

class Supplier {
  String tableName = "tedarikci";
  String id = "firmaKodu";
  String name = "firmaAd";
  String phone = "telefonNo";
  String address = "adres";
}

class Purchase {
  String tableName = "satinAlimKayit";
  String id = "alimKodu";
  String supplierID = "tedarikciKodu";
  String productID = "alinanUrunKodu";
  String amount = "urunAdet";
  String price = "alimFiyat";
  String date = "alimTarih";
}

class Sale {
  String tableName = "satisKayit";
  String id = "satisKodu";
  String productID = "satilanUrunKodu";
  String amount = "urunAdet";
  String price = "satisFiyat";
  String date = "satisTarih";
}
