class Category {
  Category._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "categories",
    "en": "Categories",
    "tr": "Kategoriler"
  };
  static const Map<dynamic, dynamic> id = {
    "database": "id",
    "en": "ID",
    "tr": "ID"
  };
  static const Map<dynamic, dynamic> name = {
    "database": "name",
    "en": "Name",
    "tr": "İsim"
  };
}

// TODO: Change other classes too

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

Map<dynamic, dynamic> emptyCategory = {
  Category.id["database"]: null,
  Category.name["database"]: null,
};

Map<dynamic, dynamic> emptyProduct = {
  Product().id: null,
  Product().name: null,
  Product().categoryID: null,
  Product().brand: null,
  Product().color: null,
  Product().size: null,
  Product().sizeType: null,
  Product().amount: null,
  Product().price: null,
  Product().visible: null,
};

Map<dynamic, dynamic> emptySupplier = {
  Supplier().id: null,
  Supplier().name: null,
  Supplier().phone: null,
  Supplier().address: null,
};

Map<dynamic, dynamic> emptyPurchase = {
  Purchase().id: null,
  Purchase().supplierID: null,
  Purchase().productID: null,
  Purchase().amount: null,
  Purchase().price: null,
  Purchase().date: null,
};

Map<dynamic, dynamic> emptySale = {
  Sale().id: null,
  Sale().productID: null,
  Sale().amount: null,
  Sale().price: null,
  Sale().date: null,
};
