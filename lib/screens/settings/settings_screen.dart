import 'package:flutter/material.dart';

import '../../backend/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_top_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YMColors().white,
      body: Column(
        children: [
          CustomTopBar(
            title: 'Ayarlar',
            leftButtonText: "Ana Sayfa",
            leftButtonAction: () {
              Navigator.pushReplacementNamed(context, '/home');
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
                            text: "Şifre Değiştir",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/change_password');
                            },
                            bgColor: YMColors().grey,
                            textColor: YMColors().white,
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomButton(
                            text: "Verileri Sıfırla",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/clear_data");
                            },
                            bgColor: YMColors().grey,
                            textColor: YMColors().white,
                            width: double.infinity,
                            height: 50,
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
