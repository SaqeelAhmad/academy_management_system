




import 'package:flutter/material.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/color.dart';

class ClackCardStudent extends StatefulWidget {
  String Name, FName, RegNo, BirthDate, Gender, Address,
  Phone, Guardian,Program, Course, Fess, Shift;

   ClackCardStudent({Key? key,
   required this.Name, required this.Gender, required this.Program,
     required this.Address,required this.Course, required this.Shift,
     required this.FName, required this.RegNo, required this.Guardian,
     required this.Phone, required this.BirthDate, required this.Fess
   }) : super(key: key);

  @override
  State<ClackCardStudent> createState() => _ClackCardStudentState();
}

class _ClackCardStudentState extends State<ClackCardStudent> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(Title: "Student Details"),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [


                      CardWidget(title: "Name", value: widget.Name),
                      CardWidget(title: "Father Name", value: widget.FName),
                      CardWidget(title: "Reg No", value: widget.RegNo),
                      CardWidget(title: "Date of Birth", value: widget.BirthDate),
                      CardWidget(title: "Gender", value: widget.Gender),
                      CardWidget(title: "Address", value: widget.Address),
                      CardWidget(title: "Mobile No", value: "0"+widget.Phone),
                      CardWidget(title: "Guardian Mobile No", value: "0"+widget.Guardian),
                      CardWidget(title: "Program", value: widget.Program),
                      CardWidget(title: "Course", value: widget.Course),
                      CardWidget(title: "Shift", value: widget.Shift),
                      CardWidget(title: "Fee", value: widget.Fess),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
            ),
            HomeButton(),
          ],
        ),
      ),

    );
  }
}
