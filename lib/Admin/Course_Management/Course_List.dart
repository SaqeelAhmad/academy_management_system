



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/color.dart';
import 'Clack_Card.dart';


class CourseList extends StatefulWidget {
  String Search ;
   CourseList({Key? key, required this.Search}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  bool _isBold = false;
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(
      FirebaseAuth.instance.currentUser!.uid.toString()).child("Course");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(query: data, itemBuilder: (BuildContext context, DataSnapshot
        snapshot, Animation<double> animation, int index) {




            if (widget.Search.isEmpty == null){
              return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onLongPress: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ClackCard(
                                   // Teacher: snapshot.child("Teacher").value.toString(),
                                    CourseName: snapshot.child("CourseName").value.toString(),
                                    CourseDuration: snapshot.child("CourseDuration").value.toString(),
                                    Program: snapshot.child("Program").value.toString(),
                                   // Levels: snapshot.child("Levels").value.toString(),
                                    fee:  snapshot.child("MonthlyFee").value.toString(),
                                  )));

                                },
                                child: Card(
                                  color: AppColors.ButtonColor,
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
                                              child:  Text(snapshot.child("Teacher").value.toString(),textAlign: TextAlign.center,
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
                                              child:  Text(snapshot.child("CourseName").value.toString(),textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme.subtitle1!.copyWith(fontSize: 14,color: AppColors.whiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        InkWell(
                                            onTap: (){
                                              Get.defaultDialog(
                                                title: "Delete",
                                                middleText: "Are you sure you want to delete this Course?",
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
                                                snapshot.child("Teacher").value.toString(),
                                                snapshot.child("CourseName").value.toString(),
                                                snapshot.child("CourseDuration").value.toString(),
                                                snapshot.child("Program").value.toString(),
                                                snapshot.child("MonthlyFee").value.toString(),
                                                snapshot.child("Levels").value.toString(),
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

            }else if (snapshot.child("Program").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase()) //data[index].CourseName.toString()
                        || snapshot.child("CourseName").value.toString()
                                .toLowerCase()
                                .contains(widget.Search.toLowerCase())){
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ClackCard(
                     // Teacher: snapshot.child("Teacher").value.toString(),
                      CourseName: snapshot.child("CourseName").value.toString(),
                      CourseDuration: snapshot.child("CourseDuration").value.toString(),
                      Program: snapshot.child("Program").value.toString(),
                     // Levels: snapshot.child("Levels").value.toString(),
                      fee:  snapshot.child("MonthlyFee").value.toString(),
                    )));

                  },
                  child: Card(
                    color: AppColors.ButtonColor,
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
                                child:  Text(snapshot.child("CourseName").value.toString(),textAlign: TextAlign.center,
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
                                child:  Text(snapshot.child("Program").value.toString(),textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme.subtitle1!.copyWith(fontSize: 14,color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          InkWell(
                              onTap: (){
                                Get.defaultDialog(
                                  title: "Delete",
                                  middleText: "Are you sure you want to delete this Course?",
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
                               //
                              },
                              child: Icon(Icons.delete , color: Colors.white,)),
                          SizedBox(width: 15,),
                          InkWell(
                              onTap: (){
                                _editDialog(snapshot.child("Id").value.toString(),
                                  snapshot.child("Teacher").value.toString(),
                                  snapshot.child("CourseName").value.toString(),
                                  snapshot.child("CourseDuration").value.toString(),
                                  snapshot.child("Program").value.toString(),
                                  snapshot.child("MonthlyFee").value.toString(),
                                  snapshot.child("Levels").value.toString(),
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
      String Teacher,
      String Course,
      String CourseDuration,
      String Program,
      String Fee,
      String Levels,
      String Uid,

      ) async {
    final TeacherController = TextEditingController();
    final CourseController = TextEditingController();
    final CourseDurationController = TextEditingController();
    final ProgramController = TextEditingController();
    final FeeController = TextEditingController();
    final LevelelsController = TextEditingController();
    TeacherController.text = Teacher.toString();
    CourseController.text = Course.toString();
    CourseDurationController.text = CourseDuration.toString();
    ProgramController.text = Program.toString();
    FeeController.text = Fee.toString();
    LevelelsController.text = Levels.toString();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.kPrimaryColor,
            title: Text('Edit Course'),
            content: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: CourseController,
                    decoration: const InputDecoration(
                        labelText: 'Course Name',
                        border: OutlineInputBorder()),
                  ),SizedBox(height: 10,),
                  TextFormField(
                    controller: CourseDurationController,
                    decoration: const InputDecoration(
                        labelText: 'Course Duration',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: ProgramController,
                    decoration: const InputDecoration(
                        labelText: 'Enter Program',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: FeeController,
                    decoration: const InputDecoration(
                        labelText: 'Monthly Fee',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),

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

                    data.child(Id).update({

                      'CourseName': CourseController.value.text,
                      'CourseDuration': CourseDurationController.value.text,
                      'Program': ProgramController.value.text,

                      'MonthlyFee': FeeController.value.text,

                      'Id':Id,
                      "Uid": Uid,

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
