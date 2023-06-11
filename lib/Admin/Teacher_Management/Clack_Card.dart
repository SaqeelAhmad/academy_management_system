





import 'package:flutter/material.dart';

import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/color.dart';

class ClackCardTeacher extends StatefulWidget {
  String Name, FName, Address, Email, Quailification,
  Salary, Nic,Mobile, Joining, Program, Course;

   ClackCardTeacher({Key? key,
     required this.Name, required this.FName, required this.Address, required this.Program, required this.Mobile,
     required this.Nic, required this.Salary, required this.Email, required this.Course,
     required this.Joining, required this.Quailification
   }) : super(key: key);

  @override
  State<ClackCardTeacher> createState() => _ClackCardTeacherState();
}

class _ClackCardTeacherState extends State<ClackCardTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Teacher Details",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 28
              ),),
              CardWidget(title: "Name", value: widget.Name),
              CardWidget(title: "Father Name", value: widget.FName),
              CardWidget(title: "Address", value: widget.Address),
              CardWidget(title: "Email", value: widget.Email),
              CardWidget(title: "Qualification", value: widget.Quailification),
              CardWidget(title: "Salary Per Month", value: widget.Salary),
              CardWidget(title: "Nic", value: widget.Nic),
              CardWidget(title: "Mobile Number", value: "0"+widget.Mobile),
              CardWidget(title: "Joining Date ", value: widget.Joining,),
              CardWidget(title: "Program", value: widget.Program),
              CardWidget(title: "Course Command", value: widget.Address),


            ],
          ),
        ),
      ),
    );
  }
}
