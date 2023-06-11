





import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/color.dart';


class FessList extends StatefulWidget {
  String Search ;
   FessList({Key? key, required this.Search}) : super(key: key);

  @override
  State<FessList> createState() => _FessListState();
}

class _FessListState extends State<FessList> {
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid.toString()).child("Fess");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(
          query: data, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
          final indexCounter = Text('Index: $index');
          if (snapshot.child("Uid").value.toString() == Uid.toString()){
            if(widget.Search.isEmpty){
              return FessListWidget(

                RegNo: snapshot.child("RegNo").value.toString(),
                Fess: snapshot.child("Fess").value.toString(),
                Delete:(){ //data.child(snapshot.child("Id").value.toString()).remove();
                  Get.defaultDialog(
                    title: "Delete",
                    middleText: "Are you sure you want to delete this Fee?",
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
                  },
                Month: snapshot.child("Month").value.toString(),
                Conter: index+1,
                LongTab: (){

                },
                                );

            }else if (
            snapshot.child("RegNo").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase())){
              return FessListWidget(

                RegNo: snapshot.child("RegNo").value.toString(),
                Fess: snapshot.child("Fess").value.toString(),
                Delete:(){//data.child(snapshot.child("Id").value.toString()).remove();
                Get.defaultDialog(
                  title: "Delete",
                  middleText: "Are you sure you want to delete this Fee?",
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

                );},
                Month: snapshot.child("Month").value.toString(),
                Conter: index+1,
                LongTab: (){},
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
}


class FessListWidget extends StatefulWidget {
  String Month, RegNo,Fess;
  final Delete;
  final Conter;
  final LongTab;


  FessListWidget({Key? key, required this.RegNo,
    required this.Delete,
    required this.Month,
    required this.Fess,
    required this.Conter,
    required this.LongTab,


  }) : super(key: key);

  @override
  State<FessListWidget> createState() => _FessListWidgetState();
}

class _FessListWidgetState extends State<FessListWidget> {


  bool _isBold = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: AppColors.ButtonColor,
        child: InkWell(
          onLongPress: ()=>
            widget.LongTab,
          child: Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
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
                      child:  Text(widget.Conter.toString(),textAlign: TextAlign.center,
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
                      child:  Text(widget.Month,textAlign: TextAlign.center,
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
                      child:  Text(widget.RegNo,textAlign: TextAlign.center,
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
                      child:  Text(widget.Fess,textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme.subtitle1!.copyWith(//fontSize: 28
                            color: AppColors.whiteColor
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 25),
                  child: Container(
                    child: Center(
                      child:   InkWell(
                        onTap: widget.Delete,
                          child: Icon(Icons.delete,color: AppColors.whiteColor,)),
                    ),
                  ),
                )




              ],
            ),
          ),
        ),
      ),
    );
  }

}
