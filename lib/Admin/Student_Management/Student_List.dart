





import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Utiles/color.dart';
import 'Add_Student_Controller.dart';
import 'Clack_Card_Student.dart';

class StudentList extends StatefulWidget {
  String Search;
   StudentList({Key? key , required this.Search}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Student");

  bool _isBold = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(
          query: data, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              if (widget.Search.isEmpty){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Card(
                                  color: AppColors.ButtonColor,
                                  child: InkWell(
                                      onLongPress: (){

                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            ClackCardStudent(
                                              Name: snapshot.child("Name").value.toString(),
                                              Gender: snapshot.child("Gender").value.toString(),
                                              Program: snapshot.child("Program").value.toString(),
                                              Address: snapshot.child("Address").value.toString(),
                                              Course: snapshot.child("Course").value.toString(),
                                              Shift: snapshot.child("Shift").value.toString(),
                                              FName: snapshot.child("FName").value.toString(),
                                              RegNo: snapshot.child("RegNo").value.toString(),
                                              Guardian: snapshot.child("GuardianMobile").value.toString(),
                                              Phone: snapshot.child("Mobile").value.toString(),
                                              BirthDate: snapshot.child("DateOfBirth").value.toString(),
                                              Fess: snapshot.child("Fess").value.toString(),

                                            )));


                                      },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      child: Row(
                                        children: [

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
                                                child:  Text((index+1).toString(),textAlign: TextAlign.center,
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
                                                child:  Text(snapshot.child("RegNo").value.toString(),textAlign: TextAlign.center,
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
                                                child:  Text(snapshot.child("Course").value.toString(),textAlign: TextAlign.center,
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
                                                  middleText: "Are you sure you want to delete this Student?",
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
                                                // _editDialog(data[index], data[index].Program.toString(),);
                                                _editDialog(
                                                  snapshot.child("Id").value.toString(),
                                                  snapshot.child("Name").value.toString(),
                                                  snapshot.child("FName").value.toString(),
                                                  snapshot.child("RegNo").value.toString(),
                                                  snapshot.child("DateOfBirth").value.toString(),
                                                  snapshot.child("Gender").value.toString(),
                                                  snapshot.child("Address").value.toString(),
                                                  snapshot.child("Mobile").value.toString(),
                                                  snapshot.child("GuardianMobile").value.toString() ,
                                                  snapshot.child("Program").value.toString(),
                                                  snapshot.child("Course").value.toString(),
                                                  snapshot.child("Fess").value.toString(),
                                                  snapshot.child("Shift").value.toString(),
                                                );


                                              },
                                              child: Icon(Icons.edit, color: Colors.white,)) ,

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
              }else if(snapshot.child("Name").value.toString()
                              .toLowerCase()
                              .contains(widget.Search.toLowerCase()) //data[index].CourseName.toString()
                              || snapshot.child("RegNo").value.toString()
                                  .toLowerCase()
                                  .contains(widget.Search.toLowerCase())){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: AppColors.ButtonColor,
                    child: InkWell(
                      onLongPress: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ClackCardStudent(
                              Name: snapshot.child("Name").value.toString(),
                              Gender: snapshot.child("Gender").value.toString(),
                              Program: snapshot.child("Program").value.toString(),
                              Address: snapshot.child("Address").value.toString(),
                              Course: snapshot.child("Course").value.toString(),
                              Shift: snapshot.child("Shift").value.toString(),
                              FName: snapshot.child("FName").value.toString(),
                              RegNo: snapshot.child("RegNo").value.toString(),
                              Guardian: snapshot.child("GuardianMobile").value.toString(),
                              Phone: snapshot.child("Mobile").value.toString(),
                              BirthDate: snapshot.child("DateOfBirth").value.toString(),
                              Fess: snapshot.child("Fess").value.toString(),

                            )));


                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Row(
                          children: [

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
                                  child:  Text((index+1).toString(),textAlign: TextAlign.center,
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
                                  child:  Text(snapshot.child("RegNo").value.toString(),textAlign: TextAlign.center,
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
                                  child:  Text(snapshot.child("Course").value.toString(),textAlign: TextAlign.center,
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
                                    middleText: "Are you sure you want to delete this Student?",
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
                                  // _editDialog(data[index], data[index].Program.toString(),);
                                  _editDialog(
                                    snapshot.child("Id").value.toString(),
                                    snapshot.child("Name").value.toString(),
                                    snapshot.child("FName").value.toString(),
                                    snapshot.child("RegNo").value.toString(),
                                    snapshot.child("DateOfBirth").value.toString(),
                                    snapshot.child("Gender").value.toString(),
                                    snapshot.child("Address").value.toString(),
                                    snapshot.child("Mobile").value.toString(),
                                    snapshot.child("GuardianMobile").value.toString() ,
                                    snapshot.child("Program").value.toString(),
                                    snapshot.child("Course").value.toString(),
                                    snapshot.child("Fess").value.toString(),
                                    snapshot.child("Shift").value.toString(),
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
              snapshot.child("Course").value.toString()
                  .toLowerCase()
                  .contains(widget.Search.toLowerCase())
              ){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: AppColors.ButtonColor,
                    child: InkWell(
                      onLongPress: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ClackCardStudent(
                              Name: snapshot.child("Name").value.toString(),
                              Gender: snapshot.child("Gender").value.toString(),
                              Program: snapshot.child("Program").value.toString(),
                              Address: snapshot.child("Address").value.toString(),
                              Course: snapshot.child("Course").value.toString(),
                              Shift: snapshot.child("Shift").value.toString(),
                              FName: snapshot.child("FName").value.toString(),
                              RegNo: snapshot.child("RegNo").value.toString(),
                              Guardian: snapshot.child("GuardianMobile").value.toString(),
                              Phone: snapshot.child("Mobile").value.toString(),
                              BirthDate: snapshot.child("DateOfBirth").value.toString(),
                              Fess: snapshot.child("Fess").value.toString(),

                            )));


                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Row(
                          children: [

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
                                  child:  Text((index+1).toString(),textAlign: TextAlign.center,
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
                                  child:  Text(snapshot.child("RegNo").value.toString(),textAlign: TextAlign.center,
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
                                  child:  Text(snapshot.child("Course").value.toString(),textAlign: TextAlign.center,
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
                                    middleText: "Are you sure you want to delete this Student?",
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
                                  // _editDialog(data[index], data[index].Program.toString(),);
                                  _editDialog(
                                    snapshot.child("Id").value.toString(),
                                    snapshot.child("Name").value.toString(),
                                    snapshot.child("FName").value.toString(),
                                    snapshot.child("RegNo").value.toString(),
                                    snapshot.child("DateOfBirth").value.toString(),
                                    snapshot.child("Gender").value.toString(),
                                    snapshot.child("Address").value.toString(),
                                    snapshot.child("Mobile").value.toString(),
                                    snapshot.child("GuardianMobile").value.toString() ,
                                    snapshot.child("Program").value.toString(),
                                    snapshot.child("Course").value.toString(),
                                    snapshot.child("Fess").value.toString(),
                                    snapshot.child("Shift").value.toString(),
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
      String Name, String FatherName,
      String RegNo, String BirthDate,
      String Gender, String Address,
      String Phone, String Guardian,
      String Program, String Course,
      String Fess, String Shife,



      ) async {
    final AddStudentController TeacherController = Get.put(AddStudentController());
    final NameController = TextEditingController();
    final FNameController = TextEditingController();
    final RegNoController = TextEditingController();
    final AddressController = TextEditingController();
    final Phonecontroller =TextEditingController();
    final GuardianPhoneController = TextEditingController();
    final CourseController = TextEditingController();
    final FessController = TextEditingController();
    final ShiftController = TextEditingController();
    final ProgramController = TextEditingController();

    NameController.text = Name.toString();
    FNameController.text = FatherName.toString();
    AddressController.text = Address.toString();
    RegNoController.text= RegNo.toString();
    Phonecontroller.text= Phone.toString();
    GuardianPhoneController.text = Guardian.toString();
    FessController.text = Fess.toString();
    ShiftController.text = Shife.toString();
    CourseController.text= Course.toString();
    ProgramController.text = Program.toString();
    final PhoneNoFocusNode = FocusNode();
    final GuardianPhoneNoFocusNode = FocusNode();




    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.kPrimaryColor,
            title: const Text('Edit Student'),
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
                    controller: RegNoController,
                    decoration: const InputDecoration(
                        labelText: 'Reg No',
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
                        labelText: 'Course',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  IntlPhoneField(
                      onSubmitted: (value) {},

                      focusNode: PhoneNoFocusNode,
                      controller: Phonecontroller,
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
                  IntlPhoneField(
                      onSubmitted: (value) {},

                      focusNode: GuardianPhoneNoFocusNode,
                      controller: GuardianPhoneController,
                      decoration: InputDecoration(
                        labelText: 'Guardian Number',
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
                  ),SizedBox(height: 10,),


                  TextFormField(
                    controller: FessController,
                    decoration: const InputDecoration(
                        labelText: 'Fee',
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

                      'Name': NameController.value.text,
                      'FName':FNameController.value.text ,
                      'RegNo': RegNoController.value.text,
                      'DateOfBirth': BirthDate.toString(),//dateofBirth,
                      'Gender': Gender.toString(),// GenderC ,
                      'Address': AddressController.value.text,
                      'Mobile': Phonecontroller.value.text,
                      'GuardianMobile': GuardianPhoneController.value.text,
                      'Program': Program , 'Course': Course,
                      'Shift': ShiftController.value.toString(),
                      'Fess': FessController.value.text,
                      "Id": Id.toString(),
                      "Uid": Uid.toString(),

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
