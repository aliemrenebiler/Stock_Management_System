import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

class EnterPasswordScreen extends StatelessWidget {
  const EnterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          TopBar(
            widgets: [
              Expanded(
                flex: 10,
                child: Text(
                  "Giriş",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: YMColors().white,
                    fontSize: YMSizes().fontSizeLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: YMColors().lightGrey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomTextField(
                              height: 50,
                              hideText: true,
                              hintText: "Lütfen şifre giriniz.",
                              controller: passwordController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: MenuButton(
                            text: "Giriş Yap",
                            onPressed: () {
                              if (password != passwordController.text) {
                                passwordController.clear();
                                print(
                                    "Password is wrong."); // TODO: Visual Warning
                              } else {
                                passwordController.clear();
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }
                            },
                            bgColor: YMColors().blue,
                            textColor: YMColors().white,
                            height: 50,
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
