import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/Component/Round_Button.dart';
import '../../Utiles/Utils.dart';
import '../../Utiles/color.dart';
import 'Add_Course_Controller.dart';
import 'Teacher_Name_Out.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final CourseNameFocusNode = FocusNode();

  final CourseDurationFocusNode = FocusNode();

  final ProgramFocusNode = FocusNode();
  final TeacherFocusNode = FocusNode();

  final MonthlyFeefocusNode = FocusNode();

  final LevelsFocusNode = FocusNode();
  final NullFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final AddCourseController CourseController = Get.put(AddCourseController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //CourseNameController.dispose();
    CourseNameFocusNode.dispose();
    //CourseDurationController.dispose();
    TeacherFocusNode.dispose();
    CourseDurationFocusNode.dispose();
    // ProgramController.dispose();
    ProgramFocusNode.dispose();
    // MonthlyFeeController.dispose();
    MonthlyFeefocusNode.dispose();
    // LevelsController.dispose();
    LevelsFocusNode.dispose();
    NullFocusNode.dispose();
  }


  String TeacherNmae = "";

  bool Suggestions = false;
  bool visibility  = true;
  bool visibilityProgram = true;
  final databaseReference = FirebaseDatabase.instance.ref("Users")
      .child(FirebaseAuth.instance.currentUser!.uid);
  List<Item> items = [];
  List<Item> itemsProgram=[];
  @override
  void initState() {
    super.initState();
    fetchDataTeacher();
    fetchDataProgram();

  }

  void fetchDataTeacher() {
    databaseReference.child('Teacher').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

        items.add(Item(Id: key, Name: value["Name"].toString(), ));

      });
      setState(() {});

    });
  }
  void fetchDataProgram(){
    databaseReference.child('Program').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

        itemsProgram.add(Item(Id: key, Name: value["Program"].toString(), ));

      });
      setState(() {});

    });

  }




  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;
    CourseController.ProgramController.value == CourseController.Program;
    CourseController.courseController.value == CourseController.Course;



    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(Title: 'Register Course'),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        // ListTile(
                        //   title: Text('Teacher'),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(color: AppColors.whiteColor),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 10, right: 20),
                        //     child: DropdownButtonFormField(
                        //       dropdownColor: AppColors.kPrimaryColor,
                        //       borderRadius: BorderRadius.circular(20),
                        //       // value: TimeController.selectedProgram,
                        //       items: items.map((Item item) {
                        //         return DropdownMenuItem<Item>(
                        //           value: item,
                        //           child: Text(item.Name),
                        //         );
                        //       }).toList(),
                        //
                        //       onChanged: (value) {
                        //         setState(() {
                        //             CourseController.TeacherName= value?.Name as String ;
                        //
                        //         });
                        //       },
                        //      // focusNode: CourseFocusNode,
                        //       decoration: const InputDecoration(
                        //         // labelText: 'Select a choice',
                        //         hintText: 'Select Teacher  ',
                        //         border: InputBorder.none,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        ListTile(
                          title: Text('Program'),
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
                             // value: CourseController.selectedProgram,ll
                              items:
                              itemsProgram.map((Item item) {
                                return DropdownMenuItem<Item>(
                                  value: item,
                                  child: Text(item.Name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  CourseController.Program = value?.Name as String;
                                  // CourseController.selectedCourse = null;
                                  // CourseController.Program = value.toString();
                                  // visibilityProgram = true;
                                });
                              },
                              focusNode: ProgramFocusNode,
                              decoration: const InputDecoration(
                                // labelText: 'Select a choice',
                                hintText: 'Select a Program',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),SizedBox(height: 15,),

                        // if (CourseController.Program == "Other")
                        //   Visibility(child: InputTextField(
                        //     Color: Colors.black,
                        //     myController: CourseController.ProgramController.value,
                        //     focusNode: ProgramFocusNode,
                        //     onFiledSubmittedValue: (Value) {
                        //       // Utils.fieldFocus(
                        //       // context, NameFocusNode, FatherNameFocusNode);
                        //     },
                        //     onValidator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Please enter your other Program.';
                        //       } else if (value.contains('@')) {
                        //         return 'Please don\'t use the @ char.';
                        //       }
                        //       return null;
                        //     },
                        //     KeyBoardType: TextInputType.name,
                        //     enable: true,
                        //     hint: 'Other Progrem...',
                        //     obscureText: false,
                        //     onChanged: (value){
                        //       CourseController.Program = value.toString();
                        //     },
                        //   ),
                        //     visible: visibility,
                        //   ),
                        ListTile(
                          title: Text('Course Name'),
                        ),
                       // if (CourseController.Program == "Other")
                          Visibility(child: InputTextField(
                            Color: Colors.black,
                            myController: CourseController.courseController.value,
                            focusNode: CourseNameFocusNode,
                            onFiledSubmittedValue: (Value) {
                              // Utils.fieldFocus(
                              // context, NameFocusNode, FatherNameFocusNode);
                            },
                            onValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your other Program.';
                              } else if (value.contains('@')) {
                                return 'Please don\'t use the @ char.';
                              }
                              return null;
                            },
                            KeyBoardType: TextInputType.name,
                            enable: true,
                            hint: 'Course Name...',
                            obscureText: false,
                            onChanged: (value){
                              CourseController.Course = value.toString();
                            },
                          ),
                            visible: visibility,
                          ),
                   //   else
                   //      Container(
                   //        decoration: BoxDecoration(
                   //          borderRadius: BorderRadius.circular(15),
                   //          border: Border.all(color: AppColors.whiteColor),
                   //        ),
                   //        child: Padding(
                   //          padding: const EdgeInsets.only(left: 10, right: 20),
                   //          child: DropdownButtonFormField<String>(
                   //            dropdownColor: AppColors.kPrimaryColor,
                   //            borderRadius: BorderRadius.circular(20),
                   //            iconDisabledColor: AppColors.kTextColor,
                   //            value: CourseController.selectedCourse,
                   //            items: CourseController
                   //                .CourseMap[CourseController.selectedProgram]
                   //                ?.map((String item) {
                   //              return DropdownMenuItem<String>(
                   //                value: item,
                   //                child: Text(item),
                   //              );
                   //            })?.toList(),
                   //            onChanged: (value) {
                   //              setState(() {
                   //                CourseController.selectedCourse =
                   //                    value.toString();
                   //                CourseController.Course = value.toString();
                   //              });
                   //            },
                   //            focusNode: CourseNameFocusNode,
                   //            decoration: const InputDecoration(
                   //              // labelText: 'Select a choice',
                   //              hintText: 'Select a Course',
                   //              border: InputBorder.none,
                   //            ),
                   //          ),
                   //        ),
                   //      ),
                        ListTile(
                          title: Text('Course Duration'),
                        ),
                        InputTextField(
                          Color: Colors.black,
                          myController:
                              CourseController.CourseDurationController.value,
                          focusNode: CourseDurationFocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(context, CourseDurationFocusNode,
                                ProgramFocusNode);
                          },
                          onValidator: (value) {
                            if (value.isEmpty) {
                              return 'Course Duration  is required';
                            }

                            return null;
                          },
                          KeyBoardType: TextInputType.name,
                          enable: true,
                          hint: 'Course Duration....',
                          obscureText: false,
                        ),

                        ListTile(
                          title: Text('Monthly Fee'),
                        ),
                        InputTextField(
                          Color: Colors.black,
                          myController:
                              CourseController.MonthlyFeeController.value,
                          focusNode: MonthlyFeefocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(
                                context, MonthlyFeefocusNode, LevelsFocusNode);
                          },
                          onValidator: (value) {
                            if (value.isEmpty) {
                              return 'Monthly Fee is required';
                            }

                            return null;
                          },
                          KeyBoardType: TextInputType.number,
                          enable: true,
                          hint: 'Monthly Fee...',
                          obscureText: false,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 20),
                          child: RoundButton(
                            title: "Course Register",
                            onPrass: () {
                              if (_formKey.currentState!.validate()) {
                                CourseController.NewCourseAdd(context);
                              }
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
            ),
            HomeButton(),
          ],
        ),
      ),
    );
  }
}
