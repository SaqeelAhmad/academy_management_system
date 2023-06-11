



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Fess_Screen.dart';

class AddFessController extends GetxController{
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Fess");


  RxBool Loading = false.obs;
  final List<String> MonthItems = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November" , "December"
  ];

  String? SelectMonth ;




  void FessAdd(context,String Name, String FName, String RegNo , String Fess, ){
    String Id = DateTime.now().microsecondsSinceEpoch.toString();

      data.child(Id.toString()).set({
        "Name":Name,
        "FName": FName,
        "RegNo": RegNo,
        "Fess": Fess,
        "Month": SelectMonth.toString(),
        "Id": Id.toString() ,
        "Uid": Uid.toString(),

      }).then((value) => {
         Loading.value= false,
        Get.snackbar('Successful',"You are Fess successful add on database. "),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FeeSCreen())),

      }).onError((error, stackTrace) => {
         Loading.value= false,

        Get.snackbar('Exception',error.toString()),


      });




  }





}