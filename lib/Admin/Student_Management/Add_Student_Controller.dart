



import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'Student_Screen.dart';



class AddStudentController extends GetxController {
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Student");

  final NameController = TextEditingController().obs;
  final FatherNameController = TextEditingController().obs;
  final RegNoController = TextEditingController().obs;

  final AddressController = TextEditingController().obs;
  final PhoneNoController = TextEditingController().obs;
  final GuardianPhoneNOController = TextEditingController().obs;
  final ProgramController = TextEditingController().obs;
  final FeesController = TextEditingController().obs;
  final CourseController = TextEditingController().obs;


  RxString gender = 'male'.obs;
  RxString Shife = 'morning'.obs;
  RxBool Loading = false.obs;

  String? selectedProgram ;
  String Program = "";
  List<String> ProgramList = ['Math', 'Comp','Eng','Other'];
  Map<String, List<String>> CourseMap = {
    'Math': ['Calculus', 'Algebra', 'Geometry','Differential Equation','Numerical Analysis'],
    'Comp': ['Fundamental Programming', 'Compiler construction', 'Operating system','Visual programming'],
    'Eng': ['Grammar', 'English Comprehension', 'Communication Skill','Pragmatics','Introduction to statistic'],
    'Other':['Other']
  };
  String? selectedCourse ;
   String Course = "" ;
   String Rollon="";

  void AddNewStudent (context,
      String dateofBirth,)async{

      Loading.value =true;
      String Id= DateTime.now().microsecondsSinceEpoch.toString();
      data.child(Id.toString()).set({
        'Name': NameController.value.text,
        'FName':FatherNameController.value.text ,
        'RegNo': Rollon,
        'DateOfBirth': dateofBirth,
        'Gender': gender.value.toString() ,
        'Address': AddressController.value.text,
        'Mobile': PhoneNoController.value.text,
        'GuardianMobile': GuardianPhoneNOController.value.text,
        'Program': selectedProgram ,
        'Course': Course,
        'Shift': Shife.value.toString(),
        'Fess': FeesController.value.text,
        "Id": Id.toString(),
        "Uid": Uid,
      }).then((value) => {
        FatherNameController.close(),
        RegNoController.close(),
        dateofBirth = "", gender.value = "",
        AddressController.close(),
        PhoneNoController.close(),
        GuardianPhoneNOController.close(),
        Program = "", Course= "",Shife.value= "",FeesController.close(),
      Loading.value= false,
          Get.snackbar('Successful',"You are student data successful add on database."),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentScreen())),

      }).onError((error, stackTrace) => {
      Loading.value= false,
          Get.snackbar("Exception", error.toString()),

      });


  }

  void genderchake(String value) {
    gender.value = value;
  }

  void ShifeChake(String value) {
    Shife.value = value;
  }
}
