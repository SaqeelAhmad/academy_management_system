




import 'package:flutter/material.dart';

import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/color.dart';

class ClackTimeCard extends StatelessWidget {
  String Teacher,
      Program, Course, StartTime,EndTime;
  ClackTimeCard({Key? key, required this.Teacher,
    required this.Course, required this.Program,
  required this.StartTime, required this.EndTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Time Details",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 24),),
            CardWidget(title: "Teacher Name", value: Teacher.toString()),
            CardWidget(title: "Program", value: Program.toString()),
            CardWidget(title: "Course", value: Course.toString()),
            CardWidget(title: "Start Time", value: StartTime.toString()),
            CardWidget(title: "End Time", value: EndTime.toString()),

          ],
        ),
      )
      ),
    );
  }
}