





import 'package:flutter/material.dart';

import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/color.dart';

class ClackCard extends StatefulWidget {
  String //Teacher,
      CourseName, CourseDuration, Program, fee //, Levels
  ;
   ClackCard({Key? key ,//required this.Teacher,
     required this.CourseName,
     required this.CourseDuration, required this.Program,
  // required this.Levels,
     required this.fee
   }) : super(key: key);

  @override
  State<ClackCard> createState() => _ClackCardState();
}

class _ClackCardState extends State<ClackCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(child:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Course Details",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 28),),
             // CardWidget(title: 'Teacher Name', value: widget.Teacher,),
              CardWidget(title: "Course Name", value: widget.CourseName,),
              CardWidget(title: "Program", value: widget.Program),
              CardWidget(title: "Course Duration", value: widget.CourseDuration),
             // CardWidget(title: "Levels", value: widget.Levels),
              CardWidget(title: "Monthly Fee", value: widget.fee),

          ],),
        )

        ,),
    );
  }
}


