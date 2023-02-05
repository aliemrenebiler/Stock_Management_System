import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/methods.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class ClearDataScreen extends StatefulWidget {
  const ClearDataScreen({super.key});

  @override
  State<ClearDataScreen> createState() => _ClearDataScreenState();
}

class _ClearDataScreenState extends State<ClearDataScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Verileri Sıfırla',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
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
                                      "Verileri sıfırlamak için lütfen şifrenizi girin.",
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
                            text: "Sıfırla",
                            onPressed: () async {
                              if (await SharedPrefsService().isPasswordExists ==
                                  false) {
                                if (mounted) {
                                  showCustomSnackBar(
                                    context,
                                    "Mevcut şifre belirlenmemiş, uygulamayı yeniden başlatın.",
                                    YMColors().white,
                                    YMColors().red,
                                  );
                                }
                              } else if (passwordController.text !=
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
                                try {
                                  DatabaseService().deletePurchasesTable();
                                  DatabaseService().deleteSalesTable();
                                  DatabaseService().deleteSuppliersTable();
                                  DatabaseService().deleteProductsTable();

                                  DatabaseService().createProductsTable();
                                  DatabaseService().createSuppliersTable();
                                  DatabaseService().createSalesTable();
                                  DatabaseService().createPurchasesTable();

                                  if (mounted) {
                                    showCustomSnackBar(
                                      context,
                                      "Tüm veriler sıfırlandı.",
                                      YMColors().white,
                                      YMColors().blue,
                                    );
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    showCustomSnackBar(
                                      context,
                                      "Bir hata oluştu: $e",
                                      YMColors().white,
                                      YMColors().red,
                                    );
                                  }
                                }
                              }
                            },
                            bgColor: YMColors().red,
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
