class Category {
  String tableName = "categories";
  String id = "id";
  String name = "name";
}

class Product {
  String tableName = "products";
  String id = "id";
  String name = "name";
  String categoryID = "categoryID";
  String categoryName = "categoryName";
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
  String supplierName = "supplierName";
  String productID = "productID";
  String productName = "productName";
  String amount = "amount";
  String price = "price";
  String date = "date";
  String formattedDate = "formattedDate";
}

class Sale {
  String tableName = "sales";
  String id = "id";
  String productID = "productID";
  String productName = "productName";
  String amount = "amount";
  String price = "price";
  String date = "date";
  String formattedDate = "formattedDate";
}
