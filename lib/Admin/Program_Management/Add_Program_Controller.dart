import 'dart:async';


import 'package:academy_management_syste/Admin/Program_Management/Program_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AddProgramController extends GetxController{
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref().child("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Program");
  final ProgramController= TextEditingController().obs;



  final List<String> ProgramItems = [
    'Math',
    'Comp',
    'Eng',
    'Other',
  ];
  String? Select  ;
  String? selectedValueProgram ;




  RxBool Loading = false.obs;

  void AddNewProgram(context)async{

    try{

      Loading.value= true;
      String Id = DateTime.now().microsecondsSinceEpoch.toString();
      data.child(Id.toString()).set({
        "Id": Id.toString(),
        "Uid": Uid,
        "Program": Select!,

      })
      .then((value) => {
        Loading.value= false,
        Get.snackbar('Successful',"You are program successful add on database. "),
        Select = "",
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProgramScreen()) ),

      }).onError((error, stackTrace) => {
        Loading.value= false,

        Get.snackbar('Exception',error.toString()),


      });



    }catch(error){
      Loading.value=false;
      Get.snackbar('Exception',error.toString());

    }
  }


  late Timer timer;
  RxBool timerRunning = false.obs;
  RxInt remainingSeconds = 30.obs;

  void startTimer() {

    timer = Timer.periodic(Duration(seconds: 1), (timer) {


      remainingSeconds.value--;

      // Check if the timer has expired
      if (remainingSeconds.value == 0) {
        stopTimer();
        // Perform some action here
        print('Timer expired!');
      }
    });
    // Set timer running state to true

    timerRunning.value = true;

  }
  void refreshTimer() {
    // Reset the remaining seconds to 2 minutes
    remainingSeconds.value = 30;
    // If the timer is currently running, restart it
    if (timerRunning.value) {
      timer.cancel();
      startTimer();
    }
    // If the timer is not running, update the state to trigger a rebuild
    else {

    }
  }

  void stopTimer() {
    // Cancel the timer
    timer.cancel();
    // Set timer running state to false

    timerRunning.value = false;

  }





}