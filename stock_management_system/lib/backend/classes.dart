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

class Supplier {
  Supplier._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "suppliers",
    "en": "Suppliers",
    "tr": "Tedarikçiler",
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
  static const Map<dynamic, dynamic> phone = {
    "database": "phone",
    "en": "Phone",
    "tr": "Telefon",
  };
  static const Map<dynamic, dynamic> address = {
    "database": "address",
    "en": "Address",
    "tr": "Adres",
  };
}

class Purchase {
  Purchase._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "purchases",
    "en": "Purchases",
    "tr": "Satın Alımlar",
  };
  static const Map<dynamic, dynamic> id = {
    "database": "id",
    "en": "ID",
    "tr": "ID",
  };
  static const Map<dynamic, dynamic> supplierID = {
    "database": "supplierID",
    "en": "Supplier ID",
    "tr": "Tedarikçi ID",
  };
  static const Map<dynamic, dynamic> supplierName = {
    "database": "supplierName",
    "en": "Supplier Name",
    "tr": "Tedarikçi İsmi",
  };
  static const Map<dynamic, dynamic> productID = {
    "database": "productID",
    "en": "Product ID",
    "tr": "Ürün ID",
  };
  static const Map<dynamic, dynamic> productName = {
    "database": "productName",
    "en": "Product Name",
    "tr": "Ürün İsmi",
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
  static const Map<dynamic, dynamic> date = {
    "database": "date",
    "en": "Date",
    "tr": "Tarih",
  };
  static const Map<dynamic, dynamic> formattedDate = {
    "database": "formattedDate",
    "en": "Date",
    "tr": "Tarih",
  };
}

class Sale {
  Sale._();
  static const Map<dynamic, dynamic> tableName = {
    "database": "sales",
    "en": "Sales",
    "tr": "Satışlar",
  };
  static const Map<dynamic, dynamic> id = {
    "database": "id",
    "en": "ID",
    "tr": "ID",
  };
  static const Map<dynamic, dynamic> productID = {
    "database": "productID",
    "en": "Product ID",
    "tr": "Ürün ID",
  };
  static const Map<dynamic, dynamic> productName = {
    "database": "productName",
    "en": "Product Name",
    "tr": "Ürün İsmi",
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
  static const Map<dynamic, dynamic> date = {
    "database": "date",
    "en": "Date",
    "tr": "Tarih",
  };
  static const Map<dynamic, dynamic> formattedDate = {
    "database": "formattedDate",
    "en": "Date",
    "tr": "Tarih",
  };
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
  Supplier.id["database"]: null,
  Supplier.name["database"]: null,
  Supplier.phone["database"]: null,
  Supplier.address["database"]: null,
};

Map<dynamic, dynamic> emptyPurchase = {
  Purchase.id["database"]: null,
  Purchase.supplierID["database"]: null,
  Purchase.productID["database"]: null,
  Purchase.amount["database"]: null,
  Purchase.price["database"]: null,
  Purchase.date["database"]: null,
};

Map<dynamic, dynamic> emptySale = {
  Sale.id["database"]: null,
  Sale.productID["database"]: null,
  Sale.amount["database"]: null,
  Sale.price["database"]: null,
  Sale.date["database"]: null,
};
