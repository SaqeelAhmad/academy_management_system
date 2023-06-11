



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/Component/Round_Button.dart';
import '../../Utiles/color.dart';
import 'Add_Program_Controller.dart';
import 'Program_Screen.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {

   final ProgramFocusNode = FocusNode();

final AddProgramController ProgramController = Get.put(AddProgramController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ProgramFocusNode.dispose();

  }


bool visibility = false;


  @override
  Widget build(BuildContext context) {
   // ProgramController.ProgramController.value.text= ProgramController.Select.toString();
    final heigh = Get.height * 1;
    return Scaffold(
      body: Container(
        color: AppColors.kPrimaryColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Scaffold(
                backgroundColor: AppColors.kPrimaryColor,
                body: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: heigh * .2,

                    ),


                    Text(
                      'Add Program',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 24),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                    //   child: DropdownButtonFormField2(
                    //
                    //
                    //     //dropdownColor: AppColors.kPrimaryColor,
                    //
                    //     decoration: InputDecoration(
                    //       fillColor: AppColors.whiteColor,
                    //
                    //
                    //       //Add isDense true and zero Padding.
                    //       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    //       isDense: true,
                    //       contentPadding: EdgeInsets.zero,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(
                    //           color: AppColors.kTextColor,
                    //
                    //         )
                    //       ),
                    //
                    //       //Add more decoration as you want here
                    //       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    //     ),
                    //     isExpanded: true,
                    //     hint: const Text(
                    //       'Select program',
                    //       style: TextStyle(fontSize: 14),
                    //     ),
                    //     items: ProgramController.ProgramItems
                    //         .map((item) => DropdownMenuItem<String>(
                    //       value: item,
                    //       child: Text(
                    //         item,
                    //         style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 22)
                    //       ),
                    //     ))
                    //         .toList(),
                    //     validator: (value) {
                    //       if (value == null) {
                    //         return 'Please select gender.';
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (value) {
                    //       //Do something when changing the item if you want.
                    //
                    //         ProgramController.Select = value;
                    //     setState(() {
                    //       visibility= true;
                    //     });
                    //
                    //
                    //     },
                    //     onSaved: (value) {
                    //       ProgramController.selectedValueProgram = value;//.toString() as RxString?;
                    //     },
                    //     buttonStyleData: const ButtonStyleData(
                    //       height: 60,
                    //       padding: EdgeInsets.only(left: 20, right: 10),
                    //     ),
                    //     iconStyleData: const IconStyleData(
                    //       icon: Icon(
                    //         Icons.arrow_drop_down,
                    //         color: Colors.black45,
                    //       ),
                    //       iconSize: 30,
                    //     ),
                    //     dropdownStyleData: DropdownStyleData(
                    //       decoration: BoxDecoration(color: AppColors.kPrimaryColor,
                    //         borderRadius: BorderRadius.circular(15),
                    //         border: Border.all(color: AppColors.kTextColor)
                    //       ),
                    //     ),
                    //   ),
                    // ),
                //    if (ProgramController.Select == "Other")
                    const SizedBox(height: 10,),

                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InputTextField(
                        Color: Colors.black,
                        myController: ProgramController.ProgramController.value,
                        focusNode: ProgramFocusNode,
                        onFiledSubmittedValue: (Value) {
                          // Utils.fieldFocus(
                          // context, NameFocusNode, FatherNameFocusNode);
                        },
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your other Program.';
                          } else if (value.contains('@')) {
                            return 'Please don\'t use the @ char.';
                          }
                          return null;
                        },
                        KeyBoardType: TextInputType.name,
                        enable: true,
                        hint: 'Program...',
                        obscureText: false,
                        onChanged: (value){
                          ProgramController.Select = value.toString();
                        },
                      ),

                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: RoundButton(
                        title: "Add",
                        onPrass: () async {



                          if (ProgramController.Select != null){

                          if (ProgramController.remainingSeconds.value == 30){
                            ProgramController.AddNewProgram(context);
                            ProgramController. startTimer();
                          }else if(ProgramController.remainingSeconds.value == 0 ) {
                            ProgramController.refreshTimer();
                            ProgramController. startTimer();
                            ProgramController.AddNewProgram(context);

                          }else{
                            Get.snackbar("Exception", "A few second wait");

                          }}else{
                            Get.snackbar("Exception", "Program is not Select.");
                          }
                        },
                        color: AppColors.ButtonColor,
                        loading: ProgramController.Loading.value,
                      ),
                    ),

                    Obx(() => Text(
                      //'$ProgramController.remainingSeconds',
                     ProgramController.remainingSeconds.value.toString(),

                      style: TextStyle(fontSize: 50),
                    )),



                  ],
                ),
              ),
              IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProgramScreen()));
              }, icon: Icon(Icons.arrow_back))
            ],
          ),
        ),
      ),
    );
  }
}








