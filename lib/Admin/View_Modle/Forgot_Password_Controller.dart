




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{


  final EmailController = TextEditingController().obs;
  RxBool loading = false.obs;

  SetLoading(bool value) {
    loading.value = value;
    print(loading.value);

  }



  void ForgotPasword ()async {


    SetLoading(true);
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: EmailController.value.text
    ).then((value) => {
      Get.back(),
   SetLoading(false),
    Get.snackbar("Send", "We have sent you email to recover password, please check email." )
    }).onError((error, stackTrace) => {
    SetLoading(false),
    Get.snackbar('Exception', error.toString()),
    });

  }



}