

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Teacher_List.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();
  String Search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(
              Title: 'Teacher',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom:  10,
                  right: 10,top: 5),
              child: InputTextField(
                onChanged: (value){
                  setState(() {
                    Search = value;
                  });
                },
                Suffix:    InkWell(
                    onTap: (){
                      SearchController.clear();
                      setState(() {
                        Search = "";
                      });
                    },
                    child: Icon(Icons.cancel,color: AppColors.kTextColor,)),
                myController: SearchController,
                focusNode: SearchFocusNode,
                onFiledSubmittedValue: (value){},
                onValidator: (value){}, KeyBoardType: TextInputType.name, hint: 'Search',
                obscureText: false,
                PrefixIcon: Icon(Icons.search,color: AppColors.kTextColor,),
                Color: AppColors.kTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2,right: 70),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Serial',style: Theme.of(context).textTheme.subtitle1,),
                    Text('Name',style: Theme.of(context).textTheme.subtitle1,),
                    Text('Course',style: Theme.of(context).textTheme.subtitle1,),
                    Text('Qualification',style: Theme.of(context).textTheme.subtitle1,),
                  ],
                ),
              ),
            ),
            Expanded(
                child:


            TeacherList(Search: Search,),
            ),
            HomeButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ButtonColor,
        onPressed: () {
          Get.toNamed('/AddTeacherScreen');
        },
        child: Icon(Icons.add,color: AppColors.whiteColor),
      ),
    );
  }
}
