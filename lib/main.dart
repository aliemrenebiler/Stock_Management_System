import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/add_product_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/list_product_screen.dart';
import 'screens/login_screen.dart';
import 'screens/set_password_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(300, 300));
  runApp(const MyApp());
}

bool loginFlag = false;

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
          case '/set_password':
            return PageTransition(
              child: const SetPasswordScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/home':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/list_product':
            return PageTransition(
              child: const ListProductScreen(),
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
          // case '/sell_buy':
          //   return PageTransition(
          //     child: const AddProductScreen(),
          //     type: PageTransitionType.fade,
          //     settings: settings,
          //   );
          default:
            return PageTransition(
              child: const ListProductScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      },
    );
  }
}
