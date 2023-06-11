



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Course_Management/Teacher_Name_Out.dart';
import 'Time_Slot_Screen.dart';

class AddTimeController extends GetxController{
  bool Visibility = true;
  final Uid= FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid).child("Time");

  late String  selectedProgram  ;
  String Program = "";
  List<String> ProgramList = ['Math', 'Comp','Eng',"Other"];
  Map<String, List<String>> CourseMap = {
    'Math': ['Calculus', 'Algebra', 'Geometry','Differential Equation','Numerical Analysis'],
    'Comp': ['Fundamental Programming', 'Compiler construction', 'Operating system','Visual programming'],
    'Eng': ['Grammar', 'English Comprehension', 'Communication Skill','Pragmatics','Introduction to statistic'],
    'Other':[],
  };
  String? selectedCourse ;
  late String Course ;





  late final TeacherController = TextEditingController().obs;


  RxBool Loading = false.obs;

  void AddNewTime (context, String TimeStart, EndTime) async {

try{


  Loading.value= true;
  String Id = DateTime.now().microsecondsSinceEpoch.toString();
    data.child(Id.toString()).set({
      'Teacher': TeacherController.value.text.toString(),
      'Program': selectedProgram!.toString(),
      'Course': selectedCourse!.toString(),//SelectProgram,
      'EndTime': EndTime,
      'StartTime': TimeStart,
      'Id': Id.toString(),
      'Uid': Uid,


    }).then((value) => {
    Loading.value = false,
    Get.snackbar('Successful', "Yor add new time of class."),
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> TimeSlotScreen())),
      TeacherController.close(),
      selectedProgram = "",selectedCourse="",
  }).onError((error, stackTrace) => {
    Loading.value = false,
    Get.snackbar('Exception', error.toString()),

  });




}catch(error){
  Loading.value = false;
    Get.snackbar('Exception', error.toString());
}



  }

  var selectedTimeStart = TimeOfDay.now().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  chooseTime( ) async {
    TimeOfDay? pickedTime = await showTimePicker(

      context: Get.context!,
      initialTime: selectedTimeStart.value,
      builder: (context, child) {
        return Theme(data: ThemeData.light(),
            child: child!);
      },
      initialEntryMode: TimePickerEntryMode.input,

      helpText: 'Select Departure Time',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorInvalidText: 'Provide valid time',
      hourLabelText: 'Select Hour',
      minuteLabelText: 'Select Minute',
    );
    if (pickedTime != null && pickedTime != selectedTimeStart.value) {
      selectedTimeStart.value = pickedTime;
    }
  }
  var selectedTimeEnd = TimeOfDay.now().obs;

  @override
  void onInitEmd() {
    super.onInit();
  }

  @override
  void onReadyEnd() {
    super.onReady();
  }

  @override
  void onCloseEnd() {}
  chooseTimeEnd() async {
    TimeOfDay? pickedTime = await showTimePicker(

      context: Get.context!,
      initialTime: selectedTimeEnd.value,
      builder: (context, child) {
        return Theme(data: ThemeData.light(),
            child: child!);
      },
      initialEntryMode: TimePickerEntryMode.input,

      helpText: 'Select Departure Time',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorInvalidText: 'Provide valid time',
      hourLabelText: 'Select Hour',
      minuteLabelText: 'Select Minute',
    );
    if (pickedTime != null && pickedTime != selectedTimeEnd.value) {
      selectedTimeEnd.value = pickedTime;
    }
  }




}