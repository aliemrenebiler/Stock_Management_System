import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart';

import 'classes.dart';

String dbName = "yildiz_motor_db.db";

Map<dynamic, dynamic> editedItem = {};

class SharedPrefsService {
  get isPasswordExists async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('password') == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  setPassword(password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }
}

class DatabaseService {
  getDBSize(String dbName) {
    Database database = sqlite3.open(dbName);
    int size = database.select(
      '''
      SELECT COUNT(*) FROM $dbName
      ''',
    )[0][0];
    database.dispose();
    return size;
  }

  createProductsTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Product().tableName}(
      ${Product().id} INTEGER PRIMARY KEY,
      ${Product().name} TEXT not null,
      ${Product().category} TEXT not null,
      ${Product().brand} TEXT,
      ${Product().color} TEXT,
      ${Product().size} TEXT,
      ${Product().sizeType} TEXT,
      ${Product().amount} INTEGER not null,
      ${Product().price} REAL not null,
      ${Product().visible} INTEGER not null
      )
      ''',
    );
    database.dispose();
  }

  deleteProductsTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Product().tableName}
      ''',
    );
    database.dispose();
  }

  createSuppliersTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Supplier().tableName}(
      ${Supplier().id} INTEGER PRIMARY KEY,
      ${Supplier().name} TEXT not null,
      ${Supplier().phone} TEXT,
      ${Supplier().address} TEXT
      )
      ''',
    );
    database.dispose();
  }

  deleteSuppliersTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Supplier().tableName}
      ''',
    );
    database.dispose();
  }

  createPurchasesTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Purchase().tableName}(
      ${Purchase().id} INTEGER PRIMARY KEY,
      ${Purchase().supplierID} INTEGER,
      ${Purchase().productID} INTEGER not null,
      ${Purchase().amount} INTEGER not null,
      ${Purchase().price} REAL not null,
      ${Purchase().date} DATE not null,
      CONSTRAINT ${Purchase().tableName}Const1
      FOREIGN KEY (${Purchase().supplierID})
      REFERENCES ${Supplier().tableName}(${Supplier().id})
      ON DELETE SET NULL,
      CONSTRAINT ${Purchase().tableName}Const2
      FOREIGN KEY (${Purchase().productID})
      REFERENCES ${Purchase().tableName}(${Product().id})
      ON DELETE SET NULL
      )
      ''',
    );
    database.dispose();
  }

  deletePurchasesTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      'DROP TABLE IF EXISTS ${Purchase().tableName}',
    );
    database.dispose();
  }

  createSalesTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Sale().tableName}(
      ${Sale().id} INTEGER PRIMARY KEY,
      ${Sale().productID} INTEGER not null,
      ${Sale().amount} INTEGER not null,
      ${Sale().price} REAL not null,
      ${Sale().date} DATE not null,
      CONSTRAINT ${Sale().tableName}Const1
      FOREIGN KEY (${Sale().productID})
      REFERENCES ${Product().tableName}(${Product().id})
      ON DELETE SET NULL
      )
      ''',
    );
    database.dispose();
  }

  deleteSalesTable() {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Sale().tableName}
      ''',
    );
    database.dispose();
  }

  getProducts(
    int? id,
    String? name,
    String? spec,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
    bool? visible,
  ) {
    String query = 'SELECT * FROM ${Product().tableName}';
    bool isSearching = false;

    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Product().id}=$id';
    }
    if (name != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Product().name} LIKE "%$name%"';
    }
    if (spec != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' INTERSECT SELECT * FROM ${Product().tableName} WHERE';
      }
      query +=
          ' ${Product().brand} LIKE "%$spec%" OR ${Product().category} LIKE "%$spec%" OR ${Product().color} LIKE "%$spec%" OR ${Product().size} LIKE "%$spec%" OR ${Product().sizeType} LIKE "%$spec%"';
    }
    if (minPrice != null || maxPrice != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' INTERSECT SELECT * FROM ${Product().tableName} WHERE';
      }
      if (minPrice != null) {
        query += ' ${Product().price}>=$minPrice';
      }
      if (maxPrice != null) {
        if (minPrice != null) {
          query += ' AND';
        }
        query += ' ${Product().price}<=$maxPrice';
      }
    }
    if (minAmount != null || maxAmount != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' INTERSECT SELECT * FROM ${Product().tableName} WHERE';
      }
      if (minAmount != null) {
        query += ' ${Product().amount}>=$minAmount';
      }
      if (maxAmount != null) {
        if (minAmount != null) {
          query += ' AND';
        }
        query += ' ${Product().amount}<=$maxAmount';
      }
    }
    if (visible != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' INTERSECT SELECT * FROM ${Product().tableName} WHERE';
      }
      query += ' ${Product().visible}==$visible';
    }

    Database database = sqlite3.open(dbName);
    var products = database.select(query);
    database.dispose();

    return products;
  }

  insertProduct(Map<dynamic, dynamic> product) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      INSERT INTO ${Product().tableName}(
      ${Product().id},
      ${Product().name},
      ${Product().brand},
      ${Product().category},
      ${Product().color},
      ${Product().size},
      ${Product().sizeType},
      ${Product().amount},
      ${Product().price},
      ${Product().visible}
      ) VALUES(?,?,?,?,?,?,?,?,?,?)
      ''',
      [
        product[Product().id] as int,
        product[Product().name] as String,
        product[Product().brand] as String,
        product[Product().category] as String,
        product[Product().color] as String,
        product[Product().size] as String,
        product[Product().sizeType] as String,
        product[Product().amount] as int,
        product[Product().price] as double,
        product[Product().visible] as int,
      ],
    );
    database.dispose();
  }

  updateProduct(Map<dynamic, dynamic> product) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      UPDATE ${Product().tableName} SET
      ${Product().name}=?,
      ${Product().brand}=?,
      ${Product().category}=?,
      ${Product().color}=?,
      ${Product().size}=?,
      ${Product().sizeType}=?,
      ${Product().amount}=?,
      ${Product().price}=?,
      ${Product().visible}=?
      WHERE ${Product().id}=?
      ''',
      [
        product[Product().name] as String,
        product[Product().brand] as String,
        product[Product().category] as String,
        product[Product().color] as String,
        product[Product().size] as String,
        product[Product().sizeType] as String,
        product[Product().amount] as int,
        product[Product().price] as double,
        product[Product().visible] as int,
        product[Product().id] as int,
      ],
    );
    database.dispose();
  }

  deleteProduct(int id) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DELETE FROM ${Product().tableName}
      WHERE ${Product().id}=$id
      ''',
    );
    database.dispose();
  }

  changeProductVisibility(int id, bool visible) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      UPDATE ${Product().tableName} SET
      ${Product().visible}=?
      WHERE ${Product().id}=?
      ''',
      [
        visible ? 1 : 0,
        id,
      ],
    );
    database.dispose();
  }

  getSuppliers(
    int? id,
    String? info,
  ) {
    String query = 'SELECT * FROM ${Supplier().tableName}';
    bool isSearching = false;
    if (id != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      }
      query += ' ${Supplier().id}=$id';
    }

    if (info != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' INTERSECT SELECT * FROM ${Supplier().tableName} WHERE';
      }
      query +=
          ' ${Supplier().name} LIKE "%$info%" OR ${Supplier().phone} LIKE "%$info%" OR ${Supplier().address} LIKE "%$info%"';
    }

    Database database = sqlite3.open(dbName);
    var suppliers = database.select(query);
    database.dispose();

    return suppliers;
  }

  insertSupplier(Map<dynamic, dynamic> supplier) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      INSERT INTO ${Supplier().tableName}(
      ${Supplier().id},
      ${Supplier().name},
      ${Supplier().phone},
      ${Supplier().address}
      ) VALUES(?,?,?,?)
      ''',
      [
        supplier[Supplier().id],
        supplier[Supplier().name],
        supplier[Supplier().phone],
        supplier[Supplier().address],
      ],
    );
    database.dispose();
  }

  updateSupplier(Map<dynamic, dynamic> supplier) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      UPDATE ${Supplier().tableName} SET
      ${Supplier().name}=?,
      ${Supplier().phone}=?,
      ${Supplier().address}=?
      WHERE ${Supplier().id}=?
      ''',
      [
        supplier[Supplier().name],
        supplier[Supplier().phone],
        supplier[Supplier().address],
        supplier[Supplier().id],
      ],
    );
    database.dispose();
  }

  deleteSupplier(int id) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DELETE FROM ${Supplier().tableName}
      WHERE ${Supplier().id}=$id
      ''',
    );
    database.dispose();
  }

  getPurchases(
    int? id,
    String? date1,
    String? date2,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
  ) {
    String query = """
        SELECT
        ${Purchase().tableName}.${Purchase().id},
        ${Purchase().tableName}.${Purchase().price},
        ${Purchase().tableName}.${Purchase().amount},
        ${Purchase().tableName}.${Purchase().supplierID},
        ${Purchase().tableName}.${Purchase().productID},
        ${Product().tableName}.${Product().name} AS ${Purchase().productName},
        ${Product().tableName}.${Product().brand},
        ${Product().tableName}.${Product().color},
        ${Product().tableName}.${Product().size},
        ${Product().tableName}.${Product().sizeType},
        ${Purchase().tableName}.${Purchase().date},
        STRFTIME('%d.%m.%Y', ${Purchase().tableName}.${Purchase().date})
        AS ${Purchase().formattedDate}
        FROM ${Purchase().tableName}, ${Product().tableName}
        WHERE ${Purchase().tableName}.${Purchase().productID}==${Product().tableName}.${Product().id}
        """;

    if (id != null) {
      query += ' AND ${Purchase().tableName}.${Purchase().id}="$id"';
    }
    if (date1 != null) {
      query += ' AND ${Purchase().tableName}.${Purchase().date}>="$date1"';
    }
    if (date2 != null) {
      query += ' AND ${Purchase().tableName}.${Purchase().date}<="$date2"';
    }
    if (minPrice != null) {
      query += ' AND ${Purchase().tableName}.${Purchase().price}>=$minPrice';
    }
    if (maxPrice != null && minPrice != null) {
      query += ' AND ${Purchase().tableName}.${Purchase().price}<=$maxPrice';
    }
    if (minAmount != null) {
      query += ' AND ${Purchase().amount}>=$minAmount';
    }
    if (maxAmount != null) {
      query += ' AND ${Purchase().amount}<=$maxAmount';
    }

    Database database = sqlite3.open(dbName);
    var purchases = database.select(query);
    database.dispose();

    return purchases;
  }

  insertPurchase(Map<dynamic, dynamic> purchase) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      INSERT INTO ${Purchase().tableName}(
      ${Purchase().id},
      ${Purchase().supplierID},
      ${Purchase().productID},
      ${Purchase().amount},
      ${Purchase().price},
      ${Purchase().date}
      ) VALUES(?,?,?,?,?,?)
      ''',
      [
        purchase[Purchase().id],
        purchase[Purchase().supplierID],
        purchase[Purchase().productID],
        purchase[Purchase().amount],
        purchase[Purchase().price],
        purchase[Purchase().date],
      ],
    );
    database.dispose();
  }

  updatePurchase(Map<dynamic, dynamic> purchase) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      UPDATE ${Purchase().tableName} SET
      ${Purchase().supplierID}=?,
      ${Purchase().productID}=?,
      ${Purchase().amount}=?,
      ${Purchase().price}=?,
      ${Purchase().date}=?
      WHERE ${Purchase().id}=?
      ''',
      [
        purchase[Purchase().supplierID],
        purchase[Purchase().productID],
        purchase[Purchase().amount],
        purchase[Purchase().price],
        purchase[Purchase().date],
        purchase[Purchase().id],
      ],
    );
    database.dispose();
  }

  deletePurchase(int id) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DELETE FROM ${Purchase().tableName}
      WHERE ${Purchase().id}=$id
      ''',
    );
    database.dispose();
  }

  getSales(
    String? id,
    String? date1,
    String? date2,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
  ) {
    String query = """
        SELECT
        ${Sale().tableName}.${Sale().id},
        ${Sale().tableName}.${Sale().price},
        ${Sale().tableName}.${Sale().amount},
        ${Sale().tableName}.${Sale().productID},
        ${Product().tableName}.${Product().name} AS ${Sale().productName},
        ${Product().tableName}.${Product().brand},
        ${Product().tableName}.${Product().color},
        ${Product().tableName}.${Product().size},
        ${Product().tableName}.${Product().sizeType},
        ${Sale().tableName}.${Sale().date},
        STRFTIME('%d.%m.%Y', ${Sale().tableName}.${Sale().date})
        AS ${Sale().formattedDate}
        FROM ${Sale().tableName}, ${Product().tableName}
        WHERE ${Sale().tableName}.${Sale().productID}==${Product().tableName}.${Product().id}
        """;

    if (id != null) {
      query += ' AND ${Sale().tableName}.${Sale().id}="$id"';
    }
    if (date1 != null) {
      query += ' AND ${Sale().tableName}.${Sale().date}>="$date1"';
    }
    if (date2 != null) {
      query += ' AND ${Sale().tableName}.${Sale().date}<="$date2"';
    }
    if (minPrice != null) {
      query += ' AND ${Sale().tableName}.${Sale().price}>=$minPrice';
    }
    if (maxPrice != null && minPrice != null) {
      query += ' AND ${Sale().tableName}.${Sale().price}<=$maxPrice';
    }
    if (minAmount != null) {
      query += ' AND ${Sale().amount}>=$minAmount';
    }
    if (maxAmount != null) {
      query += ' AND ${Sale().amount}<=$maxAmount';
    }

    Database database = sqlite3.open(dbName);
    var sales = database.select(query);
    database.dispose();

    return sales;
  }

  insertSale(Map<dynamic, dynamic> sale) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      INSERT INTO ${Sale().tableName}(
      ${Sale().id},
      ${Sale().productID},
      ${Sale().amount},
      ${Sale().price},
      ${Sale().date}
      ) VALUES(?,?,?,?,?)
      ''',
      [
        sale[Sale().id],
        sale[Sale().productID],
        sale[Sale().amount],
        sale[Sale().price],
        sale[Sale().date],
      ],
    );
    database.dispose();
  }

  updateSale(Map<dynamic, dynamic> sale) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      UPDATE ${Sale().tableName} SET
      ${Sale().productID}=?,
      ${Sale().amount}=?,
      ${Sale().price}=?,
      ${Sale().date}=?
      WHERE ${Sale().id}=?
      ''',
      [
        sale[Sale().productID],
        sale[Sale().amount],
        sale[Sale().price],
        sale[Sale().date],
        sale[Sale().id],
      ],
    );
    database.dispose();
  }

  deleteSale(int id) {
    Database database = sqlite3.open(dbName);
    database.execute(
      '''
      DELETE FROM ${Sale().tableName}
      WHERE ${Sale().id}=$id
      ''',
    );
    database.dispose();
  }
}

validDate(String day, String month, String year) {
  try {
    int intDay = int.parse(day);
    int intMonth = int.parse(month);
    int intYear = int.parse(year);
    if (intDay < 1 || intMonth < 1 || intYear < 1000) {
      throw Exception();
    } else if (intMonth > 12 || intYear > 9999) {
      throw Exception();
    } else if (intMonth == 2) {
      if (intYear % 4 == 0 && intDay > 29) {
        throw Exception();
      } else if (intYear % 4 != 0 && intDay > 28) {
        throw Exception();
      }
    } else if ([4, 6, 9, 11].contains(intMonth) && intDay > 30) {
      throw Exception();
    } else if (intDay > 31) {
      throw Exception();
    }
    return true;
  } catch (_) {
    return false;
  }
}

autoFill(String name) {
  Map<dynamic, dynamic> product = {
    Product().brand: null,
    Product().color: null,
    Product().size: null,
    Product().sizeType: null,
  };

  RegExp brandExp = RegExp(
    r'([\wİıĞğÇçŞşÜüÖö]+(\s)+marka\b)',
    caseSensitive: false,
  );

  RegExp colorExp = RegExp(
    r'([\wİıĞğÇçŞşÜüÖö]+(\s)+renk\b)',
    caseSensitive: false,
  );

  RegExp sizeExp = RegExp(
    r'([\wİıĞğÇçŞşÜüÖö]+(\s)+(beden|boy(ut)?|l([İi]tre)?|sant[İi]mere|m(etre)?|cm)\b)',
    caseSensitive: false,
  );

  RegExpMatch? match;

  match = brandExp.firstMatch(name);
  if (match != null) {
    String brand = match[0]!.trim();
    brand = brand.split(" ")[0];
    product[Product().brand] = brand;
  }

  match = colorExp.firstMatch(name);
  if (match != null) {
    String color = match[0]!.trim();
    color = color.split(" ")[0];
    product[Product().color] = color;
  }

  match = sizeExp.firstMatch(name);
  if (match != null) {
    String fullSize = match[0]!.trim();
    List<String> splittedSize = fullSize.split(" ");
    product[Product().size] = splittedSize[0];
    product[Product().sizeType] = splittedSize[1];
  }

  return product;
}
