






import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Utiles/color.dart';
import 'Add_Teacher_Controller.dart';
import 'Clack_Card.dart';

class TeacherList extends StatefulWidget {
  String Search ;
  TeacherList({Key? key,  required this.Search}) : super(key: key);

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  bool _isBold = false;
  final CourseNameFocusNode = FocusNode();
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users")
      .child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Teacher");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(query: data,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {




            if (widget.Search.isEmpty){
              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Card(
                                  color: AppColors.ButtonColor,
                                  child: InkWell(
                                    onLongPress: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClackCardTeacher(
                                        Name:snapshot.child("Name").value.toString(),
                                        FName: snapshot.child("FName").value.toString(),
                                        Address: snapshot.child("Address").value.toString(),
                                        Program: snapshot.child("Program").value.toString(),
                                        Mobile: snapshot.child("Mobile").value.toString(),
                                        Nic: snapshot.child("Cnic").value.toString(),
                                        Salary: snapshot.child("Salary").value.toString(),
                                        Email: snapshot.child("Email").value.toString(),
                                        Course: snapshot.child("CourseCommand").value.toString(),
                                        Joining: snapshot.child("JoiningDate").value.toString(),
                                        Quailification: snapshot.child("Qualification").value.toString(),
                                      )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10),
                                            child: Text((index+1).toString(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.whiteColor),),
                                          ),
                                          Expanded(
                                            child: AnimatedDefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 32.0,
                                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                                color: Colors.blue,
                                              ),
                                              duration: const Duration(milliseconds: 500),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _isBold = !_isBold;
                                                  });
                                                },
                                                child:  Text(snapshot.child("Name").value.toString(),textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                                      color: AppColors.whiteColor
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: AnimatedDefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 32.0,
                                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                                color: Colors.blue,
                                              ),
                                              duration: const Duration(milliseconds: 500),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _isBold = !_isBold;
                                                  });
                                                },
                                                child:  Text(snapshot.child("CourseCommand").value.toString(),textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme.subtitle1!.copyWith(fontSize: 14,color: AppColors.whiteColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: AnimatedDefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 32.0,
                                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                                color: Colors.blue,
                                              ),
                                              duration: const Duration(milliseconds: 500),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _isBold = !_isBold;
                                                  });
                                                },
                                                child:  Text(snapshot.child("Qualification").value.toString(),textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                                      color: AppColors.whiteColor
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          InkWell(
                                              onTap: (){
                                                Get.defaultDialog(
                                                  title: "Delete",
                                                  middleText: "Are you sure you want to delete this Teacher?",
                                                  backgroundColor: AppColors.kPrimaryColor,
                                                  cancel: TextButton(onPressed: (){
                                                    Get.back();
                                                  }, child: Text("Cancel",style: Theme.of(context).textTheme
                                                      .subtitle1,)),
                                                  confirm: TextButton(onPressed: (){

                                                    data.child(snapshot.child("Id").value.toString()).remove();
                                                    Get.back();
                                                  }, child: Text("Delete",style: Theme.of(context).textTheme
                                                      .subtitle1!.copyWith(color: AppColors.alertColor),)),

                                                );
                                              // data.child(snapshot.child("Id").value.toString()).remove();
                                              },
                                              child: Icon(Icons.delete , color: Colors.white,)),
                                          SizedBox(width: 15,),
                                          InkWell(
                                              onTap: (){
                                                _editDialog(snapshot.child("Id").value.toString(),
                                                  snapshot.child("Name").value.toString(),
                                                  snapshot.child("FName").value.toString(),
                                                  snapshot.child("Address").value.toString(),
                                                  snapshot.child("Email").value.toString(),
                                                  snapshot.child("Qualification").value.toString(),
                                                  snapshot.child("Salary").value.toString(),
                                                  snapshot.child("Cnic").value.toString(),
                                                  snapshot.child("Mobile").value.toString(),
                                                  snapshot.child("JoiningDate").value.toString(),
                                                  snapshot.child("Program").value.toString(),
                                                  snapshot.child("CourseCommand").value.toString(),
                                                  snapshot.child("Uid").value.toString(),


                                                );
                                              },
                                              child: Icon(Icons.edit, color: Colors.white,)) ,

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

            }
            else if (
            snapshot.child("Name").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase()) ||
                snapshot.child("CourseCommand").value.toString()
                .toLowerCase()
                .contains(widget.Search.toLowerCase()) //data[index].CourseName.toString()

            ){
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: AppColors.ButtonColor,
                  child: InkWell(
                    onLongPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClackCardTeacher(
                        Name:snapshot.child("Name").value.toString(),
                        FName: snapshot.child("FName").value.toString(),
                        Address: snapshot.child("Address").value.toString(),
                        Program: snapshot.child("Program").value.toString(),
                        Mobile: snapshot.child("Mobile").value.toString(),
                        Nic: snapshot.child("Cnic").value.toString(),
                        Salary: snapshot.child("Salary").value.toString(),
                        Email: snapshot.child("Email").value.toString(),
                        Course: snapshot.child("CourseCommand").value.toString(),
                        Joining: snapshot.child("JoiningDate").value.toString(),
                        Quailification: snapshot.child("Qualification").value.toString(),
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Text((index+1).toString(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.whiteColor),),
                          ),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("Name").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                      color: AppColors.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("CourseCommand").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(fontSize: 14,color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("Qualification").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                      color: AppColors.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          InkWell(
                              onTap: (){
                                Get.defaultDialog(
                                  title: "Delete",
                                  middleText: "Are you sure you want to delete this Teacher?",
                                  backgroundColor: AppColors.kPrimaryColor,
                                  cancel: TextButton(onPressed: (){
                                    Get.back();
                                  }, child: Text("Cancel",style: Theme.of(context).textTheme
                                      .subtitle1,)),
                                  confirm: TextButton(onPressed: (){

                                    data.child(snapshot.child("Id").value.toString()).remove();
                                    Get.back();
                                  }, child: Text("Delete",style: Theme.of(context).textTheme
                                      .subtitle1!.copyWith(color: AppColors.alertColor),)),

                                );
                               // data.child(snapshot.child("Id").value.toString()).remove();
                              },
                              child: Icon(Icons.delete , color: Colors.white,)),
                          SizedBox(width: 15,),
                          InkWell(
                              onTap: (){
                                _editDialog(snapshot.child("Id").value.toString(),
                                  snapshot.child("Name").value.toString(),
                                  snapshot.child("FName").value.toString(),
                                  snapshot.child("Address").value.toString(),
                                  snapshot.child("Email").value.toString(),
                                  snapshot.child("Qualification").value.toString(),
                                  snapshot.child("Salary").value.toString(),
                                  snapshot.child("Cnic").value.toString(),
                                  snapshot.child("Mobile").value.toString(),
                                  snapshot.child("JoiningDate").value.toString(),
                                  snapshot.child("Program").value.toString(),
                                  snapshot.child("CourseCommand").value.toString(),
                                  snapshot.child("Uid").value.toString(),


                                );
                              },
                              child: Icon(Icons.edit, color: Colors.white,)) ,

                        ],
                      ),
                    ),
                  ),
                ),
              );

            }
            else if (
            snapshot.child("Qualification").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase())    //Qualification



            ){
              print("Name");
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: AppColors.ButtonColor,
                  child: InkWell(
                    onLongPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClackCardTeacher(
                        Name:snapshot.child("Name").value.toString(),
                        FName: snapshot.child("FName").value.toString(),
                        Address: snapshot.child("Address").value.toString(),
                        Program: snapshot.child("Program").value.toString(),
                        Mobile: snapshot.child("Mobile").value.toString(),
                        Nic: snapshot.child("Cnic").value.toString(),
                        Salary: snapshot.child("Salary").value.toString(),
                        Email: snapshot.child("Email").value.toString(),
                        Course: snapshot.child("CourseCommand").value.toString(),
                        Joining: snapshot.child("JoiningDate").value.toString(),
                        Quailification: snapshot.child("Qualification").value.toString(),
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Text((index+1).toString(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.whiteColor),),
                          ),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("Name").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                      color: AppColors.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("CourseCommand").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(fontSize: 14,color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                                color: Colors.blue,
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isBold = !_isBold;
                                  });
                                },
                                child:  Text(snapshot.child("Qualification").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(//fontSize: 28
                                      color: AppColors.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          InkWell(
                              onTap: (){
                                Get.defaultDialog(
                                  title: "Delete",
                                  middleText: "Are you sure you want to delete this Teacher?",
                                  backgroundColor: AppColors.kPrimaryColor,
                                  cancel: TextButton(onPressed: (){
                                    Get.back();
                                  }, child: Text("Cancel",style: Theme.of(context).textTheme
                                      .subtitle1,)),
                                  confirm: TextButton(onPressed: (){

                                    data.child(snapshot.child("Id").value.toString()).remove();
                                    Get.back();
                                  }, child: Text("Delete",style: Theme.of(context).textTheme
                                      .subtitle1!.copyWith(color: AppColors.alertColor),)),

                                );
                                // data.child(snapshot.child("Id").value.toString()).remove();
                              },
                              child: Icon(Icons.delete , color: Colors.white,)),
                          SizedBox(width: 15,),
                          InkWell(
                              onTap: (){
                                _editDialog(snapshot.child("Id").value.toString(),
                                  snapshot.child("Name").value.toString(),
                                  snapshot.child("FName").value.toString(),
                                  snapshot.child("Address").value.toString(),
                                  snapshot.child("Email").value.toString(),
                                  snapshot.child("Qualification").value.toString(),
                                  snapshot.child("Salary").value.toString(),
                                  snapshot.child("Cnic").value.toString(),
                                  snapshot.child("Mobile").value.toString(),
                                  snapshot.child("JoiningDate").value.toString(),
                                  snapshot.child("Program").value.toString(),
                                  snapshot.child("CourseCommand").value.toString(),
                                  snapshot.child("Uid").value.toString(),


                                );
                              },
                              child: Icon(Icons.edit, color: Colors.white,)) ,

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            else{
              return Container();
            }



        },)

    );
  }

  Future<void> _editDialog(
      String Id,
      String Name,
      String FatherName,
      String Address,
      String Email,
      String Qualification,
      String Salary,
      String Nic,
      String Mobile,
      String JoiningDate,
      String Program,
      String CourseCommend,
      String Uid

      ) async {
     final AddTeacherController TeacherController = Get.put(AddTeacherController());
    final NameController = TextEditingController();
    final FNameController = TextEditingController();
    final AddressController = TextEditingController();
    final EmailController = TextEditingController();
    final SalaryController = TextEditingController();
    final NicController = TextEditingController();
    final MobileController = TextEditingController();
    final CourseController = TextEditingController();
    final PhoneNoFocusNode = FocusNode();
    final ProgramController = TextEditingController();
    final QualificationController = TextEditingController();
    NameController.text = Name.toString();
    FNameController.text = FatherName.toString();
    AddressController.text = Address.toString();
    EmailController.text = Email.toString();
    SalaryController.text = Salary.toString();
    NicController.text = Nic.toString();
    MobileController.text = Mobile;
     CourseController.text = CourseCommend;
     ProgramController.text = Program;
     QualificationController.text = Qualification.toString();



    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.kPrimaryColor,
            title: Text('Edit Teacher'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: NameController,
                    decoration: const InputDecoration(
                        labelText: 'Teacher Name ',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: FNameController,
                    decoration: const InputDecoration(
                        labelText: 'Father Name',
                        border: OutlineInputBorder()),
                  ),SizedBox(height: 10,),
                  TextFormField(
                    controller: AddressController,
                    decoration: const InputDecoration(
                        labelText: 'Address Duration',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: EmailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: SalaryController,
                    decoration: const InputDecoration(
                        labelText: 'Salary',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: NicController,
                    decoration: const InputDecoration(
                        labelText: 'Nic',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  IntlPhoneField(
                    onSubmitted: (value) {},

                    focusNode: PhoneNoFocusNode,
                    controller: MobileController,
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
                    }
                  ),
                   SizedBox(height: 10,),


                  TextFormField(
                    controller: QualificationController,
                    decoration: const InputDecoration(
                        labelText: 'Qualification',
                        border: OutlineInputBorder()),
                  ),

                  SizedBox(height: 10,),

                  TextFormField(
                    controller: ProgramController,
                    decoration: const InputDecoration(
                        labelText: 'Program',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: CourseController,
                    decoration: const InputDecoration(
                        labelText: 'Course Command',
                        border: OutlineInputBorder()),
                  ),



                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(
                      color: AppColors.alertColor
                  ))),
              TextButton(
                  onPressed: () async {

                    data.child(Id.toString()).update({
                      'Name': NameController.value.text.toString(),
                      'FName': FNameController.value.text.toString(),
                      'Address' : AddressController.value.text.toString(),
                      'Email' : EmailController.value.text.toString(),
                      'CourseCommand': CourseController.value.text.toString(),
                      'Qualification' : QualificationController.text.toString(),
                      'Mobile': MobileController.value.text.toString(),
                      'JoiningDate': JoiningDate.toString(),
                      'Cnic': NicController.value.text.toString(),
                      'Program': ProgramController.value.text.toString(),
                      'Salary': SalaryController.value.text.toString(),

                    }).then((value) => {
                      Get.snackbar('Successful', "Yor data is Update."),



                    })
                        .onError((error, stackTrace) => {
                      Get.snackbar('Exception', error.toString()),

                    });

                    // box.

                    Navigator.pop(context);
                  },
                  child: Text('Edit',style: TextStyle(
                      color: AppColors.kTextColor
                  ),)),
            ],
          );
        });
  }
}
