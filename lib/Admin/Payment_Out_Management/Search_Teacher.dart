

import 'package:academy_management_syste/Admin/Payment_Out_Management/Payment_Out_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Search_Teacher_List.dart';

class SearchTeacher extends StatefulWidget {
  const SearchTeacher({Key? key}) : super(key: key);

  @override
  State<SearchTeacher> createState() => _SearchTeacherState();

}

class _SearchTeacherState extends State<SearchTeacher> {
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();
  String Search= "";
  @override
  Widget build(BuildContext context) {
    bool  _isBold = false;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SafeArea(
            child:
              Column(
                children: [
                  AppBarComponent(Title: 'Add Salary',),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom:  5,
                        right: 10,top: 5),
                    child: InputTextField(
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
                      onChanged: (value){
                        setState(() {
                          Search= value;
                        });

                      },
                    ),
                  ),
                  Container(child: Row(
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
                            child:  Text("Serial",textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme.subtitle1!.copyWith(//fontSize: 28
                                  color: AppColors.kTextColor
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
                            child:  Text("Name",textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme.subtitle1!.copyWith(//fontSize: 28
                                  color: AppColors.kTextColor
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
                            child:  Text("CNIC",textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme.subtitle1!.copyWith(//fontSize: 28
                                  color: AppColors.kTextColor
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
                            child:  Text("Salary",textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme.subtitle1!.copyWith(//fontSize: 28
                                  color: AppColors.kTextColor
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),),
                  Container(child: Expanded(
                    child: SearchTeacherList(Search: Search,),
                  ),),
                  HomeButton(),
                ],
              ),

          ),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentOutScreen()));
          }, icon:Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}
