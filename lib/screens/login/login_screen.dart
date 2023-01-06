import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/screens/login/enter_password_screen.dart';

import 'set_password_screen.dart';
import '../../backend/theme.dart';
import '../../backend/methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: FutureBuilder<Object>(
        future: SharedPrefsService().getPassword(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Yükleniyor...',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: YMColors().black,
                  fontWeight: FontWeight.bold,
                  fontSize: YMSizes().fontSizeLarge,
                ),
              ),
            );
          } else if (snapshot.data == false) {
            return SetPasswordScreen(
              notifyParent: refresh,
            );
          } else {
            password = snapshot.data.toString();
            return const EnterPasswordScreen();
          }
        },
      ),
    );
  }
}
