


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'Teacher_Screen.dart';


class AddTeacherController extends GetxController{
  final Uid = FirebaseAuth.instance.currentUser!.uid;

  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Teacher");
  final NameControlle = TextEditingController().obs;
  final FatherNameController = TextEditingController().obs;
  final AddressController = TextEditingController().obs;
  final EmailController = TextEditingController().obs;
  final ProgramController = TextEditingController().obs;
  final courseController = TextEditingController().obs;

  final SalaryperMonthController = TextEditingController().obs;
  final NicController = TextEditingController().obs;
  final PhoneNoController = TextEditingController().obs;

  final CourseCommandCotroller = TextEditingController().obs;

  final List<String> QualificationItems = [
    'Fa', 'Fac', 'Ba', 'BS','Ma','Ms','Phd'

  ];
  String? SelectQualification  ;
  String? selectedValueQualification ;

 String? selectedProgram ;
  String Program = "";
  List<String> ProgramList = ['Math', 'Comp','Eng',"Other"];
  Map<String, List<String>> CourseMap = {
    'Math': ['Calculus', 'Algebra', 'Geometry','Differential Equation','Numerical Analysis'],
    'Comp': ['Fundamental Programming', 'Compiler construction', 'Operating system','Visual programming'],
    'Eng': ['Grammar', 'English Comprehension', 'Communication Skill','Pragmatics','Introduction to statistic'],
    'Other': [],
  };
  String? selectedCourse ;
   late String Course ="" ;



  RxBool Loading = false.obs;

  void AddNewTeacher(context, String JoiningDate)async{


    try{
      Loading.value=true;
      String Id = DateTime.now().microsecondsSinceEpoch.toString();
  data.child(Id.toString()).set({

    'Name': NameControlle.value.text.toString(),
    'FName': FatherNameController.value.text,
     'Address' : AddressController.value.text,
    'Email' : EmailController.value.text,
     'CourseCommand': Course,
     'Qualification' : SelectQualification.toString(),
     'Mobile': PhoneNoController.value.text,
    'JoiningDate': JoiningDate,
    'Cnic': NicController.value.text,
    'Program': Program.toString(),
    'Salary': SalaryperMonthController.value.text,
    "Uid": Uid,
    "Id": Id.toString(),


  }).then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=> TeacherScreen())),
      Loading.value= false,
      Get.snackbar('Successful',"You are Teacher data successful add on database."),

      NameControlle.value.clear(),
    FatherNameController.value.clear(),
    AddressController.value.clear(),
    EmailController.value.clear(),
    PhoneNoController.value.clear(),
    SalaryperMonthController.value.clear(),
      NicController.value.clear(),
      Course = "",
      Program = "",

    }).onError((error, stackTrace) => {
    Loading.value= false,
        Get.snackbar('Exception', error.toString()),
    });


    }catch(error){
      Loading.value= false;
    Get.snackbar('Exception', error.toString());
    }

  }





}