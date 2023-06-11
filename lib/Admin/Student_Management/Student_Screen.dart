



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Student_List.dart';




class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();
  String Search = "";
  bool _isBold = false;

  @override
  Widget build(BuildContext context) {
    final height = Get.height* 1;
    final width = Get.width * 1;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
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
            Container(child: Padding(
              padding: const EdgeInsets.only(left: 2,right: 70),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        child:  Text('Serial',textAlign: TextAlign.center,
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
                        child:  Text('Name',textAlign: TextAlign.center,
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
                        child:  Text('Roll No',textAlign: TextAlign.center,
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
                        child:  Text('Course',textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme.subtitle1!.copyWith(//fontSize: 28
                              color: AppColors.kTextColor
                          ),
                        ),
                      ),
                    ),
                  ),

              ],),
            )),
            Expanded(child:
           StudentList(Search: Search),
            ),
            HomeButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ButtonColor,
        onPressed: () {
          Get.toNamed("/AddStudentScreen");
        },
        child: Icon(Icons.add,color: AppColors.whiteColor,),),);
  }
}
