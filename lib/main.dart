import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yildiz_motor_v2/screens/settings/clear_data_screen.dart';

import 'screens/supplier/edit_supplier_screen.dart';
import 'screens/supplier/list_suppliers_screen.dart';
import 'screens/settings/change_password_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/purchase/edit_purchase_screen.dart';
import 'screens/purchase/list_purchases_screen.dart';
import 'screens/sale/edit_sale_screen.dart';
import 'screens/sale/list_sales_screen.dart';
import 'screens/product/buy_product_screen.dart';
import 'screens/product/sell_product_screen.dart';
import 'screens/product/add_product_screen.dart';
import 'screens/product/edit_product_screen.dart';
import 'screens/product/list_products_screen.dart';
import 'screens/password/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(500, 500));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          case '/list_products':
            return PageTransition(
              child: const ListProductsScreen(),
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
          case '/list_suppliers':
            return PageTransition(
              child: const ListSuppliersScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/edit_supplier':
            return PageTransition(
              child: const EditSupplierScreen(),
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
