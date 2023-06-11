








import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Admin_Login.dart';



class SignupController extends GetxController{
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child("Users");
  final AccademyController = TextEditingController().obs;
  final MdController = TextEditingController().obs;
  final EmailController = TextEditingController().obs;
  final PasswordController = TextEditingController().obs;
  late String  Uid ;
  final Nowtime = DateTime.now().microsecondsSinceEpoch;

  RxBool Loading = false.obs;



  void Register (context){

    Loading.value = true;
    auth.createUserWithEmailAndPassword(
        email: EmailController.value.text,
        password: PasswordController.value.text ).then((value) => {
          Loading.value= true,
      Uid = value.user!.uid.toString(),
      ref.child(Uid.toString()).set({

        "Email": EmailController.value.text,
        "Academy Name": AccademyController.value.text,
        "Md Name": MdController.value.text,
        "Uid": Uid,
        "Now Time": Nowtime,
        "Profile": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
        "Logo": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
       }).then((value) => {
        Loading.value = false,
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> AdminLogin())),

    }).onError((error, stackTrace) => {
        Loading.value = false,
        Get.snackbar('Exception', error.toString())
      }),

    }).onError((error, stackTrace) =>{
      Loading.value = false,
      Get.snackbar('Exception', error.toString()),
    });
  }





}