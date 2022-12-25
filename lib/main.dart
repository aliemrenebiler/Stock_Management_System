import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yildiz_motor_v2/screens/add_product_screen.dart';
import 'package:yildiz_motor_v2/screens/edit_product_screen.dart';
import 'package:yildiz_motor_v2/screens/list_product_screen.dart';
import 'screens/login_screen.dart';
import 'screens/set_password_screen.dart';
import 'screens/home_screen.dart';

void main() {
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
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      },
    );
  }
}
