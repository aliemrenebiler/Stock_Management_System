class Product {
  String tableName = "product";
  String id = "id";
  String name = "name";
  String category = "category";
  String brand = "brand";
  String color = "color";
  String size = "size";
  String sizeType = "sizeType";
  String amount = "amount";
  String price = "price";
}

class Supplier {
  String tableName = "supplier";
  String id = "id";
  String name = "name";
  String phone = "phone";
  String address = "address";
}

class Purchase {
  String tableName = "purchase";
  String id = "id";
  String supplierID = "supplierID";
  String productID = "productID";
  String amount = "amount";
  String price = "price";
  String date = "date";
}

class Sale {
  String tableName = "sale";
  String id = "id";
  String productID = "productID";
  String amount = "amount";
  String price = "price";
  String date = "date";
}
