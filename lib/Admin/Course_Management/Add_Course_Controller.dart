


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


import 'Course_Screen.dart';


class AddCourseController extends GetxController{
  bool Visibility = true;
  bool VisibilityProgram = true;
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(
      FirebaseAuth.instance.currentUser!.uid.toString()
  ).child("Course");

  final ProgramController = TextEditingController().obs;
  final courseController = TextEditingController().obs;
  final TeacherController = TextEditingController().obs;
  final CourseDurationController = TextEditingController().obs;
  String TeacherName= "";

  final MonthlyFeeController = TextEditingController().obs;
  String ? SelectedLevels;
  String Levels="";
  List<String> LevelsList = [ "6","7","8","9","10"];

  String ? selectedProgram ;
  String Program = "";
  List<String> ProgramList = ['Math', 'Comp','Eng', 'Other'];
  Map<String, List<String>> CourseMap = {
    'Math': ['Calculus', 'Algebra', 'Geometry','Differential Equation','Numerical Analysis'],
    'Comp': ['Fundamental Programming', 'Compiler construction', 'Operating system','Visual programming'],
    'Eng': ['Grammar', 'English Comprehension', 'Communication Skill','Pragmatics','Introduction to statistic'],
    'Other':['Other'],
  };
  String? selectedCourse ;
   String Course ="" ;

  RxBool Loading = false.obs;

  void NewCourseAdd (context)async{
Loading.value = true;
String Id = DateTime.now().microsecondsSinceEpoch.toString();
    data.child(Id.toString()).set({
      'CourseName': Course.toString(),
      'CourseDuration': CourseDurationController.value.text,
      'Program': Program.toString(),
      //'Levels': Levels.toString(),
      'MonthlyFee': MonthlyFeeController.value.text.toString(),
      //'Teacher': TeacherName,
      'Id':Id.toString(),
      "Uid": Uid,
    }).
    then((value) => {
      Loading.value= false,
      Get.snackbar('Successful',"You are Course successful add on database. "),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CourseScreen())),

    }).onError((error, stackTrace) => {
      Loading.value= false,

      Get.snackbar('Exception',error.toString()),


    });
  }







}