




import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/color.dart';
import 'Add_Time_Controller.dart';
import 'Clack_Time_Card.dart';

class TimeList extends StatefulWidget {
  String Search ;
   TimeList({Key? key, required this .Search}) : super(key: key);

  @override
  State<TimeList> createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {
  final Uid= FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid).child("Time");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
     FirebaseAnimatedList(query: data, itemBuilder: (BuildContext context,
         DataSnapshot snapshot, Animation<double> animation, int index) {
       if(snapshot.child("Uid").value == FirebaseAuth.instance.currentUser!.uid){


         if (widget.Search.isEmpty){
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 10),
                         child: Card(

                           color: AppColors.ButtonColor,
                           child: InkWell(
                             onLongPress: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                   ClackTimeCard(
                                     Teacher: snapshot.child("Teacher").value.toString(),
                                     Course: snapshot.child("Course").value.toString(), Program: snapshot.child("Program").value.toString(),
                                     StartTime: snapshot.child("StartTime").value.toString(),
                                     EndTime: snapshot.child("EndTime").value.toString(),
                                   )));
                             },
                             child: Padding(
                               padding: const EdgeInsets.symmetric(
                                   vertical: 15, horizontal: 10),
                               child: Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(
                                         left: 10, right: 30),
                                     child: Text(
                                       (index + 1).toString(),
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle1!
                                           .copyWith(
                                           color: AppColors.whiteColor),
                                     ),
                                   ),
                                   Spacer(),
                                   Row(
                                     children: [
                                       Text(
                                         snapshot.child("StartTime").value.toString(),
                                         style: Theme.of(context)
                                             .textTheme
                                             .subtitle1!
                                             .copyWith(
                                             color: AppColors.whiteColor),
                                       ),
                                       Text(" - ",style: Theme.of(context)
                                           .textTheme
                                           .subtitle1!
                                           .copyWith(
                                           color: AppColors.whiteColor)),
                                       Text( snapshot.child("EndTime").value.toString(),
                                           style: Theme.of(context)
                                               .textTheme
                                               .subtitle1!
                                               .copyWith(
                                               color: AppColors.whiteColor),)
                                     ],
                                   ),
                                   Spacer(),
                                   InkWell(
                                       onTap: () {
                                         Get.defaultDialog(
                                           title: "Delete",
                                           middleText: "Are you sure you want to delete this Time Slot?",
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
                                       child: Icon(
                                         Icons.delete,
                                         color: Colors.white,
                                       )),
                                   SizedBox(
                                     width: 15,
                                   ),
                                   InkWell(
                                       onTap: () {
                                         _editDialog(snapshot.child("Id").value.toString(),
                                             snapshot.child("Teacher").value.toString(),
                                             snapshot.child("Program").value.toString(),
                                             snapshot.child("Course").value.toString(),
                                             snapshot.child("StartTime").value.toString(),
                                             snapshot.child("EndTime").value.toString(),
                                           snapshot.child("Uid").value.toString(),
                                         );

                                       },
                                       child: Icon(
                                         Icons.edit,
                                         color: Colors.white,
                                       )),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       );
         }else if (
         snapshot.child("ndTime").value.toString()
                         .toLowerCase()
                         .contains(widget.Search.toLowerCase())||
                        snapshot.child("StartTime").value.toString()
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
                       ClackTimeCard(
                         Teacher: snapshot.child("Teacher").value.toString(),
                         Course: snapshot.child("Course").value.toString(), Program: snapshot.child("Program").value.toString(),
                         StartTime: snapshot.child("StartTime").value.toString(),
                         EndTime: snapshot.child("EndTime").value.toString(),
                       )));
                 },
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                       vertical: 15, horizontal: 10),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(
                             left: 10, right: 30),
                         child: Text(
                           (index + 1).toString(),
                           style: Theme.of(context)
                               .textTheme
                               .subtitle1!
                               .copyWith(
                               color: AppColors.whiteColor),
                         ),
                       ),
                       Spacer(),
                       Row(
                         children: [
                           Text(
                             snapshot.child("StartTime").value.toString(),
                             style: Theme.of(context)
                                 .textTheme
                                 .subtitle1!
                                 .copyWith(
                                 color: AppColors.whiteColor),
                           ),
                           Text(" - ",style: Theme.of(context)
                               .textTheme
                               .subtitle1!
                               .copyWith(
                               color: AppColors.whiteColor)),
                           Text( snapshot.child("EndTime").value.toString(),
                             style: Theme.of(context)
                                 .textTheme
                                 .subtitle1!
                                 .copyWith(
                                 color: AppColors.whiteColor),)
                         ],
                       ),
                       Spacer(),
                       InkWell(
                           onTap: () {
                             Get.defaultDialog(
                               title: "Delete",
                               middleText: "Are you sure you want to delete this Time Slot?",
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
                             //data.child(snapshot.child("Id").value.toString()).remove();
                           },
                           child: Icon(
                             Icons.delete,
                             color: Colors.white,
                           )),
                       SizedBox(
                         width: 15,
                       ),
                       InkWell(
                           onTap: () {
                             _editDialog(snapshot.child("Id").value.toString(),
                               snapshot.child("Teacher").value.toString(),
                               snapshot.child("Program").value.toString(),
                               snapshot.child("Course").value.toString(),
                               snapshot.child("StartTime").value.toString(),
                               snapshot.child("EndTime").value.toString(),
                               snapshot.child("Uid").value.toString(),
                             );

                           },
                           child: Icon(
                             Icons.edit,
                             color: Colors.white,
                           )),
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






       }else{
         return Container();
       }
     },)

    );
  }

  Future<void> _editDialog(String  Id, String TeacherNme, String  Program , String Course , String StatTime, String EndTime, String Uid )async{
    final ProgramController = TextEditingController();
    final TeacherController = TextEditingController();
    final CourseController = TextEditingController();
    final AddTimeController TimeController = Get.put(AddTimeController());

    ProgramController.text = Program.toString() ;
    TeacherController.text = TeacherNme.toString();
    CourseController.text = Course.toString();


    return showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            backgroundColor: AppColors.kPrimaryColor,
            title: Text('Edit Time'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller:  TeacherController,
                    decoration: const InputDecoration(
                      // hintText: 'Enter title',
                        labelText: "Teacher Name",

                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller:  ProgramController,
                    decoration: const InputDecoration(
                       // hintText: 'Enter title',
                      labelText: "Enter Program",

                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: CourseController,
                    decoration: const InputDecoration(
                      // hintText: 'Enter title',
                        labelText: "Enter Course",

                        border: OutlineInputBorder()
                    ),
                  ),SizedBox(height: 10,),
                  Obx(
                        () => InkWell(
                      onTap: () {
                        TimeController.chooseTime();
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kTextColor),
                              borderRadius: BorderRadius.circular(5)),
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
                  SizedBox(height: 10,),
                  Obx(
                        () => InkWell(
                      onTap: () {
                        TimeController.chooseTimeEnd();
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kTextColor),
                            borderRadius: BorderRadius.circular(5)
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

                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancel',style: TextStyle(color: AppColors.alertColor),)),

              TextButton(onPressed: ()async{

                data.child(Id.toString()).update({
                  'Teacher': TeacherController.value.text.toString(),
                  'Program': ProgramController.text.toString(),
                  'Course': CourseController.text.toString(),//SelectProgram,
                  'EndTime': "${TimeController.selectedTimeEnd.value.hour}:${TimeController.selectedTimeEnd.value.minute}",
                  'StartTime': "${TimeController.selectedTimeStart.value.hour}:${TimeController.selectedTimeStart.value.minute}",
                  'Id': Id,
                  'Uid': Uid,
                }).then((value) => {
                  Get.snackbar('Successful', "Yor data is Update."),
                }).onError((error, stackTrace) => {
                  Get.snackbar('Exception', error.toString()),
                });


                // box.

                Navigator.pop(context);
              }, child: Text('Edit',style: TextStyle(color: AppColors.kTextColor),)),
            ],
          );
        }
    ) ;
  }
}
