


import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';

import 'Course_List.dart';


class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final height = Get.height* 1;
    final width = Get.width * 1;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(Title: 'Course'),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom:  10,
                  right: 10,top: 5),
              child: InputTextField(

                Suffix:    InkWell(
                    onTap: (){
                      SearchController.clear();
                      setState(() {
                        _searchQuery = "";
                      });

                    },
                    child: Icon(Icons.cancel,color: AppColors.kTextColor,)),
                myController: SearchController,
                focusNode: SearchFocusNode,
                onFiledSubmittedValue: (value){},
                onValidator: (value){},
                KeyBoardType: TextInputType.name,
                hint: 'Search',
                obscureText: false,
                PrefixIcon: Icon(Icons.search,color: AppColors.kTextColor,),
                Color: AppColors.kTextColor,
                  onChanged:(value){
                    setState(() {
                      _searchQuery = value;
                    });
                  }


              ),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('Serial',style: Theme.of(context).textTheme.subtitle1,),
                    Text("Course",style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(width: 10,),
                    //Text("Program",style: Theme.of(context).textTheme.subtitle1,),
                    Text('Program',style: Theme.of(context).textTheme.subtitle1,),


                  ],),
                ),
              ),
            ),
            Expanded(child:

            CourseList(Search: _searchQuery,),
            ),
            HomeButton(),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: AppColors.ButtonColor,
      onPressed: () {
      Get.toNamed("/AddCourseScreen");

    },child: Icon(Icons.add,color: AppColors.whiteColor,
    ),),);

  }

}
