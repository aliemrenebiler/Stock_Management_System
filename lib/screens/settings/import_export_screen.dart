import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/widgets/custom_pop_up.dart';
import 'package:yildiz_motor_v2/widgets/custom_snack_bar.dart';

import '../../backend/methods.dart';
import '../../backend/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class ImportExportScreen extends StatefulWidget {
  const ImportExportScreen({super.key});

  @override
  State<ImportExportScreen> createState() => _ImportExportScreenState();
}

class _ImportExportScreenState extends State<ImportExportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'İçe Aktar / Dışa Aktar',
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
                          child: CustomButton(
                            text: "İçe Aktar",
                            onPressed: () => ExcelService().importExcel(),
                            bgColor: YMColors().red,
                            textColor: YMColors().white,
                            height: 50,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomButton(
                            text: "Dışa Aktar",
                            onPressed: () async {
                              showCustomPopUp(
                                context,
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    "Dışa aktarılıyor...",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: YMSizes().fontSizeMedium,
                                      color: YMColors().black,
                                    ),
                                  ),
                                ),
                              );
                              bool exported =
                                  await ExcelService().exportExcel();
                              if (mounted) {
                                Navigator.pop(context);
                                if (exported) {
                                  showCustomSnackBar(
                                    context,
                                    "Tamamlandı.",
                                    YMColors().white,
                                    YMColors().blue,
                                  );
                                } else {
                                  showCustomSnackBar(
                                    context,
                                    "İşlem iptal edildi.",
                                    YMColors().white,
                                    YMColors().grey,
                                  );
                                }
                              }
                            },
                            bgColor: YMColors().blue,
                            textColor: YMColors().white,
                            height: 50,
                            width: double.infinity,
                          ),
                        ),
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
