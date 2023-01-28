import 'package:flutter/material.dart';

import '../../backend/methods.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class EnterPasswordScreen extends StatefulWidget {
  const EnterPasswordScreen({super.key});

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          const CustomTopBar(
            title: 'Giriş Yap',
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: YMSizes().maxWidth,
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
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Lütfen şifrenizi giriniz.",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: YMSizes().fontSizeSmall,
                                        color: YMColors().black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CustomTextFormField(
                                      height: 50,
                                      hideText: true,
                                      hintText: "Şifre",
                                      controller: passwordController,
                                      action: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomButton(
                            text: "Giriş Yap",
                            onPressed: () async {
                              if (passwordController.text !=
                                  await SharedPrefsService().getPassword()) {
                                if (mounted) {
                                  showCustomSnackBar(
                                    context,
                                    "Şifre hatalı.",
                                    YMColors().white,
                                    YMColors().red,
                                  );
                                }
                              } else {
                                passwordController.clear();
                                if (mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, "/home");
                                }
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
