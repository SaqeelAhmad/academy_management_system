






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Fess_Screen.dart';
import 'Search_Student_List.dart';

class SearchStudent extends StatefulWidget {
   const SearchStudent({Key? key}) : super(key: key);

   @override

   State<SearchStudent> createState() => _SearchStudentState();
 }

 class _SearchStudentState extends State<SearchStudent> {

 String Search= "";
 final SearchFocusNode= FocusNode();
 final SearchController = TextEditingController();

   final NullFocusNode = FocusNode();
   final _formKey = GlobalKey<FormState>();


   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();


    // MonthsFocusNode.dispose();


     NullFocusNode.dispose();

   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: AppColors.kPrimaryColor,
       body: Stack(
         alignment: Alignment.bottomLeft,
         children: [
           SafeArea(
             child: Column(
               children: [
                 AppBarComponent(Title: 'Student'),
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
                 Container(child: Padding(
                   padding: const EdgeInsets.only(left: 40,right: 40),
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [

                       Text('Name',style: Theme.of(context).textTheme.subtitle1,),
                       Padding(
                         padding: const EdgeInsets.only(right: 40,left: 50),
                         child: Text('FName',style: Theme.of(context).textTheme.subtitle1,),
                       ),
                       Text("Roll No",style: Theme.of(context).textTheme.subtitle1,),

                     ],),
                 )),
                 Expanded(child:
                 SearchStudentList(Search: Search),

                 ),
                 HomeButton(),
               ],
             ),
           ),
           IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FeeSCreen()));
           }, icon: Icon(Icons.arrow_back))
         ],
       ),
     );
   }
 }
