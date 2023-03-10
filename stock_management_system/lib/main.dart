import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:page_transition/page_transition.dart';

// Main
import 'screens/password/login_screen.dart';
import 'screens/home_screen.dart';

// Category
import 'screens/category/add_category_screen.dart';
import 'screens/category/edit_category_screen.dart';
import 'screens/category/list_categories_screen.dart';

// Product
import 'screens/product/list_products_screen.dart';
import 'screens/product/add_product_screen.dart';
import 'screens/product/edit_product_screen.dart';
import 'screens/product/buy_product_screen.dart';
import 'screens/product/sell_product_screen.dart';

// Supplier
import 'screens/supplier/list_suppliers_screen.dart';
import 'screens/supplier/add_supplier_screen.dart';
import 'screens/supplier/edit_supplier_screen.dart';

// Purchase
import 'screens/purchase/list_purchases_screen.dart';
import 'screens/purchase/edit_purchase_screen.dart';

// Sale
import 'screens/sale/list_sales_screen.dart';
import 'screens/sale/edit_sale_screen.dart';

// Settings
import 'screens/settings/clear_data_screen.dart';
import 'screens/settings/change_password_screen.dart';
import 'screens/settings/import_export_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(const Size(500, 500));
  setWindowTitle("Yıldız Motor");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/home':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_categories':
            return PageTransition(
              child: const ListCategoriesScreen(
                isSelectionModeActive: false,
              ),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/select_category':
            return PageTransition(
              child: const ListCategoriesScreen(
                isSelectionModeActive: true,
              ),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/add_category':
            return PageTransition(
              child: const AddCategoryScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_category':
            return PageTransition(
              child: const EditCategoryScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_products':
            return PageTransition(
              child: const ListProductsScreen(
                listVisibleItems: true,
              ),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_deleted_products':
            return PageTransition(
              child: const ListProductsScreen(
                listVisibleItems: false,
              ),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/add_product':
            return PageTransition(
              child: const AddProductScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_product':
            return PageTransition(
              child: const EditProductScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/buy_product':
            return PageTransition(
              child: const BuyProductScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/sell_product':
            return PageTransition(
              child: const SellProductScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_suppliers':
            return PageTransition(
              child: const ListSuppliersScreen(isSelectionModeActive: false),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/select_supplier':
            return PageTransition(
              child: const ListSuppliersScreen(isSelectionModeActive: true),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/add_supplier':
            return PageTransition(
              child: const AddSupplierScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_supplier':
            return PageTransition(
              child: const EditSupplierScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_purchases':
            return PageTransition(
              child: const ListPurchasesScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_purchase':
            return PageTransition(
              child: const EditPurchaseScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_sales':
            return PageTransition(
              child: const ListSalesScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_sale':
            return PageTransition(
              child: const EditSaleScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/settings':
            return PageTransition(
              child: const SettingsScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/change_password':
            return PageTransition(
              child: const ChangePasswordScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/import_export':
            return PageTransition(
              child: const ImportExportScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/clear_data':
            return PageTransition(
              child: const ClearDataScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          default:
            return PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      },
    );
  }
}
