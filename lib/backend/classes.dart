class Product {
  String tableName = "products";
  String id = "id";
  String name = "name";
  String category = "category";
  String brand = "brand";
  String color = "color";
  String size = "size";
  String sizeType = "sizeType";
  String amount = "amount";
  String price = "price";
  String visible = "visible";
}

class Supplier {
  String tableName = "suppliers";
  String id = "id";
  String name = "name";
  String phone = "phone";
  String address = "address";
}

class Purchase {
  String tableName = "purchases";
  String id = "id";
  String supplierID = "supplierID";
  String productID = "productID";
  String amount = "amount";
  String price = "price";
  String date = "date";
  String formattedDate = "formattedDate";
}

class Sale {
  String tableName = "sales";
  String id = "id";
  String productID = "productID";
  String amount = "amount";
  String price = "price";
  String date = "date";
}
