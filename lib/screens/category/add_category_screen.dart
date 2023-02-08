import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_top_bar.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Kategori Ekle',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, routeStack.removeLast());
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "İsim",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: YMSizes().fontSizeMedium,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomTextFormField(
                                        height: 50,
                                        hintText: "(Zorunlu)",
                                        controller: nameController,
                                      ),
                                    ),
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
                                child: CustomButton(
                                  text: "Temizle",
                                  onPressed: () {
                                    nameController.clear();
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
                                child: CustomButton(
                                  text: "Kaydet",
                                  onPressed: () {
                                    if (nameController.text.isEmpty) {
                                      showCustomSnackBar(
                                        context,
                                        "Lütfen zorunlu alanları doldurunuz.",
                                        YMColors().white,
                                        YMColors().red,
                                      );
                                    } else {
                                      DatabaseService().insertCategory(
                                        {
                                          Category().id: null,
                                          Category().name: nameController.text,
                                        },
                                      );
                                      showCustomSnackBar(
                                        context,
                                        "Yeni kategori eklendi.",
                                        YMColors().white,
                                        YMColors().blue,
                                      );
                                      Navigator.pushReplacementNamed(
                                          context, routeStack.removeLast());
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
