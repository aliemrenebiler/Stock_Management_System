import 'package:flutter/material.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_pop_up.dart';
import '../../widgets/custom_snack_bar.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    nameController.text = editedItem[Category.name["database"]] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Kategori Düzenle',
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
                                        action: TextInputAction.next,
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
                                  text: "Sil",
                                  onPressed: () {
                                    showCustomPopUp(
                                      context,
                                      SizedBox(
                                        width: YMSizes().maxWidth,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(5),
                                              height: 50,
                                              child: Text(
                                                "Bu kategori ve ona ait olan tüm ürünler silinecek.",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: YMColors().black,
                                                  fontSize:
                                                      YMSizes().fontSizeSmall,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CustomButton(
                                                      text: "İptal Et",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      bgColor: YMColors().grey,
                                                      textColor:
                                                          YMColors().white,
                                                      width: double.infinity,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CustomButton(
                                                      text: "Sil",
                                                      onPressed: () {
                                                        DatabaseService()
                                                            .deleteCategory(
                                                                editedItem[Category
                                                                        .id[
                                                                    "database"]]);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                routeStack
                                                                    .removeLast());
                                                      },
                                                      bgColor: YMColors().red,
                                                      textColor:
                                                          YMColors().white,
                                                      width: double.infinity,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  bgColor: YMColors().red,
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
                                      DatabaseService().updateCategory(
                                        {
                                          Category.id["database"]: editedItem[
                                              Category.id["database"]],
                                          Category.name["database"]:
                                              (nameController.text.isEmpty)
                                                  ? null
                                                  : nameController.text,
                                        },
                                      );
                                      showCustomSnackBar(
                                        context,
                                        "Tedarikçi güncellendi.",
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
