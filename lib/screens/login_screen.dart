import 'package:flutter/material.dart';

import '../backend/theme.dart';
import '../backend/methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isPasswordTrue = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isPasswordTrue = false;
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: FutureBuilder<bool>(
        future: SharedPrefsService().passwordExists,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Yükleniyor...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: YMColors().black,
                  fontSize: YMSizes().fontSize,
                ),
              ),
            );
          } else if (snapshot.data == false) {
            return Center(
              child: Text(
                'Lütfen şifre belirleyin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: YMColors().black,
                  fontSize: YMSizes().fontSize,
                ),
              ),
            );
          } else {
            return FutureBuilder<String?>(
              future: SharedPrefsService().getPassword(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      'Yükleniyor...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: YMColors().black,
                        fontSize: YMSizes().fontSize,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset(
                            'assets/images/yildiz_motor_logo.png',
                            height: MediaQuery.of(context).size.height / 3,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  key: UniqueKey(),
                                  obscureText: !isPasswordVisible,
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: YMColors().blue,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Şifre",
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 16,
                                      color: YMColors().blue.withOpacity(1),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: isPasswordVisible
                                      ? Colors.black
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                splashColor: Colors.transparent,
                                splashRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            isPasswordTrue ? "" : "Enter valid credentials!",
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontFamily: "Nunito",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                signIn(passwordController.text);
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 3),
                                      blurRadius: 6,
                                      color: const Color(0xff000000)
                                          .withOpacity(0.16),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "Giriş",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Nunito",
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
