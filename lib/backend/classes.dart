class Product {
  String id;
  String name;
  String category;
  String? brand;
  String? color;
  String? size;
  String? sizeType;
  String amount;
  double price;
  Product({
    required this.id,
    required this.name,
    this.brand,
    required this.category,
    this.color,
    this.size,
    this.sizeType,
    required this.amount,
    required this.price,
  });
}

class Supplier {
  String id;
  String name;
  String? phone;
  String? address;
  Supplier({
    required this.id,
    required this.name,
    this.phone,
    this.address,
  });
}

class Purchase {
  String id;
  String? supplierID;
  String productID;
  int amount;
  double price;
  String date;
  Purchase({
    required this.id,
    this.supplierID,
    required this.productID,
    required this.amount,
    required this.price,
    required this.date,
  });
}

class Sale {
  String id;
  String productID;
  int amount;
  double price;
  String date;
  Sale({
    required this.id,
    required this.productID,
    required this.amount,
    required this.price,
    required this.date,
  });
}
