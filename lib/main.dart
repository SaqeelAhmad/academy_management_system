
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';







import 'Admin/Admin_Login.dart';
import 'Admin/Course_Management/Add_Course_Screen.dart';
import 'Admin/Course_Management/Course_Screen.dart';
import 'Admin/Fee_Management/Fess_Screen.dart';
import 'Admin/Fee_Management/Search_Student.dart';

import 'Admin/Forgot_Password_Screen.dart';
import 'Admin/Home_Screen.dart';
import 'Admin/Payment_Out_Management/Payment_Out_Screen.dart';
import 'Admin/Payment_Out_Management/Search_Teacher.dart';


import 'Admin/Program_Management/Add_Program_Screen.dart';
import 'Admin/Program_Management/Program_Screen.dart';
import 'Admin/Signup_Screen.dart';

import 'Admin/Student_Management/Add_Student_Screen.dart';
import 'Admin/Student_Management/Student_Screen.dart';
import 'Admin/Teacher_Management/Add_Teacher_Screen.dart';
import 'Admin/Teacher_Management/Teacher_Screen.dart';
import 'Admin/Time_Slot_Management/Add_Time_Screen.dart';
import 'Admin/Time_Slot_Management/Time_Slot_Screen.dart';
import 'Admin/View_Modle/User_Model.dart';
import 'Splash_Screen.dart';
import 'Utiles/Component/Profile_Screen.dart';




import 'Utiles/color.dart';
import 'Utiles/fonts.dart';
import 'firebase_options.dart';



void main() async {






  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform

  );



  runApp(const MyApp());
 // FlutterNativeSplash.remove();
}










class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Academy Management System',

      theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         // useMaterial3: true,
          primarySwatch: AppColors.primaryMaterialColor,
          // scaffoldBackgroundColor: Colors.blue,//AppColors.whiteColor,
          appBarTheme: const AppBarTheme(
            // color: AppColors.whiteColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontSize: 22,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 40,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline2: TextStyle(
                fontSize: 32,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline3: TextStyle(
                fontSize: 28,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.9),
            headline4: TextStyle(
                fontSize: 24,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline5: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline6: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText1: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText2: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.sfProDisplayRegular,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w400,
                height: 1.6),
            caption: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                height: 2.2),
          )),
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/TeacherScreen', page: () => const TeacherScreen()),
        GetPage(
            name: "/AddTeacherScreen", page: () => const AddTeacherScreen()),
        GetPage(name: "/HomeScreen", page: () => const HomeScreen()),
        GetPage(name: '/AdminLogin', page: () => const AdminLogin()),
        GetPage(name: "/SplashScreen", page: () => const SplashScreen()),
        GetPage(name: "/ProgramScreen",
          page: () => const ProgramScreen(),
        ),
        GetPage(
            name: "/AddProgramScreen", page: () => const AddProgramScreen()),
        GetPage(name: "/TimeSlotScreen", page: () => const TimeSlotScreen()),
        GetPage(name: "/AddTimeSlotScreen", page: () => const AddTimeScreen()),
        GetPage(name: "/CourseScreen", page: () => const CourseScreen()),
        GetPage(name: "/AddCourseScreen", page: () => const AddCourseScreen()),
        GetPage(name: '/StudentScreen', page: () => const StudentScreen()),
        GetPage(name: "/AddStudentScreen", page: () => const AddStudentScreen()),
        GetPage(name: "/FeeScreen", page: () => const FeeSCreen()),
       // GetPage(name: "/AddFeeScreen", page: () => const AddFeeScreen()),
        GetPage(name: "/PaymentOutScreen", page: () => const PaymentOutScreen()),
       // GetPage(name: '/AddPaymentScreen', page: () => const AddPaymentScreen()),
        GetPage(name: '/ForgotPassword', page: ()=> const ForgotPasswordScreen()),
        GetPage(name: "/Signup", page:()=> const SignupScreen()),
        GetPage(name: "/Profile", page:()=> const ProfileScreen()),
        GetPage(name: "/SStudent", page:()=> const SearchStudent()),
        GetPage(name: "/STeacher", page: ()=> const SearchTeacher()),
      ],
    );
  }
}
