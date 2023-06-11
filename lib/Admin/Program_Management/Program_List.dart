
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/color.dart';


class ProgramList extends StatefulWidget {
  ProgramList({Key? key, required this.Search}) : super(key: key);
  String Search;

  @override
  State<ProgramList> createState() => _ProgramListState();
}

class _ProgramListState extends State<ProgramList> {
  final ProgramController = TextEditingController();
  final data = FirebaseDatabase.instance.ref().child("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Program");
  int counter = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(query: data, itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final id = snapshot.child("Id").value;
          if(snapshot.child("Uid").value == FirebaseAuth.instance.currentUser!.uid){
          if (widget.Search.isEmpty){

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: AppColors.ButtonColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 50),
                          child: Text(
                            (index+1).toString() ,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                        Text(
                          snapshot.child("Program").value.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () {


                              Get.defaultDialog(
                                title: "Delete",
                                middleText: "Are you sure you want to delete this Program?",
                                backgroundColor: AppColors.kPrimaryColor,
                                cancel: TextButton(onPressed: (){
                                  Get.back();
                                }, child: Text("Cancel",style: Theme.of(context).textTheme
                                    .subtitle1,)),
                                confirm: TextButton(onPressed: (){

                                  data.child(id.toString()).remove();
                                  Get.back();
                                }, child: Text("Delete",style: Theme.of(context).textTheme
                                    .subtitle1!.copyWith(color: AppColors.alertColor),)),

                              );

                             // data.child(id.toString()).remove();
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
                              _editDialog(
                                  snapshot.child("Id").value.toString(),
                                  snapshot.child("Program").value.toString(),
                              snapshot.child("Uid").value.toString());
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
              );



          }if (
          snapshot.child("Program").value
                          .toString()
                          .toLowerCase()
                          .contains(widget.Search.toLowerCase())
          ){
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                color: AppColors.ButtonColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 50),
                        child: Text(
                          (index+1).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      Text(
                        snapshot.child("Program").value.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColors.whiteColor),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Delete",
                              middleText: "Are you sure you want to delete this Program?",
                              backgroundColor: AppColors.kPrimaryColor,
                              cancel: TextButton(onPressed: (){
                                Get.back();
                              }, child: Text("Cancel",style: Theme.of(context).textTheme
                                  .subtitle1,)),
                              confirm: TextButton(onPressed: (){

                                data.child(id.toString()).remove();
                                Get.back();
                              }, child: Text("Delete",style: Theme.of(context).textTheme
                                  .subtitle1!.copyWith(color: AppColors.alertColor),)),

                            );

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
                           data.child(id.toString()).remove();
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ],
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
        }
          )
    );
  }



  Future<void> _editDialog(
    String Id,
    String Program,
    String Uid,
  ) async {
    ProgramController.text = Program.toString();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.kPrimaryColor,
            title: Text('Edit Program'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: ProgramController,
                    decoration: const InputDecoration(
                        hintText: 'Enter title', border: OutlineInputBorder()),
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

                    data.child(Id).update({
                      "Id": Id,
                      "Uid": Uid,
                      "Program": ProgramController.text,
                    })
                        .then((value) => {
                              Get.snackbar('Successful', "Yor data is Update."),
                            })
                        .onError((error, stackTrace) => {
                              Get.snackbar('Exception', error.toString()),
                            });



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
