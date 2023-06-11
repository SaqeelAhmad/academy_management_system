




import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


import '../Home_Screen.dart';




class AdminLoginController extends GetxController {

  final EmailController = TextEditingController().obs;
  final PasswordController = TextEditingController().obs;

  final auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  // String Email = "admin@gmail.com";
  // String Password = "123456";


  Future<void> Login(BuildContext context,) async {



    try{
      loading.value = true;
    //   if(EmailController.value.text.toString() == Email && PasswordController.value.text.toString() == Password ){
    //     loading.value = false;
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    // Get.snackbar("your account is Login",EmailController.value.text );
    //
    //   }
    //
    //   else if (EmailController.value.text.toString() != Email ){
    //     loading.value = false ;
    //     Get.snackbar('Exception', "User Email is wrong.");
    //     PasswordController.value.clear();
    //     EmailController.value.clear();
    //
    //    }
    //    else if(EmailController.value.text.toString() == Email && PasswordController.value.text.toString() != Password){
    //     loading.value = false ;
    //     Get.snackbar('Exception', "User password is wrong.");
    //     PasswordController.value.clear();
    //
    //   }else{
    //     loading.value = false ;
    //     Get.snackbar('Exception', "User Email and password is wrong.");
    //     PasswordController.value.clear();
    //     EmailController.value.clear();
    //   }
      await auth
          .signInWithEmailAndPassword(email: EmailController.value.text, password: PasswordController.value.text).then((value) => {
        loading.value = false,
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen())),
        Get.snackbar("your account is Login",EmailController.value.text ),
      PasswordController.value.clear(),
              EmailController.value.clear(),

      }).onError((error, stackTrace) async => {
        PasswordController.value.clear(),
        EmailController.value.clear(),
        loading.value = false,
        Get.snackbar('Exception', error.toString()),

      });

    }catch (error){
      loading.value = false ;
      Get.snackbar('Exception', error.toString());

    }


  }
}

