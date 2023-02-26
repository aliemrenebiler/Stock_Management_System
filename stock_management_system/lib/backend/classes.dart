class Category {
  Category._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "categories",
    "en": "Categories",
    "tr": "Kategoriler",
  };
  static const Map<dynamic, dynamic> id = {
    "database": "id",
    "en": "ID",
    "tr": "ID",
  };
  static const Map<dynamic, dynamic> name = {
    "database": "name",
    "en": "Name",
    "tr": "İsim",
  };
}

class Product {
  Product._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "products",
    "en": "Products",
    "tr": "Ürünler",
  };
  static const Map<dynamic, dynamic> id = {
    "database": "id",
    "en": "ID",
    "tr": "ID",
  };
  static const Map<dynamic, dynamic> name = {
    "database": "name",
    "en": "Name",
    "tr": "İsim",
  };
  static const Map<dynamic, dynamic> categoryID = {
    "database": "categoryID",
    "en": "Category ID",
    "tr": "Kategori ID",
  };
  static const Map<dynamic, dynamic> categoryName = {
    "database": "categoryName",
    "en": "Category",
    "tr": "Kategori",
  };
  static const Map<dynamic, dynamic> brand = {
    "database": "brand",
    "en": "Brand",
    "tr": "Marka",
  };
  static const Map<dynamic, dynamic> color = {
    "database": "color",
    "en": "Color",
    "tr": "Renk",
  };
  static const Map<dynamic, dynamic> size = {
    "database": "size",
    "en": "Size",
    "tr": "Boyut",
  };
  static const Map<dynamic, dynamic> sizeUnit = {
    "database": "unit",
    "en": "Unit",
    "tr": "Birim",
  };
  static const Map<dynamic, dynamic> amount = {
    "database": "amount",
    "en": "Amount",
    "tr": "Adet",
  };
  static const Map<dynamic, dynamic> price = {
    "database": "price",
    "en": "Price",
    "tr": "Fiyat",
  };
  static const Map<dynamic, dynamic> visible = {
    "database": "visible",
    "en": "Visible",
    "tr": "Görünür",
  };
}

// TODO: Change other classes too

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
  Product.id["database"]: null,
  Product.name["database"]: null,
  Product.categoryID["database"]: null,
  Product.brand["database"]: null,
  Product.color["database"]: null,
  Product.size["database"]: null,
  Product.sizeUnit["database"]: null,
  Product.amount["database"]: null,
  Product.price["database"]: null,
  Product.visible["database"]: null,
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
