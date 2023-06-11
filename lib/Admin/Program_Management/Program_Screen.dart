
import 'package:academy_management_syste/Admin/Home_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Program_List.dart';



class ProgramScreen extends StatefulWidget {
  const ProgramScreen({Key? key}) : super(key: key);

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  @override


  String Search = "";
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();









  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;

    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(Title: 'Program'),
            Padding(
              padding: const EdgeInsets.only(left: 10,
                  right: 10, top: 5),
              child: InputTextField(
                onChanged: (value){
                  setState(() {
                    Search= value;
                  });
                },
                Suffix: InkWell(
                    onTap: () {
                      SearchController.clear();
                      setState(() {
                        Search = "";
                      });

                    },
                    child: Icon(Icons.cancel, color: AppColors.kTextColor,)),
                myController: SearchController,
                focusNode: SearchFocusNode,
                onFiledSubmittedValue: (value) {},
                onValidator: (value) {},
                KeyBoardType: TextInputType.name,
                hint: 'Search',
                obscureText: false,
                PrefixIcon: Icon(Icons.search, color: AppColors.kTextColor,),
                Color: AppColors.kTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(child: Row(children: [
                Text("Serial", style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,),
                SizedBox(width: 30,),
                Text("Name", style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,),
              ],),),
            ),
            Container(
              child: Expanded(child:
              ProgramList(Search: Search,),



                  ),
            ),
            HomeButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ButtonColor,
        onPressed: () {
        Get.toNamed('/AddProgramScreen', arguments: []);
      }, child: Icon(Icons.add,color: AppColors.whiteColor,),),);
  }


}
