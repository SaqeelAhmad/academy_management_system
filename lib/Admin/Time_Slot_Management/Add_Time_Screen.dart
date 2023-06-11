

import 'package:academy_management_syste/Utiles/Component/AppBar_Component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/Component/Round_Button.dart';
import '../../Utiles/Utils.dart';
import '../../Utiles/color.dart';
import '../Course_Management/Teacher_Name_Out.dart';
import 'Add_Time_Controller.dart';

class AddTimeScreen extends StatefulWidget {
  const AddTimeScreen({Key? key}) : super(key: key);

  @override
  State<AddTimeScreen> createState() => _AddTimeScreenState();
}

class _AddTimeScreenState extends State<AddTimeScreen> {

  final AddTimeController TimeController = Get.put(AddTimeController());
  final StartTimeFocusNode = FocusNode();
  final EndTimeFocusNode = FocusNode();
  final NullFocusNode = FocusNode();
  final ProgrgramFocusNode = FocusNode();
  final TeacherFocusNode = FocusNode();
  final CourseFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    StartTimeFocusNode.dispose();
    EndTimeFocusNode.dispose();
    NullFocusNode.dispose();
  }
  bool visibility = false;
  String TeacherNmae = "";
  final databaseReference = FirebaseDatabase.instance.ref("Users").
  child(FirebaseAuth.instance.currentUser!.uid.toString()
  );
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    //fetchDataCourse();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataProgram();
   // fetchDataCourse();
  }

  List<Item> items = [];
  void fetchData() {
    databaseReference.child('Teacher').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

      items.add(Item(Id: key, Name: value["Name"].toString(), ));

      });
      setState(() {});

    });
  }



  List <Item> itemsProgram =[];
  List <Item> itemsCourse = [];
  void fetchDataProgram(){

    databaseReference.child('Program').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

        itemsProgram.add(Item(Id: key, Name: value["Program"].toString(), ));

      });
      setState(() {});

    });
  }
  void fetchDataCourse ( String Program){
    itemsCourse.clear();

    databaseReference.child('Course').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {
        // itemsCourse.clear();
        if (value?["Program"] as String  == Program) {

          itemsCourse.add(Item(Id: key, Name: value["CourseName"].toString(),));
        }
      });
      setState(() {

      });

    });

  }


  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(

          children: [
            AppBarComponent(Title: "Add New Time"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),
                      ListTile(
                        title: Text("Teacher"),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.whiteColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: DropdownButtonFormField(
                            dropdownColor: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                           // value: TimeController.selectedProgram,
                            items: items.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Text(item.Name),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() {
                                 TimeController.TeacherController.value.text = value!.Name  ;

                              });
                            },
                            focusNode: CourseFocusNode,
                            decoration: const InputDecoration(
                              // labelText: 'Select a choice',
                              hintText: 'Select Teacher  ',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),




                      ListTile(
                        title: Text("Program"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.whiteColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: DropdownButtonFormField(
                            dropdownColor: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                           // value: TimeController.selectedProgram,
                            items: itemsProgram.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Text(item.Name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                fetchDataCourse(value?.Name as String);
                                TimeController.selectedProgram = value?.Name as String;
                                // TimeController.selectedCourse = null;
                                // TimeController.Program = value.toString();

                              });
                            },
                            focusNode: CourseFocusNode,
                            decoration: const InputDecoration(
                              // labelText: 'Select a choice',
                              hintText: 'Select a Program',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Course"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.whiteColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: DropdownButtonFormField(
                            dropdownColor: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                            iconDisabledColor: AppColors.kTextColor,
                           // value: TimeController.selectedCourse,
                            items:itemsCourse.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Text(item.Name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                TimeController.selectedCourse = value?.Name as String;
                                //TimeController.Course = value.toString();
                              });
                            },
                            focusNode: CourseFocusNode,
                            decoration: const InputDecoration(
                              // labelText: 'Select a choice',
                              hintText: 'Select a Course',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Start Time'),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            TimeController.chooseTime();
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  "${TimeController.selectedTimeStart.value.hour}:${TimeController.selectedTimeStart.value.minute}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 18),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "End Time",
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            TimeController.chooseTimeEnd();
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  "${TimeController.selectedTimeEnd.value.hour}:${TimeController.selectedTimeEnd.value.minute}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 18),
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                        child: RoundButton(
                          title: "Add",
                          onPrass: () {
                            //if (_formKey.currentState!.validate()) {
                              TimeController.AddNewTime(context,"${TimeController.selectedTimeStart.value.hour}:${TimeController.selectedTimeStart.value.minute}",
                                  "${TimeController.selectedTimeEnd.value.hour}:${TimeController.selectedTimeEnd.value.minute}");


                            //}

                          },
                          color: AppColors.ButtonColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
