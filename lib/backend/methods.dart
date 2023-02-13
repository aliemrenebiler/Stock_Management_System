import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart';

import 'classes.dart';

// Constants
const String dbName = "yildiz_motor_db.db";
const int listedItemCount = 10;

// Globals
List<String> routeStack = [];

List<Map<dynamic, dynamic>> listedItems = [];

Map<dynamic, dynamic> stableItem = {};
Map<dynamic, dynamic> editedItem = {};
Map<dynamic, dynamic>? selectedItem;

int currentPage = 1;
int totalPage = 1;

// Functions
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
  openDatabase(String dbName) {
    Database database = sqlite3.open(dbName);
    // The SQL down below is needed for "ON DELETE CASCADE" to work
    database.execute("PRAGMA foreign_keys = ON;");
    return database;
  }

  get areTablesExists {
    Database database = openDatabase(dbName);
    int tableCount = database.select(
      '''
      SELECT COUNT(name)
      FROM sqlite_master
      WHERE type="table"
      AND (
      name="${Product().tableName}"
      OR name="${Supplier().tableName}"
      OR name="${Purchase().tableName}"
      OR name="${Sale().tableName}"
      )
      ''',
    )[0][0];
    database.dispose();
    if (tableCount == 4) {
      return true;
    } else {
      return false;
    }
  }

  createCategoriesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Category().tableName}(
      ${Category().id} INTEGER PRIMARY KEY,
      ${Category().name} TEXT not null
      )
      ''',
    );
    database.dispose();
  }

  deleteCategoriesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Category().tableName}
      ''',
    );
    database.dispose();
  }

  createProductsTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Product().tableName}(
      ${Product().id} INTEGER PRIMARY KEY,
      ${Product().categoryID} INTEGER not null,
      ${Product().name} TEXT not null,
      ${Product().brand} TEXT,
      ${Product().color} TEXT,
      ${Product().size} TEXT,
      ${Product().sizeType} TEXT,
      ${Product().amount} INTEGER not null,
      ${Product().price} REAL not null,
      ${Product().visible} INTEGER not null,
      FOREIGN KEY (${Product().categoryID})
      REFERENCES ${Category().tableName}(${Category().id})
      ON DELETE CASCADE
      )
      ''',
    );
    database.dispose();
  }

  deleteProductsTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Product().tableName}
      ''',
    );
    database.dispose();
  }

  createSuppliersTable() {
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Supplier().tableName}
      ''',
    );
    database.dispose();
  }

  createPurchasesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Purchase().tableName}(
      ${Purchase().id} INTEGER PRIMARY KEY,
      ${Purchase().supplierID} INTEGER,
      ${Purchase().productID} INTEGER not null,
      ${Purchase().amount} INTEGER not null,
      ${Purchase().price} REAL not null,
      ${Purchase().date} DATE not null,
      FOREIGN KEY (${Purchase().supplierID})
      REFERENCES ${Supplier().tableName}(${Supplier().id})
      ON DELETE CASCADE,
      FOREIGN KEY (${Purchase().productID})
      REFERENCES ${Product().tableName}(${Product().id})
      ON DELETE CASCADE
      )
      ''',
    );
    database.dispose();
  }

  deletePurchasesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      'DROP TABLE IF EXISTS ${Purchase().tableName}',
    );
    database.dispose();
  }

  createSalesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Sale().tableName}(
      ${Sale().id} INTEGER PRIMARY KEY,
      ${Sale().productID} INTEGER not null,
      ${Sale().amount} INTEGER not null,
      ${Sale().price} REAL not null,
      ${Sale().date} DATE not null,
      FOREIGN KEY (${Sale().productID})
      REFERENCES ${Product().tableName}(${Product().id})
      ON DELETE CASCADE
      )
      ''',
    );
    database.dispose();
  }

  deleteSalesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Sale().tableName}
      ''',
    );
    database.dispose();
  }

  getCategories(
    bool getCount,
    int? id,
    String? name,
    int? limit,
    int? offset,
  ) {
    String query;
    if (getCount) {
      query = 'SELECT COUNT(*) FROM ${Category().tableName}';
    } else {
      query = 'SELECT * FROM ${Category().tableName}';
    }

    bool isSearching = false;

    if (id != null) {
      isSearching = true;
      query += ' WHERE ${Category().id}=$id';
    }
    if (name != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Category().name} LIKE "%$name%"';
    }

    if (limit != null) {
      query += ' LIMIT $limit';
    }
    if (offset != null) {
      query += ' OFFSET $offset';
    }

    Database database = openDatabase(dbName);
    var categories = database.select(query);
    database.dispose();

    if (getCount) {
      return categories[0][0];
    } else {
      return categories;
    }
  }

  insertCategory(Map<dynamic, dynamic> category) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      INSERT INTO ${Category().tableName}(
      ${Product().id},
      ${Product().name}
      ) VALUES(?,?)
      ''',
      [
        category[Category().id] as int,
        category[Category().name] as String,
      ],
    );
    database.dispose();
  }

  updateCategory(Map<dynamic, dynamic> category) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Category().tableName} SET
      ${Category().name}=?
      WHERE ${Category().id}=?
      ''',
      [
        category[Category().name] as String,
        category[Category().id] as int,
      ],
    );
    database.dispose();
  }

  deleteCategory(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Category().tableName}
      WHERE ${Category().id}=$id
      ''',
    );
    database.dispose();
  }

  getProducts(
    bool getCount,
    int? id,
    String? name,
    String? spec,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
    bool? visible,
    int? limit,
    int? offset,
  ) {
    String query;
    if (getCount) {
      query = '''
      SELECT COUNT(*)
      ''';
    } else {
      query = '''
      SELECT ${Product().tableName}.${Product().id},
      ${Product().tableName}.${Product().categoryID},
      ${Category().tableName}.${Category().name} AS ${Product().categoryName},
      ${Product().tableName}.${Product().name},
      ${Product().tableName}.${Product().brand},
      ${Product().tableName}.${Product().color},
      ${Product().tableName}.${Product().size},
      ${Product().tableName}.${Product().sizeType},
      ${Product().tableName}.${Product().price},
      ${Product().tableName}.${Product().amount},
      ${Product().tableName}.${Product().visible}
      ''';
    }

    query += '''
      FROM ${Product().tableName}, ${Category().tableName}
      WHERE ${Product().tableName}.${Product().categoryID}==${Category().tableName}.${Category().id}
      ''';

    if (id != null) {
      query += ' AND ${Product().id}=$id';
    }
    if (name != null) {
      query += ' AND ${Product().name} LIKE "%$name%"';
    }
    if (spec != null) {
      query += ''' AND (${Product().brand} LIKE "%$spec%"
          OR ${Product().categoryName} LIKE "%$spec%"
          OR ${Product().color} LIKE "%$spec%"
          OR ${Product().size} LIKE "%$spec%"
          OR ${Product().sizeType} LIKE "%$spec%"
          )
          ''';
    }
    if (minPrice != null) {
      query += ' AND ${Product().price}>=$minPrice';
    }
    if (maxPrice != null) {
      query += ' AND ${Product().price}<=$maxPrice';
    }
    if (minAmount != null) {
      query += ' AND ${Product().amount}>=$minAmount';
    }
    if (maxAmount != null) {
      query += ' AND ${Product().amount}<=$maxAmount';
    }
    if (visible != null) {
      query += ' AND ${Product().visible}==$visible';
    }

    if (limit != null) {
      query += ' LIMIT $limit';
    }
    if (offset != null) {
      query += ' OFFSET $offset';
    }

    Database database = openDatabase(dbName);
    var products = database.select(query);
    database.dispose();

    if (getCount) {
      return products[0][0];
    } else {
      return products;
    }
  }

  insertProduct(Map<dynamic, dynamic> product) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      INSERT INTO ${Product().tableName}(
      ${Product().id},
      ${Product().name},
      ${Product().brand},
      ${Product().categoryID},
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
        product[Product().categoryID] as int,
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
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Product().tableName} SET
      ${Product().name}=?,
      ${Product().brand}=?,
      ${Product().categoryID}=?,
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
        product[Product().categoryID] as int,
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
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Product().tableName}
      WHERE ${Product().id}=$id
      ''',
    );
    database.dispose();
  }

  changeProductVisibility(int id, bool visible) {
    Database database = openDatabase(dbName);
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
      isSearching = true;
      query += ' WHERE ${Supplier().id}=$id';
    }
    if (info != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' (${Supplier().name} LIKE "%$info%" OR ${Supplier().phone} LIKE "%$info%" OR ${Supplier().address} LIKE "%$info%")';
    }

    Database database = openDatabase(dbName);
    var suppliers = database.select(query);
    database.dispose();

    return suppliers;
  }

  insertSupplier(Map<dynamic, dynamic> supplier) {
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Supplier().tableName}
      WHERE ${Supplier().id}=$id
      ''',
    );
    database.dispose();
  }

  getPurchases(
    bool getCount,
    int? id,
    String? date1,
    String? date2,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
    int? limit,
    int? offset,
  ) {
    String query1 = """
        SELECT
        ${Purchase().tableName}.${Purchase().id},
        ${Purchase().tableName}.${Purchase().productID},
        ${Purchase().tableName}.${Purchase().supplierID},
        ${Purchase().tableName}.${Purchase().price},
        ${Purchase().tableName}.${Purchase().amount},
        ${Purchase().tableName}.${Purchase().date},
        STRFTIME('%d.%m.%Y', ${Purchase().tableName}.${Purchase().date})
        AS ${Purchase().formattedDate},
        ${Product().tableName}.${Product().name} AS ${Purchase().productName},
        ${Product().tableName}.${Product().brand},
        ${Product().tableName}.${Product().color},
        ${Product().tableName}.${Product().size},
        ${Product().tableName}.${Product().sizeType},
        NULL AS ${Purchase().supplierName}
        FROM ${Purchase().tableName}, ${Product().tableName}
        WHERE ${Purchase().tableName}.${Purchase().productID}==${Product().tableName}.${Product().id}
        AND ${Purchase().tableName}.${Purchase().supplierID} IS NULL
        """;

    String query2 = """
        SELECT
        ${Purchase().tableName}.${Purchase().id},
        ${Purchase().tableName}.${Purchase().productID},
        ${Purchase().tableName}.${Purchase().supplierID},
        ${Purchase().tableName}.${Purchase().price},
        ${Purchase().tableName}.${Purchase().amount},
        ${Purchase().tableName}.${Purchase().date},
        STRFTIME('%d.%m.%Y', ${Purchase().tableName}.${Purchase().date})
        AS ${Purchase().formattedDate},
        ${Product().tableName}.${Product().name} AS ${Purchase().productName},
        ${Product().tableName}.${Product().brand},
        ${Product().tableName}.${Product().color},
        ${Product().tableName}.${Product().size},
        ${Product().tableName}.${Product().sizeType},
        ${Supplier().tableName}.${Supplier().name} AS ${Purchase().supplierName}
        FROM ${Purchase().tableName}, ${Product().tableName}, ${Supplier().tableName}
        WHERE ${Purchase().tableName}.${Purchase().productID}==${Product().tableName}.${Product().id}
        AND ${Purchase().tableName}.${Purchase().supplierID}==${Supplier().tableName}.${Supplier().id}
        """;

    String query;
    if (getCount) {
      query = '''
        SELECT COUNT(*) FROM
        (
        $query1
        UNION
        $query2
        )
        ''';
    } else {
      query = '''
        SELECT * FROM
        (
        $query1
        UNION
        $query2
        )
        ''';
    }

    bool isSearching = false;

    if (id != null) {
      isSearching = true;
      query += ' WHERE ${Purchase().id}="$id"';
    }
    if (date1 != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().date}>="$date1"';
    }
    if (date2 != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().date}<="$date2"';
    }
    if (minPrice != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().price}>=$minPrice';
    }
    if (maxPrice != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().price}<=$maxPrice';
    }
    if (minAmount != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().amount}>=$minAmount';
    }
    if (maxAmount != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Purchase().amount}<=$maxAmount';
    }

    if (limit != null) {
      query += ' LIMIT $limit';
    }
    if (offset != null) {
      query += ' OFFSET $offset';
    }

    Database database = openDatabase(dbName);
    var purchases = database.select(query);
    database.dispose();

    if (getCount) {
      return purchases[0][0];
    } else {
      return purchases;
    }
  }

  insertPurchase(Map<dynamic, dynamic> purchase) {
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Purchase().tableName}
      WHERE ${Purchase().id}=$id
      ''',
    );
    database.dispose();
  }

  getSales(
    bool getCount,
    String? id,
    String? date1,
    String? date2,
    double? minPrice,
    double? maxPrice,
    int? minAmount,
    int? maxAmount,
    int? limit,
    int? offset,
  ) {
    String query;
    if (getCount) {
      query = '''
      SELECT COUNT(*)
      ''';
    } else {
      query = '''
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
      ''';
    }

    query += '''
    FROM ${Sale().tableName}, ${Product().tableName}
    WHERE ${Sale().tableName}.${Sale().productID}==${Product().tableName}.${Product().id}
    ''';

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
    if (maxPrice != null) {
      query += ' AND ${Sale().tableName}.${Sale().price}<=$maxPrice';
    }
    if (minAmount != null) {
      query += ' AND ${Sale().tableName}.${Sale().amount}>=$minAmount';
    }
    if (maxAmount != null) {
      query += ' AND ${Sale().tableName}.${Sale().amount}<=$maxAmount';
    }

    if (limit != null) {
      query += ' LIMIT $limit';
    }
    if (offset != null) {
      query += ' OFFSET $offset';
    }

    Database database = openDatabase(dbName);
    var sales = database.select(query);
    database.dispose();

    if (getCount) {
      return sales[0][0];
    } else {
      return sales;
    }
  }

  insertSale(Map<dynamic, dynamic> sale) {
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
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
    Database database = openDatabase(dbName);
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
