



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Payment_Out_Screen.dart';

class  AddPaymentController extends GetxController{
  String  Uid = FirebaseAuth.instance.currentUser!.uid.toString();
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Payment");

  final List<String> MonthItems = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November" , "December"
  ];

  String? SelectMonth ;
  RxBool Loading = false.obs;


  void AddPayment(context, String Name, String FName, String Mobile,
      String CNIC, String Salary,
      ){

    Loading.value= true;

String  Id = DateTime.now().microsecondsSinceEpoch.toString();
    data.child(Id.toString()).set({
      "Name": Name, "FName": FName,
      "Mobile": Mobile,
      "CNIC": CNIC,
      "Month": SelectMonth.toString(),
      "id": Id.toString(),
      "salary": Salary,
      "Uid": Uid,

    }).then((value) => {
      Loading.value= false,
      Get.snackbar('Successful',"You are Payment successful add on database. "),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentOutScreen())),
      SelectMonth= "",

    }).onError((error, stackTrace) => {
       Loading.value= false,

      Get.snackbar('Exception',error.toString()),
      SelectMonth = "",


    });
  }









}