



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Admin/Admin_Login.dart';
import 'Admin/Home_Screen.dart';
import 'Utiles/color.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance.currentUser;

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _checkRole();
  }

  Future<void> _checkRole() async {

if (auth != null){
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())));
}else{
  Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminLogin())));
}

  }
  @override
  Widget build(BuildContext context) {
    final height= Get.height * 1 ;
    final width = Get.width * 1;
    return Scaffold(
      body: Container(
        height: height * 1,
        width:  width *1,
        color:  AppColors.kPrimaryColor,
        child: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: height*.08,),
            // Center(child: Text("Academy\n Management\n System",textAlign: TextAlign.center,
            // style:  Theme.of(context).textTheme.subtitle1!.copyWith(
            //   fontSize: 32
            // ),)),
            Image.asset('assets/Images/ACADEMY.png'),

          ],
        ),),
      ),
    );
  }
}
