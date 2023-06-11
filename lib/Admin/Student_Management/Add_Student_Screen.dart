



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';

import '../../Utiles/Component/Round_Button.dart';
import '../../Utiles/Utils.dart';
import '../../Utiles/color.dart';
import '../Course_Management/Teacher_Name_Out.dart';
import 'Add_Student_Controller.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final AddStudentController StudentController =
      Get.put(AddStudentController());


  final NameFocusNode = FocusNode();

  final FatherNameFocusNode = FocusNode();

  final RegNoFocusNode = FocusNode();

  final DataOfBirthFocusNode = FocusNode();
  final Null1 = FocusNode();

  final AddressFocusNode = FocusNode();

  final PhoneNoFocusNode = FocusNode();

  final GuardianPhoneNoFocusNode = FocusNode();

  final ProgramFocusNode = FocusNode();

  final CourseFocusNode = FocusNode();
  final FessFocusNode = FocusNode();
  final Null2 = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    NameFocusNode.dispose();

    FatherNameFocusNode.dispose();

    RegNoFocusNode.dispose();

    DataOfBirthFocusNode.dispose();
    Null1.dispose();

    AddressFocusNode.dispose();

    PhoneNoFocusNode.dispose();

    GuardianPhoneNoFocusNode.dispose();

    ProgramFocusNode.dispose();
    FessFocusNode. dispose();

    CourseFocusNode.dispose();
    Null2.dispose();
  }
  DateTime selectedDate = DateTime(2020);
  bool visibility = true;
  bool visibilityProgram = true;
  bool visibleCourse= false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataProgram();
    fetchDataRollNo();




  }
  final databaseReference = FirebaseDatabase.instance.ref("Users")
      .child(FirebaseAuth.instance.currentUser!.uid.toString());

  List <Item> itemsProgram =[];
  List <Item> itemsCourse = [];
  List  <Rollon> ItemsRollno = []  ;





  String? largestRollno ;




  void fetchDataRollNo(){
    databaseReference.child('Student').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

        ItemsRollno.add(Rollon( Name: value["RegNo"].toString(),  ) );

      });
      setState(() {

         largestRollno = ItemsRollno.isNotEmpty
            ? ItemsRollno.reduce((currentMax, item) =>
        int.parse(item.Name) > int.parse(currentMax.Name) ? item : currentMax).Name
            : null;

StudentController.Rollon = (int.parse(largestRollno!)+1).toString();
      });

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
  void fetchDataCourse ( String Program){
    itemsCourse.clear();

    databaseReference.child('Course').once().then(( snapshot) {

      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      values.forEach((key, value,) {

        if (value?["Program"] as String  == Program) {

          itemsCourse.add(Item(Id: key, Name: value["CourseName"].toString(),));
        }
      });
      setState(() {

      });

    });

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2020,2),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

    }
  }
  String generateRollNumber() {
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();
    String randomNum = (now.microsecond % 100).toString().padLeft(2, '0');
    return timestamp + randomNum;
  }
  @override
  Widget build(BuildContext context) {
    StudentController.ProgramController.value == StudentController.Program;
    StudentController.CourseController.value == StudentController.Course;


    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBarComponent(Title: 'Register Student'),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 10,
                      ),

                      ListTile(
                        title: Text('Name'),
                      ),
                      InputTextField(
                        Color: Colors.black,
                        myController: StudentController.NameController.value,
                        focusNode: NameFocusNode,
                        onFiledSubmittedValue: (Value) {
                          Utils.fieldFocus(
                              context, NameFocusNode, FatherNameFocusNode);
                        },
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name.';
                          } else if (value.contains('@')) {
                            return 'Please don\'t use the @ char.';
                          }
                          return null;
                        },
                        KeyBoardType: TextInputType.name,
                        enable: true,
                        hint: 'Name...',
                        obscureText: false,
                      ),
                      ListTile(
                        title: Text('Father Name'),
                      ),
                      InputTextField(
                        Color: Colors.black,
                        myController: StudentController.FatherNameController.value,
                        focusNode: FatherNameFocusNode,
                        onFiledSubmittedValue: (Value) {
                          Utils.fieldFocus(
                              context, FatherNameFocusNode, RegNoFocusNode);
                        },
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Father name.';
                          } else if (value.contains('@')) {
                            return 'Please don\'t use the @ char.';
                          }
                          return null;
                        },
                        KeyBoardType: TextInputType.name,
                        enable: true,
                        hint: 'Father Name...',
                        obscureText: false,
                      ),
                      ListTile(
                        title: Text('Roll No'),
                      ),

                   if (largestRollno != null)
                     Container(
                       height: 50,
                       width: double.infinity,
                       decoration: BoxDecoration(

                         borderRadius: BorderRadius.circular(15),
                         border: Border.all(color: AppColors.whiteColor)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                         child: Text((int.parse(largestRollno!)+1).toString(),
                             style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18),
                         ),
                       ),)
                      else
                      InputTextField(
                        Color: Colors.black,
                        myController: StudentController.RegNoController.value,
                        focusNode: RegNoFocusNode,
                        onFiledSubmittedValue: (Value) {
                          Utils.fieldFocus(
                              context, RegNoFocusNode, DataOfBirthFocusNode);
                        },
                        onValidator: (value) {
                          final pattern = r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$';

                          if (value.isEmpty) {
                            return 'Registration number is required';
                          }

                          // if (!RegExp(pattern).hasMatch(value)) {
                          //   return 'Invalid registration number';
                          // }

                          return null;
                        },
                        KeyBoardType: TextInputType.number,
                        enable: true,
                        hint: 'Roll No...',
                        obscureText: false,
                        onChanged: (value){
                          StudentController.Rollon = value;
                        },
                      ),
                      ListTile(
                        title: Text('Date of birth'),
                      ),
                      Container (
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.whiteColor),
                        ),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: ()  => _selectDate(context),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              child: Text ("${selectedDate.toLocal()}".split(' ')[0]) ,
                            )),
                      ),

                      ListTile(
                        title: Text('Gender'),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.whiteColor)),
                          child: Obx(() => Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                children: [
                                  //Text(addStudentController.gender.toString()),

                                  RadioListTile(
                                    selectedTileColor: AppColors.whiteColor,
                                    activeColor: AppColors.whiteColor,
                                    title: Text("Male"),
                                    value: "male".obs,
                                    groupValue:
                                        StudentController.gender.toString(),
                                    onChanged: (value) {
                                      StudentController
                                          .genderchake(value.toString());
                                    },
                                  ),

                                  RadioListTile(
                                    selectedTileColor: AppColors.whiteColor,
                                    activeColor: AppColors.whiteColor,
                                    title: Text("Female"),
                                    value: "female".obs,
                                    groupValue:
                                        StudentController.gender.toString(),
                                    onChanged: (value) {
                                      StudentController
                                          .genderchake(value.toString());
                                    },
                                  ),

                                  RadioListTile(
                                    selectedTileColor: AppColors.whiteColor,
                                    activeColor: AppColors.whiteColor,
                                    title: Text("Other"),
                                    value: "other",
                                    groupValue:
                                        StudentController.gender.toString(),
                                    onChanged: (value) {
                                      StudentController
                                          .genderchake(value.toString());
                                      // Controller.gender = value as RxString?;
                                    },
                                  ),
                                ],
                              ))),
                      ListTile(
                        title: Text('Address'),
                      ),
                      InputTextField(
                        Color: Colors.black,
                        myController: StudentController.AddressController.value,
                        focusNode: AddressFocusNode,
                        onFiledSubmittedValue: (Value) {
                          Utils.fieldFocus(
                              context, AddressFocusNode, PhoneNoFocusNode);
                        },
                        onValidator: (value) {
                          if (value.isEmpty) {
                            return 'Address is required';
                          }

                          return null;
                        },
                        KeyBoardType: TextInputType.name,
                        enable: true,
                        hint: 'Address...',
                        obscureText: false,
                      ),
                      ListTile(
                        title: Text('Phone No'),
                      ),
                      IntlPhoneField(
                        onSubmitted: (value) {
                          Utils.fieldFocus(context, PhoneNoFocusNode,
                              GuardianPhoneNoFocusNode);
                        },
                        focusNode: PhoneNoFocusNode,
                        controller: StudentController.PhoneNoController.value,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: AppColors.whiteColor, width: 2),
                          ),
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      ListTile(
                        title: Text('Guardian Phone NO'),
                      ),
                      IntlPhoneField(
                        onSubmitted: (value) {
                          Utils.fieldFocus(context, GuardianPhoneNoFocusNode,
                              ProgramFocusNode);
                        },
                        focusNode: GuardianPhoneNoFocusNode,
                        controller: StudentController.GuardianPhoneNOController.value,
                        decoration: InputDecoration(
                          labelText: 'Guardian Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: AppColors.whiteColor, width: 2),
                          ),
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
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
                           // value: StudentController.selectedProgram,
                            items: itemsProgram.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Text(item.Name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                fetchDataCourse(value?.Name as String);

                                StudentController.selectedProgram = value?.Name as String ;


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

                      if (StudentController.Program == "Other")
                        Visibility(child: InputTextField(
                          Color: Colors.black,
                          myController: StudentController.ProgramController.value,
                          focusNode: ProgramFocusNode,
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
                          hint: 'Other Progrem...',
                          obscureText: false,
                          onChanged: (value){
                            StudentController.Program = value.toString();
                          },
                        ),
                          visible: visibility,
                        ),
                      const ListTile(title: Text('Course')),
                      if (StudentController.Program == "Other")
                        Visibility(child:
                         Stack(
                           alignment: Alignment.topRight,
                           children: [
                             InputTextField(
                              Color: Colors.black,
                              myController: StudentController.CourseController.value,
                              focusNode: CourseFocusNode,
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
                              hint: 'Other Course...',
                              obscureText: false,
                              onChanged: (value){
                                setState(() {

                                  StudentController.Course = value.toString();
                                  visibleCourse = true;
                                });

                              },
                               OnSaved: (vlue){

                                 // visibleCourse = false;

                               },

                        ),
                             // if (StudentController.Program == "Other")

                             // Visibility(
                             //   visible: visibleCourse,
                             //   child: Padding(
                             //     padding: const EdgeInsets.only(top: 50),
                             //     child: Card(
                             //       elevation: 20,
                             //       color: AppColors.kPrimaryColor,
                             //       child: Stack(
                             //         alignment: Alignment.topRight,
                             //         children: [
                             //           Container(
                             //             height: 200,
                             //             child: SuggestionCourse(
                             //               visibleCourse : visibleCourse,
                             //               TextController:  StudentController.CourseController.value ,
                             //               Search: StudentController.Course, Course: StudentController.Course, ),
                             //           ),
                             //           IconButton(onPressed: (){
                             //             setState(() {
                             //               visibleCourse= false;
                             //             });
                             //           }, icon: Icon(Icons.close))
                             //         ],
                             //       ),
                             //     ),
                             //   ),
                             // )
                           ],
                         ),
                          visible: visibility,
                        )else Container(
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
                           // value: StudentController.selectedCourse,
                            items:itemsCourse.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Text(item.Name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                StudentController.selectedCourse =
                                    value.toString();
                                StudentController.Course = value?.Name as String ;
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





                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     border: Border.all(color: AppColors.whiteColor),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 10, right: 20),
                      //     child: DropdownButtonFormField<String>(
                      //       dropdownColor: AppColors.kPrimaryColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //       value: StudentController.selectedProgram,
                      //       items: StudentController.ProgramList.map((String category) {
                      //         return DropdownMenuItem<String>(
                      //           value: category,
                      //           child: Text(category),
                      //         );
                      //       }).toList(),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           StudentController.selectedProgram = value;
                      //           StudentController.selectedCourse = null;
                      //           StudentController.Program = value.toString();
                      //         });
                      //       },
                      //       focusNode: ProgramFocusNode,
                      //       decoration: const InputDecoration(
                      //         // labelText: 'Select a choice',
                      //         hintText: 'Select a Program',
                      //         border: InputBorder.none,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const ListTile(title: Text('Course Command')),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     border: Border.all(color: AppColors.whiteColor),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 10, right: 20),
                      //     child: DropdownButtonFormField<String>(
                      //       dropdownColor: AppColors.kPrimaryColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //       iconDisabledColor: AppColors.kTextColor,
                      //       value: StudentController.selectedCourse,
                      //       items: StudentController
                      //           .CourseMap[StudentController.selectedProgram]
                      //           ?.map((String item) {
                      //         return DropdownMenuItem<String>(
                      //           value: item,
                      //           child: Text(item),
                      //         );
                      //       })?.toList(),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           StudentController.selectedCourse = value.toString();
                      //           StudentController.Course = value.toString();
                      //         });
                      //       },
                      //       focusNode: CourseFocusNode,
                      //       decoration: const InputDecoration(
                      //         // labelText: 'Select a choice',
                      //         hintText: 'Select a Course',
                      //         border: InputBorder.none,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        title: Text('Fess'),
                      ),
                      //ll
                      InputTextField(
                        Color: Colors.black,
                        myController: StudentController.FeesController.value,
                        focusNode: FessFocusNode,
                        onFiledSubmittedValue: (Value) {
                          Utils.fieldFocus(
                              context, FessFocusNode, Null1);
                        },
                        onValidator: (value) {
                          if (value.isEmpty) {
                            return 'Fess is required';
                          }

                          return null;
                        },
                        KeyBoardType: TextInputType.number,
                        enable: true,
                        hint: 'Month Fess...',
                        obscureText: false,
                      ),
                      ListTile(
                        title: Text('Shift'),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.whiteColor)),
                          child: Obx(
                            () => Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround ,
                              children: [
                                RadioListTile(
                                  selectedTileColor: AppColors.whiteColor,
                                  activeColor: AppColors.whiteColor,
                                  title: Text("Morning"),
                                  value: "morning".obs,
                                  groupValue:
                                      StudentController.Shife.toString(),
                                  onChanged: (value) {
                                    StudentController.ShifeChake(
                                        value.toString());
                                  },
                                ),
                                RadioListTile(
                                  selectedTileColor: AppColors.whiteColor,
                                  activeColor: AppColors.whiteColor,
                                  title: Text("Evening"),
                                  value: "evening".obs,
                                  groupValue:
                                      StudentController.Shife.toString(),
                                  onChanged: (value) {
                                    StudentController.ShifeChake(
                                        value.toString());
                                  },
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      RoundButton(
                        title: 'Register Student',
                        onPrass: () {
                          if (_formKey.currentState!.validate()) {
                            StudentController.AddNewStudent(context,"${selectedDate.toLocal()}".split(' ')[0],);
                          }
                        },
                        color: AppColors.ButtonColor,
                      ),

                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )),
              HomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
