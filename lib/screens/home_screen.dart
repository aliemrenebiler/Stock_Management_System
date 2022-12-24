import 'package:flutter/material.dart';
import 'package:yildiz_motor_v2/backend/theme.dart';
import 'package:yildiz_motor_v2/widgets/menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 300, right: 300, top: 150, bottom: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuButton(
                  text: "text",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
                const SizedBox(
                  height: 25,
                ),
                MenuButton(
                  text: "text",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
                const SizedBox(
                  height: 25,
                ),
                MenuButton(
                  text: "text",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
                const SizedBox(
                  height: 25,
                ),
                MenuButton(
                  text: "text",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
                const SizedBox(
                  height: 25,
                ),
                MenuButton(
                  text: "text",
                  onPressed: () {},
                  bgColor: YMColors().darkBlue,
                  textColor: YMColors().white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
