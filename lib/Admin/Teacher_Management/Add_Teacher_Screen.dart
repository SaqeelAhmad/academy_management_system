
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
import 'Add_Teacher_Controller.dart';
const List<String> list = <String>["Fa",'Fac', 'Ba', 'BS', 'Ms','Phd'];
class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final AddTeacherController TeacherController =
      Get.put(AddTeacherController());

  final NameFocusNode = FocusNode();
  final FatherNameFocusNode = FocusNode();
  final AddressFocusNode = FocusNode();
  final EmailFocusNode = FocusNode();
  final QualificationFocusNode = FocusNode();
  final SalaryperMonthFocusNode = FocusNode();
  final NicFocusNode = FocusNode();
  final PhoneNoFocusNode = FocusNode();
  final JoiningFocusNode = FocusNode();
  final CourseConnandFocusNode = FocusNode();
  final NullFocusNode = FocusNode();
  final ProgramFocusNode = FocusNode();
  final CourseNameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    NameFocusNode.dispose();

    FatherNameFocusNode.dispose();

    EmailFocusNode.dispose();

    QualificationFocusNode.dispose();

    SalaryperMonthFocusNode.dispose();
    NameFocusNode.dispose();
    PhoneNoFocusNode.dispose();
    JoiningFocusNode.dispose();
    CourseConnandFocusNode.dispose();
    NullFocusNode.dispose();
    ProgramFocusNode.dispose();
    CourseNameFocusNode.dispose();

  }
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

    }
  }
  bool visibilityProgram = true;
  bool visibility = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataProgram();

  }
  final databaseReference = FirebaseDatabase.instance.ref("Users")
      .child(FirebaseAuth.instance.currentUser!.uid.toString());

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
    TeacherController.ProgramController.value == TeacherController.Program;
    TeacherController.courseController.value == TeacherController.Course;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBarComponent(
                Title: 'Register Teacher',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(title: Text('Name')),
                        InputTextField(
                          Color: Colors.black,
                          myController: TeacherController.NameControlle.value,
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
                        ListTile(title: Text('Father Name')),
                        InputTextField(
                          Color: Colors.black,
                          myController:TeacherController. FatherNameController.value,
                          focusNode: FatherNameFocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(
                                context, FatherNameFocusNode, AddressFocusNode);
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
                          hint: 'Father Name',
                          obscureText: false,
                        ),
                        ListTile(title: Text('Address')),
                        InputTextField(
                          Color: Colors.black,
                          myController: TeacherController.AddressController.value,
                          focusNode: AddressFocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(
                                context, AddressFocusNode, EmailFocusNode);
                          },
                          onValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Father name.';
                            }
                            return null;
                          },
                          KeyBoardType: TextInputType.text,
                          enable: true,
                          hint: 'Address',
                          obscureText: false,
                        ),
                        ListTile(title: Text('Email')),
                        InputTextField(
                          Color: Colors.black,
                          myController: TeacherController.EmailController.value,
                          focusNode: EmailFocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(context, EmailFocusNode,
                                QualificationFocusNode);
                          },
                          onValidator: (value) {
                            RegExp regex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                                r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                            if (value!.isEmpty) {
                              return 'Please enter email';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid email';
                              } else {
                                return null;
                              }
                            }
                          },
                          KeyBoardType: TextInputType.emailAddress,
                          enable: true,
                          hint: 'Email',
                          obscureText: false,
                        ),
                        ListTile(title: Text('Qualification')),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.whiteColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(20),
                              value: TeacherController.selectedValueQualification,
                              items: TeacherController.QualificationItems.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  TeacherController.SelectQualification = value!;
                                 // TeacherController.selectedCourse = null;
                                  TeacherController.SelectQualification = value.toString();
                                });
                              },
                              focusNode: QualificationFocusNode,
                              decoration: const InputDecoration(
                                // labelText: 'Select a choice',
                                hintText: 'Select a Qualification',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        ListTile(title: Text('Salary per Month')),
                        InputTextField(
                            Color: AppColors.kTextColor,
                            myController: TeacherController.SalaryperMonthController.value,
                            focusNode: SalaryperMonthFocusNode,
                            onFiledSubmittedValue: (value) {
                              Utils.fieldFocus(context, SalaryperMonthFocusNode,
                                  NicFocusNode);
                            },
                            onValidator: (value) {},
                            KeyBoardType: TextInputType.number,
                            hint: 'Salary per Month',
                            obscureText: false),
                        ListTile(title: Text('CNIC')),
                        InputTextField(
                            Color: AppColors.kTextColor,
                            myController: TeacherController.NicController.value,
                            focusNode: NicFocusNode,
                            onFiledSubmittedValue: (value) {
                              Utils.fieldFocus(
                                  context, NicFocusNode, PhoneNoFocusNode);
                            },
                            onValidator: (value) {
                             // value.length <= 13 ? 'Nic too short.' : null;
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Father name.';
                              } else if (value.length == 11  ) {
                                return 'Please don\'t use the @ char.';
                              }
                              return null;
                            },
                            KeyBoardType: TextInputType.number,
                            hint: 'CNIC',
                            obscureText: false),
                        ListTile(title: Text('Phone No')),
                        IntlPhoneField(
                          onSubmitted: (value) {
                            Utils.fieldFocus(
                                context, PhoneNoFocusNode, JoiningFocusNode);
                          },
                          // onCountryChanged: (value){
                          //   Utils.fieldFocus(
                          //       context, PhoneNoFocusNode , JoiningFocusNode );
                          // },
                          focusNode: PhoneNoFocusNode,
                          controller: TeacherController.PhoneNoController.value,
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
                        const ListTile(title: Text('Joining Date')),

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
                             // value: TeacherController.selectedProgram,
                              items: itemsProgram.map((Item item) {
                                return DropdownMenuItem<Item>(
                                  value: item,
                                  child: Text(item.Name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  fetchDataCourse(value?.Name as String);
                                  TeacherController.selectedProgram == value?.Name as String;
                                  // TeacherController.selectedCourse = null;
                                  // TeacherController.Program = value.toString();
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

                        if (TeacherController.Program == "Other")
                          Visibility(child: InputTextField(
                            Color: Colors.black,
                            myController: TeacherController.ProgramController.value,
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
                              TeacherController.Program = value.toString();
                            },
                          ),
                            visible: visibility,
                          ),
                        const ListTile(title: Text('Course Command')),
                        if (TeacherController.Program == "Other")
                          Visibility(child: InputTextField(
                            Color: Colors.black,
                            myController: TeacherController.courseController.value,
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
                            hint: 'Other Course...',
                            obscureText: false,
                            onChanged: (value){
                              TeacherController.Course = value.toString();
                            },
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
                             // value: TeacherController.selectedCourse,
                              items:itemsCourse.map((Item item) {
                                return DropdownMenuItem<Item>(
                                  value: item,
                                  child: Text(item.Name),
                                );
                              }).toList(),

                              onChanged: (value) {
                                setState(() {
                                  TeacherController.Course = value?.Name as String;
                                 // TeacherController.Course = value.toString();
                                });
                              },
                              focusNode: CourseNameFocusNode,
                              decoration: const InputDecoration(
                                // labelText: 'Select a choice',
                                hintText: 'Select a Course',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: RoundButton(
                            title: 'Register Teacher',
                            onPrass: () {
                              if (_formKey.currentState!.validate()) {
                                if (TeacherController.Loading.value == false){
                                  TeacherController.AddNewTeacher(context,"${selectedDate.toLocal()}".split(' ')[0]);
                                }

                              }
                            },
                            color: AppColors.ButtonColor,
                            loading: TeacherController.Loading.value,
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
              HomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}









