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
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 3,
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
                            bgColor: YMColors().red,
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
                            bgColor: YMColors().red,
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
