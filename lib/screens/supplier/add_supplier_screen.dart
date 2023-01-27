import 'package:flutter/material.dart';

import '../../backend/classes.dart';
import '../../backend/methods.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_top_bar.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_button.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Tedarikçi Ekle',
            leftButtonText: "Geri",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/list_suppliers');
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "İsim",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Telefon",
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
                                          child: CustomTextFormField(
                                            height: 50,
                                            controller: phoneController,
                                            action: TextInputAction.next,
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
                                            "Adres",
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
                                          child: CustomTextFormField(
                                            height: 50,
                                            controller: addressController,
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
                                child: CustomButton(
                                  text: "Temizle",
                                  onPressed: () {
                                    nameController.clear();
                                    phoneController.clear();
                                    addressController.clear();
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
                                      DatabaseService().insertSupplier(
                                        {
                                          Supplier().id: null,
                                          Supplier().name: nameController.text,
                                          Supplier().phone:
                                              (phoneController.text.isEmpty)
                                                  ? null
                                                  : phoneController.text,
                                          Supplier().address:
                                              (addressController.text.isEmpty)
                                                  ? null
                                                  : addressController.text,
                                        },
                                      );
                                      showCustomSnackBar(
                                        context,
                                        "Yeni tedarikçi eklendi.",
                                        YMColors().white,
                                        YMColors().blue,
                                      );
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
