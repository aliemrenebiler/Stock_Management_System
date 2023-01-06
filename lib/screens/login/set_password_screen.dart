import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_bar.dart';

class SetPasswordScreen extends StatelessWidget {
  final Function() notifyParent;
  const SetPasswordScreen({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    TextEditingController password1Controller = TextEditingController();
    TextEditingController password2Controller = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          TopBar(
            widgets: [
              Expanded(
                flex: 10,
                child: Text(
                  "Şifre Belirle",
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
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: YMColors().lightGrey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Şifre",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CustomTextField(
                                            height: 50,
                                            hintText: "(Zorunlu)",
                                            controller: password1Controller,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Şifre Tekrar",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize:
                                                  YMSizes().fontSizeMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CustomTextField(
                                            height: 50,
                                            hintText: "(Zorunlu)",
                                            controller: password2Controller,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: MenuButton(
                                  text: "Temizle",
                                  onPressed: () {
                                    password1Controller.clear();
                                    password2Controller.clear();
                                  },
                                  bgColor: YMColors().grey,
                                  textColor: YMColors().white,
                                  height: 50,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: MenuButton(
                                  text: "Kaydet",
                                  onPressed: () {
                                    if (password1Controller.text.isEmpty ||
                                        password2Controller.text.isEmpty) {
                                      print(
                                          "Can't be empty."); // TODO: Visual Warning
                                    } else {
                                      if (password1Controller.text !=
                                          password2Controller.text) {
                                        print(
                                            "Passwords are not matching."); // TODO: Visual Warning
                                      } else {
                                        SharedPrefsService().setPassword(
                                            password2Controller.text);
                                        notifyParent();
                                      }
                                    }
                                  },
                                  bgColor: YMColors().blue,
                                  textColor: YMColors().white,
                                  height: 50,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
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
