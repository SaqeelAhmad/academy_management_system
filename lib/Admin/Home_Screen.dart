
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utiles/Component/AppBar_Component.dart';
import '../Utiles/Component/Home_Button.dart';
import '../Utiles/Component/Round_Button.dart';
import '../Utiles/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;

    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(
              Title: 'Home',
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RoundButton(
                    title: 'Program Management',
                    onPrass: () {
                      Get.toNamed("/ProgramScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Time Slot Management',
                    onPrass: () {
                      Get.toNamed("/TimeSlotScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Course Management',
                    onPrass: () {
                      Get.toNamed("/CourseScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Teacher Management',
                    onPrass: () {
                      Get.toNamed("/TeacherScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Student Management',
                    onPrass: () {
                      Get.toNamed("/StudentScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Fee Management',
                    onPrass: () {
                      Get.toNamed("/FeeScreen");
                    },
                    color: AppColors.ButtonColor,
                  ),
                  RoundButton(
                    title: 'Payment_out(salary)',
                    onPrass: () {
                      Get.toNamed("/PaymentOutScreen", arguments: []);
                    },
                    color: AppColors.ButtonColor,
                  ),
                  Container()
                ],
              ),
            ),
                      ],
        ),
      ),
    );
  }
}
