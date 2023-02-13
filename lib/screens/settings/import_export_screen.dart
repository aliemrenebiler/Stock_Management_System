import 'package:flutter/material.dart';

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
                            onPressed: () =>
                                ExcelService().exportExcel(excelExportName),
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
