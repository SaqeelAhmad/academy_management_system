





import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../Utiles/color.dart';
import 'Add_Fess_Screen.dart';





class SearchStudentList extends StatefulWidget {
  String Search ;
   SearchStudentList({Key? key, required this.Search}) : super(key: key);

  @override
  State<SearchStudentList> createState() => _SearchStudentListState();
}

class _SearchStudentListState extends State<SearchStudentList> {
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final data = FirebaseDatabase.instance.ref("Users")
      .child(FirebaseAuth.instance.currentUser!.uid).child("Student");



  bool _isBold = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:
        FirebaseAnimatedList(query: data, itemBuilder: (BuildContext context,
            DataSnapshot snapshot, Animation<double> animation, int index) {

          if (snapshot.child("Uid").value.toString() == Uid.toString()){
            if (widget.Search.isEmpty){
              return StudentListWidget(
                RegNo: snapshot.child("RegNo").value.toString(),
                FName: snapshot.child("FName").value.toString() ,
                Name: snapshot.child("Name").value.toString(),
                Fess: snapshot.child("Fess").value.toString(),
                                  );

            }else if(
            snapshot.child("Name").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase()) //data[index].CourseName.toString()
                            || snapshot.child("RegNo").value.toString()
                                .toLowerCase()
                                .contains(widget.Search.toLowerCase())
                        ){
              return StudentListWidget(
                RegNo: snapshot.child("RegNo").value.toString(),
                FName: snapshot.child("FName").value.toString() ,
                Name: snapshot.child("Name").value.toString(),
                Fess: snapshot.child("Fess").value.toString(),
              );

            }else if (
                        snapshot.child("FName").value.toString()
                            .toLowerCase()
                            .contains(widget.Search.toLowerCase())
                        ){
              return StudentListWidget(
                RegNo: snapshot.child("RegNo").value.toString(),
                FName: snapshot.child("FName").value.toString() ,
                Name: snapshot.child("Name").value.toString(),
                Fess: snapshot.child("Fess").value.toString(),
              );
            }
            else{
              return Container();
            }

          }else{
            return  Container();
          }
        },)

    );
  }

}

class StudentListWidget extends StatefulWidget {
  String Name, FName, RegNo,Fess;

  StudentListWidget({Key? key, required this.RegNo,
    required this.FName, required this.Name,
    required this.Fess

  }) : super(key: key);

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {
  bool _isBold = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: AppColors.ButtonColor,
        child: InkWell(
          onLongPress: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFeeScreen(
              Fess: widget.Fess, FName: widget.FName, RollNo: widget.RegNo, Name: widget.Name,
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
                      child:  Text(widget.Name,textAlign: TextAlign.center,
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
                      child:  Text(widget.FName,textAlign: TextAlign.center,
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
                      child:  Text(widget.RegNo,textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme.subtitle1!.copyWith(//fontSize: 28
                            color: AppColors.whiteColor
                        ),
                      ),
                    ),
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}

