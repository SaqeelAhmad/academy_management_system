



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../Utiles/color.dart';
import 'Add_Payment_Screen.dart';


class SearchTeacherList extends StatefulWidget {
  String Search ;
   SearchTeacherList({Key? key, required this.Search}) : super(key: key);

  @override
  State<SearchTeacherList> createState() => _SearchTeacherListState();
}

class _SearchTeacherListState extends State<SearchTeacherList> {
  bool _isBold = false;
  final data = FirebaseDatabase.instance.ref("Users").child(FirebaseAuth.instance.currentUser!.uid).child("Teacher");
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body:FirebaseAnimatedList(query: data, itemBuilder: (BuildContext context,
          DataSnapshot snapshot, Animation<double> animation, int index) {
        if(snapshot.child("Uid").value.toString() == Uid.toString()){
          if (widget.Search.isEmpty){
           return TeacherListWidget(
             onLongPress:
                 (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   AddPaymentScreen(
                       Salary: snapshot.child("Salary").value.toString(),
                       FName: snapshot.child("FName").value.toString(),
                       Name: snapshot.child("Name").value.toString(),
                       Mobile: snapshot.child("Mobile").value.toString(),
                       CNIC:snapshot.child("Cnic").value.toString()
                   )
               )
               );
             }
             ,
             isBold: _isBold,
             Salary: snapshot.child("Salary").value.toString(),
             index: index,
             Name: snapshot.child("Name").value.toString(),
             Cnic: snapshot.child("Cnic").value.toString(),);
          }else if (
          snapshot.child("Name").value.toString()
                          .toLowerCase()
                          .contains(widget.Search.toLowerCase()) //data[index].CourseName.toString()
                          || snapshot.child("Cnic").value.toString()
                              .toLowerCase()
                              .contains(widget.Search.toLowerCase())){
            return TeacherListWidget(
              onLongPress:
                  (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    AddPaymentScreen(
                        Salary: snapshot.child("Salary").value.toString(),
                        FName: snapshot.child("FName").value.toString(),
                        Name: snapshot.child("Name").value.toString(),
                        Mobile: snapshot.child("Mobile").value.toString(),
                        CNIC:snapshot.child("Cnic").value.toString()
                    )
                )
                );
              }
              ,
              isBold: _isBold,
              Salary: snapshot.child("Salary").value.toString(),
              index: index,
              Name: snapshot.child("Name").value.toString(),
              Cnic: snapshot.child("Cnic").value.toString(),);

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




class TeacherListWidget extends StatelessWidget {
  final onLongPress; bool isBold;
  String Salary;
  int index;
  String Name,Cnic;


   TeacherListWidget({super.key,required this.onLongPress, required this.isBold, required this.Salary,
   required this.index , required this.Name,required this.Cnic,

   });

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child: Card(
                        color: AppColors.ButtonColor,
                        child: InkWell(
                          onLongPress: onLongPress,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AnimatedDefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.blue,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: () {

                                          isBold = !isBold;

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
                                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.blue,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: () {

                                          isBold = !isBold;

                                      },
                                      child:  Text(Name,textAlign: TextAlign.center,
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
                                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.blue,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: () {

                                          isBold = !isBold;

                                      },
                                      child:  Text(Cnic,textAlign: TextAlign.center,
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
                                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.blue,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: () {

                                          isBold = !isBold;

                                      },
                                      child:  Text("PR "+Salary,textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme.subtitle1!.copyWith(//fontSize: 28
                                            color: AppColors.whiteColor
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Spacer(),

                              ],
                            ),
                          ),
                        ),
                      ),
                    )
    );
  }
}
