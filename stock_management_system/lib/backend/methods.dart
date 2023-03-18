import 'dart:async';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
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
      name="${Product.tableName["database"]}"
      OR name="${Supplier.tableName["database"]}"
      OR name="${Purchase.tableName["database"]}"
      OR name="${Sale.tableName["database"]}"
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
      CREATE TABLE IF NOT EXISTS ${Category.tableName["database"]}(
      ${Category.id["database"]} INTEGER PRIMARY KEY,
      ${Category.name["database"]} TEXT not null
      )
      ''',
    );
    database.dispose();
  }

  deleteCategoriesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Category.tableName["database"]}
      ''',
    );
    database.dispose();
  }

  createProductsTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Product.tableName["database"]}(
      ${Product.id["database"]} INTEGER PRIMARY KEY,
      ${Product.categoryID["database"]} INTEGER not null,
      ${Product.name["database"]} TEXT not null,
      ${Product.brand["database"]} TEXT,
      ${Product.color["database"]} TEXT,
      ${Product.size["database"]} TEXT,
      ${Product.sizeUnit["database"]} TEXT,
      ${Product.amount["database"]} INTEGER not null,
      ${Product.price["database"]} REAL not null,
      ${Product.visible["database"]} INTEGER not null,
      FOREIGN KEY (${Product.categoryID["database"]})
      REFERENCES ${Category.tableName["database"]}(${Category.id["database"]})
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
      DROP TABLE IF EXISTS ${Product.tableName["database"]}
      ''',
    );
    database.dispose();
  }

  createSuppliersTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Supplier.tableName["database"]}(
      ${Supplier.id["database"]} INTEGER PRIMARY KEY,
      ${Supplier.name["database"]} TEXT not null,
      ${Supplier.phone["database"]} TEXT,
      ${Supplier.address["database"]} TEXT
      )
      ''',
    );
    database.dispose();
  }

  deleteSuppliersTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DROP TABLE IF EXISTS ${Supplier.tableName["database"]}
      ''',
    );
    database.dispose();
  }

  createPurchasesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Purchase.tableName["database"]}(
      ${Purchase.id["database"]} INTEGER PRIMARY KEY,
      ${Purchase.supplierID["database"]} INTEGER,
      ${Purchase.productID["database"]} INTEGER not null,
      ${Purchase.amount["database"]} INTEGER not null,
      ${Purchase.price["database"]} REAL not null,
      ${Purchase.date["database"]} DATE not null,
      FOREIGN KEY (${Purchase.supplierID["database"]})
      REFERENCES ${Supplier.tableName["database"]}(${Supplier.id["database"]})
      ON DELETE CASCADE,
      FOREIGN KEY (${Purchase.productID["database"]})
      REFERENCES ${Product.tableName["database"]}(${Product.id["database"]})
      ON DELETE CASCADE
      )
      ''',
    );
    database.dispose();
  }

  deletePurchasesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      'DROP TABLE IF EXISTS ${Purchase.tableName["database"]}',
    );
    database.dispose();
  }

  createSalesTable() {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${Sale.tableName["database"]}(
      ${Sale.id["database"]} INTEGER PRIMARY KEY,
      ${Sale.productID["database"]} INTEGER not null,
      ${Sale.amount["database"]} INTEGER not null,
      ${Sale.price["database"]} REAL not null,
      ${Sale.date["database"]} DATE not null,
      FOREIGN KEY (${Sale.productID["database"]})
      REFERENCES ${Product.tableName["database"]}(${Product.id["database"]})
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
      DROP TABLE IF EXISTS ${Sale.tableName["database"]}
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
      query = 'SELECT COUNT(*) FROM ${Category.tableName["database"]}';
    } else {
      query = 'SELECT * FROM ${Category.tableName["database"]}';
    }

    bool isSearching = false;

    if (id != null) {
      isSearching = true;
      query += ' WHERE ${Category.id["database"]}=$id';
    }
    if (name != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query += ' ${Category.name["database"]} LIKE "%$name%"';
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
      INSERT INTO ${Category.tableName["database"]}(
      ${Product.name["database"]}
      ) VALUES(?)
      ''',
      [
        category[Category.name["database"]] as String,
      ],
    );
    database.dispose();
  }

  updateCategory(Map<dynamic, dynamic> category) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Category.tableName["database"]} SET
      ${Category.name["database"]}=?
      WHERE ${Category.id["database"]}=?
      ''',
      [
        category[Category.name["database"]] as String,
        category[Category.id["database"]] as int,
      ],
    );
    database.dispose();
  }

  deleteCategory(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Category.tableName["database"]}
      WHERE ${Category.id["database"]}=$id
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
      SELECT ${Product.tableName["database"]}.${Product.id["database"]},
      ${Product.tableName["database"]}.${Product.categoryID["database"]},
      ${Category.tableName["database"]}.${Category.name["database"]} AS ${Product.categoryName["database"]},
      ${Product.tableName["database"]}.${Product.name["database"]},
      ${Product.tableName["database"]}.${Product.brand["database"]},
      ${Product.tableName["database"]}.${Product.color["database"]},
      ${Product.tableName["database"]}.${Product.size["database"]},
      ${Product.tableName["database"]}.${Product.sizeUnit["database"]},
      ${Product.tableName["database"]}.${Product.price["database"]},
      ${Product.tableName["database"]}.${Product.amount["database"]},
      ${Product.tableName["database"]}.${Product.visible["database"]}
      ''';
    }

    query += '''
      FROM ${Product.tableName["database"]}, ${Category.tableName["database"]}
      WHERE ${Product.tableName["database"]}.${Product.categoryID["database"]}==${Category.tableName["database"]}.${Category.id["database"]}
      ''';

    if (id != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.id["database"]}=$id';
    }
    if (name != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.name["database"]} LIKE "%$name%"';
    }
    if (spec != null) {
      query +=
          ''' AND (${Product.tableName["database"]}.${Product.brand["database"]} LIKE "%$spec%"
          OR ${Category.tableName["database"]}.${Category.name["database"]} LIKE "%$spec%"
          OR ${Product.tableName["database"]}.${Product.color["database"]} LIKE "%$spec%"
          OR ${Product.tableName["database"]}.${Product.size["database"]} LIKE "%$spec%"
          OR ${Product.tableName["database"]}.${Product.sizeUnit["database"]} LIKE "%$spec%"
          )
          ''';
    }
    if (minPrice != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.price["database"]}>=$minPrice';
    }
    if (maxPrice != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.price["database"]}<=$maxPrice';
    }
    if (minAmount != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.amount["database"]}>=$minAmount';
    }
    if (maxAmount != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.amount["database"]}<=$maxAmount';
    }
    if (visible != null) {
      query +=
          ' AND ${Product.tableName["database"]}.${Product.visible["database"]}==$visible';
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
      INSERT INTO ${Product.tableName["database"]}(
      ${Product.name["database"]},
      ${Product.brand["database"]},
      ${Product.categoryID["database"]},
      ${Product.color["database"]},
      ${Product.size["database"]},
      ${Product.sizeUnit["database"]},
      ${Product.amount["database"]},
      ${Product.price["database"]},
      ${Product.visible["database"]}
      ) VALUES(?,?,?,?,?,?,?,?,?)
      ''',
      [
        product[Product.name["database"]] as String,
        product[Product.brand["database"]] as String,
        product[Product.categoryID["database"]] as int,
        product[Product.color["database"]] as String,
        product[Product.size["database"]] as String,
        product[Product.sizeUnit["database"]] as String,
        product[Product.amount["database"]] as int,
        product[Product.price["database"]] as double,
        product[Product.visible["database"]] as int,
      ],
    );
    database.dispose();
  }

  updateProduct(Map<dynamic, dynamic> product) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Product.tableName["database"]} SET
      ${Product.name["database"]}=?,
      ${Product.brand["database"]}=?,
      ${Product.categoryID["database"]}=?,
      ${Product.color["database"]}=?,
      ${Product.size["database"]}=?,
      ${Product.sizeUnit["database"]}=?,
      ${Product.amount["database"]}=?,
      ${Product.price["database"]}=?,
      ${Product.visible["database"]}=?
      WHERE ${Product.id["database"]}=?
      ''',
      [
        product[Product.name["database"]] as String,
        product[Product.brand["database"]] as String,
        product[Product.categoryID["database"]] as int,
        product[Product.color["database"]] as String,
        product[Product.size["database"]] as String,
        product[Product.sizeUnit["database"]] as String,
        product[Product.amount["database"]] as int,
        product[Product.price["database"]] as double,
        product[Product.visible["database"]] as int,
        product[Product.id["database"]] as int,
      ],
    );
    database.dispose();
  }

  deleteProduct(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Product.tableName["database"]}
      WHERE ${Product.id["database"]}=$id
      ''',
    );
    database.dispose();
  }

  changeProductVisibility(int id, bool visible) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Product.tableName["database"]} SET
      ${Product.visible["database"]}=?
      WHERE ${Product.id["database"]}=?
      ''',
      [
        visible ? 1 : 0,
        id,
      ],
    );
    database.dispose();
  }

  getSuppliers(
    bool getCount,
    int? id,
    String? info,
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
      SELECT *
      ''';
    }

    query += 'FROM ${Supplier.tableName["database"]}';

    bool isSearching = false;

    if (id != null) {
      isSearching = true;
      query += ' WHERE ${Supplier.id["database"]}=$id';
    }
    if (info != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' (${Supplier.name["database"]} LIKE "%$info%" OR ${Supplier.phone["database"]} LIKE "%$info%" OR ${Supplier.address["database"]} LIKE "%$info%")';
    }

    if (limit != null) {
      query += ' LIMIT $limit';
    }
    if (offset != null) {
      query += ' OFFSET $offset';
    }

    Database database = openDatabase(dbName);
    var suppliers = database.select(query);
    database.dispose();

    if (getCount) {
      return suppliers[0][0];
    } else {
      return suppliers;
    }
  }

  insertSupplier(Map<dynamic, dynamic> supplier) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      INSERT INTO ${Supplier.tableName["database"]}(
      ${Supplier.name["database"]},
      ${Supplier.phone["database"]},
      ${Supplier.address["database"]}
      ) VALUES(?,?,?)
      ''',
      [
        supplier[Supplier.name["database"]],
        supplier[Supplier.phone["database"]],
        supplier[Supplier.address["database"]],
      ],
    );
    database.dispose();
  }

  updateSupplier(Map<dynamic, dynamic> supplier) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Supplier.tableName["database"]} SET
      ${Supplier.name["database"]}=?,
      ${Supplier.phone["database"]}=?,
      ${Supplier.address["database"]}=?
      WHERE ${Supplier.id["database"]}=?
      ''',
      [
        supplier[Supplier.name["database"]],
        supplier[Supplier.phone["database"]],
        supplier[Supplier.address["database"]],
        supplier[Supplier.id["database"]],
      ],
    );
    database.dispose();
  }

  deleteSupplier(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Supplier.tableName["database"]}
      WHERE ${Supplier.id["database"]}=$id
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
        ${Purchase.tableName["database"]}.${Purchase.id["database"]},
        ${Purchase.tableName["database"]}.${Purchase.productID["database"]},
        ${Purchase.tableName["database"]}.${Purchase.supplierID["database"]},
        ${Purchase.tableName["database"]}.${Purchase.price["database"]},
        ${Purchase.tableName["database"]}.${Purchase.amount["database"]},
        ${Purchase.tableName["database"]}.${Purchase.date["database"]},
        STRFTIME('%d.%m.%Y', ${Purchase.tableName["database"]}.${Purchase.date["database"]})
        AS ${Purchase.formattedDate["database"]},
        ${Product.tableName["database"]}.${Product.name["database"]} AS ${Purchase.productName["database"]},
        ${Product.tableName["database"]}.${Product.brand["database"]},
        ${Product.tableName["database"]}.${Product.color["database"]},
        ${Product.tableName["database"]}.${Product.size["database"]},
        ${Product.tableName["database"]}.${Product.sizeUnit["database"]},
        NULL AS ${Purchase.supplierName["database"]}
        FROM ${Purchase.tableName["database"]}, ${Product.tableName["database"]}
        WHERE ${Purchase.tableName["database"]}.${Purchase.productID["database"]}==${Product.tableName["database"]}.${Product.id["database"]}
        AND ${Purchase.tableName["database"]}.${Purchase.supplierID["database"]} IS NULL
        """;

    String query2 = """
        SELECT
        ${Purchase.tableName["database"]}.${Purchase.id["database"]},
        ${Purchase.tableName["database"]}.${Purchase.productID["database"]},
        ${Purchase.tableName["database"]}.${Purchase.supplierID["database"]},
        ${Purchase.tableName["database"]}.${Purchase.price["database"]},
        ${Purchase.tableName["database"]}.${Purchase.amount["database"]},
        ${Purchase.tableName["database"]}.${Purchase.date["database"]},
        STRFTIME('%d.%m.%Y', ${Purchase.tableName["database"]}.${Purchase.date["database"]})
        AS ${Purchase.formattedDate["database"]},
        ${Product.tableName["database"]}.${Product.name["database"]} AS ${Purchase.productName["database"]},
        ${Product.tableName["database"]}.${Product.brand["database"]},
        ${Product.tableName["database"]}.${Product.color["database"]},
        ${Product.tableName["database"]}.${Product.size["database"]},
        ${Product.tableName["database"]}.${Product.sizeUnit["database"]},
        ${Supplier.tableName["database"]}.${Supplier.name["database"]} AS ${Purchase.supplierName["database"]}
        FROM ${Purchase.tableName["database"]}, ${Product.tableName["database"]}, ${Supplier.tableName["database"]}
        WHERE ${Purchase.tableName["database"]}.${Purchase.productID["database"]}==${Product.tableName["database"]}.${Product.id["database"]}
        AND ${Purchase.tableName["database"]}.${Purchase.supplierID["database"]}==${Supplier.tableName["database"]}.${Supplier.id["database"]}
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
      query +=
          ' WHERE ${Purchase.tableName["database"]}.${Purchase.id["database"]}="$id"';
    }
    if (date1 != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.date["database"]}>="$date1"';
    }
    if (date2 != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.date["database"]}<="$date2"';
    }
    if (minPrice != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.price["database"]}>=$minPrice';
    }
    if (maxPrice != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.price["database"]}<=$maxPrice';
    }
    if (minAmount != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.amount["database"]}>=$minAmount';
    }
    if (maxAmount != null) {
      if (!isSearching) {
        isSearching = true;
        query += ' WHERE';
      } else {
        query += ' AND';
      }
      query +=
          ' ${Purchase.tableName["database"]}.${Purchase.amount["database"]}<=$maxAmount';
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
      INSERT INTO ${Purchase.tableName["database"]}(
      ${Purchase.supplierID["database"]},
      ${Purchase.productID["database"]},
      ${Purchase.amount["database"]},
      ${Purchase.price["database"]},
      ${Purchase.date["database"]}
      ) VALUES(?,?,?,?,?)
      ''',
      [
        purchase[Purchase.supplierID["database"]],
        purchase[Purchase.productID["database"]],
        purchase[Purchase.amount["database"]],
        purchase[Purchase.price["database"]],
        purchase[Purchase.date["database"]],
      ],
    );
    database.dispose();
  }

  updatePurchase(Map<dynamic, dynamic> purchase) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Purchase.tableName["database"]} SET
      ${Purchase.supplierID["database"]}=?,
      ${Purchase.productID["database"]}=?,
      ${Purchase.amount["database"]}=?,
      ${Purchase.price["database"]}=?,
      ${Purchase.date["database"]}=?
      WHERE ${Purchase.id["database"]}=?
      ''',
      [
        purchase[Purchase.supplierID["database"]],
        purchase[Purchase.productID["database"]],
        purchase[Purchase.amount["database"]],
        purchase[Purchase.price["database"]],
        purchase[Purchase.date["database"]],
        purchase[Purchase.id["database"]],
      ],
    );
    database.dispose();
  }

  deletePurchase(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Purchase.tableName["database"]}
      WHERE ${Purchase.id["database"]}=$id
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
      ${Sale.tableName["database"]}.${Sale.id["database"]},
      ${Sale.tableName["database"]}.${Sale.price["database"]},
      ${Sale.tableName["database"]}.${Sale.amount["database"]},
      ${Sale.tableName["database"]}.${Sale.productID["database"]},
      ${Product.tableName["database"]}.${Product.name["database"]} AS ${Sale.productName["database"]},
      ${Product.tableName["database"]}.${Product.brand["database"]},
      ${Product.tableName["database"]}.${Product.color["database"]},
      ${Product.tableName["database"]}.${Product.size["database"]},
      ${Product.tableName["database"]}.${Product.sizeUnit["database"]},
      ${Sale.tableName["database"]}.${Sale.date["database"]},
      STRFTIME('%d.%m.%Y', ${Sale.tableName["database"]}.${Sale.date["database"]})
      AS ${Sale.formattedDate["database"]}
      ''';
    }

    query += '''
    FROM ${Sale.tableName["database"]}, ${Product.tableName["database"]}
    WHERE ${Sale.tableName["database"]}.${Sale.productID["database"]}==${Product.tableName["database"]}.${Product.id["database"]}
    ''';

    if (id != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.id["database"]}="$id"';
    }
    if (date1 != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.date["database"]}>="$date1"';
    }
    if (date2 != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.date["database"]}<="$date2"';
    }
    if (minPrice != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.price["database"]}>=$minPrice';
    }
    if (maxPrice != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.price["database"]}<=$maxPrice';
    }
    if (minAmount != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.amount["database"]}>=$minAmount';
    }
    if (maxAmount != null) {
      query +=
          ' AND ${Sale.tableName["database"]}.${Sale.amount["database"]}<=$maxAmount';
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
      INSERT INTO ${Sale.tableName["database"]}(
      ${Sale.productID["database"]},
      ${Sale.amount["database"]},
      ${Sale.price["database"]},
      ${Sale.date["database"]}
      ) VALUES(?,?,?,?)
      ''',
      [
        sale[Sale.productID["database"]],
        sale[Sale.amount["database"]],
        sale[Sale.price["database"]],
        sale[Sale.date["database"]],
      ],
    );
    database.dispose();
  }

  updateSale(Map<dynamic, dynamic> sale) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      UPDATE ${Sale.tableName["database"]} SET
      ${Sale.productID["database"]}=?,
      ${Sale.amount["database"]}=?,
      ${Sale.price["database"]}=?,
      ${Sale.date["database"]}=?
      WHERE ${Sale.id["database"]}=?
      ''',
      [
        sale[Sale.productID["database"]],
        sale[Sale.amount["database"]],
        sale[Sale.price["database"]],
        sale[Sale.date["database"]],
        sale[Sale.id["database"]],
      ],
    );
    database.dispose();
  }

  deleteSale(int id) {
    Database database = openDatabase(dbName);
    database.execute(
      '''
      DELETE FROM ${Sale.tableName["database"]}
      WHERE ${Sale.id["database"]}=$id
      ''',
    );
    database.dispose();
  }
}

class ExcelService {
  importExcel() async {
    try {
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (pickedFile != null && pickedFile.files.single.path != null) {
        String path = pickedFile.files.single.path!;
        var bytes = File(path).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        // TODO: Get every data from the file

        // Check if all sheets are valid
        if (!excel.sheets.keys.contains(Category.tableName["database"]) ||
            !excel.sheets.keys.contains(Product.tableName["database"]) ||
            !excel.sheets.keys.contains(Supplier.tableName["database"]) ||
            !excel.sheets.keys.contains(Purchase.tableName["database"]) ||
            !excel.sheets.keys.contains(Sale.tableName["database"])) {
          throw Error();
        }

        Sheet sheet;
        int i;

        sheet = excel.sheets[Category.tableName["database"]]!;
        i = 2;
        while (sheet.cell(CellIndex.indexByString('A$i')).value != null ||
            sheet.cell(CellIndex.indexByString('B$i')).value != null) {
          DatabaseService().insertCategory(
            {
              Category.id["database"]:
                  sheet.cell(CellIndex.indexByString('A$i')).value,
              Category.name["database"]:
                  sheet.cell(CellIndex.indexByString('B$i')).value,
            },
          );
          i++;
        }

        // print(excel);
        // print(excel.sheets.keys);
        // print(excel.sheets);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  exportExcel() async {
    try {
      String? path = await FilePicker.platform.getDirectoryPath();

      if (path == null) {
        throw Error();
      }

      // Create excel
      var excel = Excel.createExcel();
      Sheet sheet;
      int count;
      Map<dynamic, dynamic> item;

      // Create categories sheet
      sheet = excel[Category.tableName["database"]];
      sheet.cell(CellIndex.indexByString('A1')).value = Category.id["database"];
      sheet.cell(CellIndex.indexByString('B1')).value =
          Category.name["database"];
      count = DatabaseService().getCategories(true, null, null, null, null);
      for (int i = 0; i < count; i++) {
        item = DatabaseService().getCategories(false, null, null, 1, i)[0];
        if (item[Category.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('A${i + 2}')).value =
              item[Category.id["database"]];
        }
        if (item[Category.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
              item[Category.name["database"]];
        }
      }

      // Create products sheet
      sheet = excel[Product.tableName["database"]];
      sheet.cell(CellIndex.indexByString('A1')).value = Product.id["database"];
      sheet.cell(CellIndex.indexByString('B1')).value =
          Product.name["database"];
      sheet.cell(CellIndex.indexByString('C1')).value =
          Product.categoryID["database"];
      sheet.cell(CellIndex.indexByString('D1')).value =
          Product.brand["database"];
      sheet.cell(CellIndex.indexByString('E1')).value =
          Product.color["database"];
      sheet.cell(CellIndex.indexByString('F1')).value =
          Product.size["database"];
      sheet.cell(CellIndex.indexByString('G1')).value =
          Product.sizeUnit["database"];
      sheet.cell(CellIndex.indexByString('H1')).value =
          Product.price["database"];
      sheet.cell(CellIndex.indexByString('I1')).value =
          Product.amount["database"];
      sheet.cell(CellIndex.indexByString('J1')).value =
          Product.visible["database"];
      count = DatabaseService().getProducts(
          true, null, null, null, null, null, null, null, null, null, null);
      for (int i = 0; i < count; i++) {
        item = DatabaseService().getProducts(
            false, null, null, null, null, null, null, null, null, 1, i)[0];
        if (item[Product.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('A${i + 2}')).value =
              item[Product.id["database"]];
        }
        if (item[Product.name["database"]] != null) {
          sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
              item[Product.name["database"]];
        }
        if (item[Product.categoryID["database"]] != null) {
          sheet.cell(CellIndex.indexByString('C${i + 2}')).value =
              item[Product.categoryID["database"]];
        }
        if (item[Product.brand["database"]] != null) {
          sheet.cell(CellIndex.indexByString('D${i + 2}')).value =
              item[Product.brand["database"]];
        }
        if (item[Product.color["database"]] != null) {
          sheet.cell(CellIndex.indexByString('E${i + 2}')).value =
              item[Product.color["database"]];
        }
        if (item[Product.size["database"]] != null) {
          sheet.cell(CellIndex.indexByString('F${i + 2}')).value =
              item[Product.size["database"]];
        }
        if (item[Product.sizeUnit["database"]] != null) {
          sheet.cell(CellIndex.indexByString('G${i + 2}')).value =
              item[Product.sizeUnit["database"]];
        }
        if (item[Product.price["database"]] != null) {
          sheet.cell(CellIndex.indexByString('H${i + 2}')).value =
              item[Product.price["database"]];
        }
        if (item[Product.amount["database"]] != null) {
          sheet.cell(CellIndex.indexByString('I${i + 2}')).value =
              item[Product.amount["database"]];
        }
        if (item[Product.visible["database"]] != null) {
          sheet.cell(CellIndex.indexByString('J${i + 2}')).value =
              item[Product.visible["database"]];
        }
      }

      // Create suppliers sheet
      sheet = excel[Supplier.tableName["database"]];
      sheet.cell(CellIndex.indexByString('A1')).value = Supplier.id["database"];
      sheet.cell(CellIndex.indexByString('B1')).value =
          Supplier.name["database"];
      sheet.cell(CellIndex.indexByString('C1')).value =
          Supplier.phone["database"];
      sheet.cell(CellIndex.indexByString('D1')).value =
          Supplier.address["database"];
      count = DatabaseService().getSuppliers(true, null, null, null, null);
      for (int i = 0; i < count; i++) {
        item = DatabaseService().getSuppliers(false, null, null, 1, i)[0];
        if (item[Supplier.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('A${i + 2}')).value =
              item[Supplier.id["database"]];
        }
        if (item[Supplier.name["database"]] != null) {
          sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
              item[Supplier.name["database"]];
        }
        if (item[Supplier.phone["database"]] != null) {
          sheet.cell(CellIndex.indexByString('C${i + 2}')).value =
              item[Supplier.phone["database"]];
        }
        if (item[Supplier.address["database"]] != null) {
          sheet.cell(CellIndex.indexByString('D${i + 2}')).value =
              item[Supplier.address["database"]];
        }
      }

      // Create purchases sheet
      sheet = excel[Purchase.tableName["database"]];
      sheet.cell(CellIndex.indexByString('A1')).value = Purchase.id["database"];
      sheet.cell(CellIndex.indexByString('B1')).value =
          Purchase.productID["database"];
      sheet.cell(CellIndex.indexByString('C1')).value =
          Purchase.supplierID["database"];
      sheet.cell(CellIndex.indexByString('D1')).value =
          Purchase.date["database"];
      sheet.cell(CellIndex.indexByString('E1')).value =
          Purchase.price["database"];
      sheet.cell(CellIndex.indexByString('F1')).value =
          Purchase.amount["database"];
      count = DatabaseService().getPurchases(
          true, null, null, null, null, null, null, null, null, null);
      for (int i = 0; i < count; i++) {
        item = DatabaseService().getPurchases(
            false, null, null, null, null, null, null, null, 1, i)[0];
        if (item[Purchase.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('A${i + 2}')).value =
              item[Purchase.id["database"]];
        }
        if (item[Purchase.productID["database"]] != null) {
          sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
              item[Purchase.productID["database"]];
        }
        if (item[Purchase.supplierID["database"]] != null) {
          sheet.cell(CellIndex.indexByString('C${i + 2}')).value =
              item[Purchase.supplierID["database"]];
        }
        if (item[Purchase.date["database"]] != null) {
          sheet.cell(CellIndex.indexByString('D${i + 2}')).value =
              item[Purchase.date["database"]];
        }
        if (item[Purchase.price["database"]] != null) {
          sheet.cell(CellIndex.indexByString('E${i + 2}')).value =
              item[Purchase.price["database"]];
        }
        if (item[Purchase.amount["database"]] != null) {
          sheet.cell(CellIndex.indexByString('F${i + 2}')).value =
              item[Purchase.amount["database"]];
        }
      }

      // Create sales sheet
      sheet = excel[Sale.tableName["database"]];
      sheet.cell(CellIndex.indexByString('A1')).value = Sale.id["database"];
      sheet.cell(CellIndex.indexByString('B1')).value =
          Sale.productID["database"];
      sheet.cell(CellIndex.indexByString('C1')).value = Sale.date["database"];
      sheet.cell(CellIndex.indexByString('D1')).value = Sale.price["database"];
      sheet.cell(CellIndex.indexByString('E1')).value = Sale.amount["database"];
      count = DatabaseService()
          .getSales(true, null, null, null, null, null, null, null, null, null);
      for (int i = 0; i < count; i++) {
        item = DatabaseService()
            .getSales(false, null, null, null, null, null, null, null, 1, i)[0];
        if (item[Sale.id["database"]] != null) {
          sheet.cell(CellIndex.indexByString('A${i + 2}')).value =
              item[Sale.id["database"]];
        }
        if (item[Sale.productID["database"]] != null) {
          sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
              item[Sale.productID["database"]];
        }
        if (item[Sale.date["database"]] != null) {
          sheet.cell(CellIndex.indexByString('C${i + 2}')).value =
              item[Sale.date["database"]];
        }
        if (item[Sale.price["database"]] != null) {
          sheet.cell(CellIndex.indexByString('D${i + 2}')).value =
              item[Sale.price["database"]];
        }
        if (item[Sale.amount["database"]] != null) {
          sheet.cell(CellIndex.indexByString('E${i + 2}')).value =
              item[Sale.amount["database"]];
        }
      }

      // Delete default sheet
      excel.delete("Sheet1");

      // Save excel as a file
      DateTime now = DateTime.now();
      String fileName =
          "db_export_${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}.xlsx";
      var bytes = excel.save(fileName: fileName);
      File("$path/$fileName")
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes!);

      return true;
    } catch (_) {
      return false;
    }
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
    Product.brand["database"]: null,
    Product.color["database"]: null,
    Product.size["database"]: null,
    Product.sizeUnit["database"]: null,
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
    product[Product.brand["database"]] = brand;
  }

  match = colorExp.firstMatch(name);
  if (match != null) {
    String color = match[0]!.trim();
    color = color.split(" ")[0];
    product[Product.color["database"]] = color;
  }

  match = sizeExp.firstMatch(name);
  if (match != null) {
    String fullSize = match[0]!.trim();
    List<String> splittedSize = fullSize.split(" ");
    product[Product.size["database"]] = splittedSize[0];
    product[Product.sizeUnit["database"]] = splittedSize[1];
  }

  return product;
}
