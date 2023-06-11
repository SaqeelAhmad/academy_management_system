

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Round_Button.dart';

import '../../Utiles/color.dart';

import 'Add_Fess_Controller.dart';
import 'Fess_Screen.dart';

class AddFeeScreen extends StatelessWidget {
  String Name, FName, RollNo, Fess;
   AddFeeScreen({super.key,required this.Fess,
     required this.FName, required this.RollNo, required this.Name
   });

  final MonthsController = TextEditingController();
  final MonthsFocusNode = FocusNode();


  final NullFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final AddFessController FessController = Get.put(AddFessController());


  @override
  void dispose() {
    // TODO: implement dispose
   // super.dispose();

    MonthsController.dispose();
    MonthsFocusNode.dispose();


    NullFocusNode.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body:SafeArea(
          child: Column(children: [
            AppBarComponent(Title: 'Fee Add',),
            SizedBox(height: 10,),
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20 ,left: 20 ,),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("Fess Add Details",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 28
                          ),),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              
                              
                              CardWidget(title: "Name", value: Name),
                              CardWidget(title: "Father Name", value: FName),
                              CardWidget(title: "Roll No", value: RollNo),
                              CardWidget(title: "Fess", value: "PR "+Fess),


                              ListTile(title: Text('Months'),),
                              Padding(
                                padding: const EdgeInsets.only( bottom: 20, left: 15, right: 15),
                                child: DropdownButtonFormField2(


                                  //dropdownColor: AppColors.kPrimaryColor,

                                  decoration: InputDecoration(
                                    fillColor: AppColors.whiteColor,


                                    //Add isDense true and zero Padding.
                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: AppColors.kTextColor,

                                        )
                                    ),

                                    //Add more decoration as you want here
                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select Month',
                                    style: TextStyle(fontSize: 14),
                                  ),


                                  items: FessController.MonthItems
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                        item,
                                        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 22)
                                    ),
                                  ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select gender.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when changing the item if you want.

                                    FessController.SelectMonth = value;


                                  },
                                  onSaved: (value) {
                                    FessController.SelectMonth = value;
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 60,
                                    padding: EdgeInsets.only(left: 20, right: 10),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: AppColors.kTextColor)
                                    ),
                                  ),
                                ),
                              ),


                              SizedBox(height: 30,),
                              RoundButton(title: 'Pay',
                                onPrass: () {
                                 FessController.FessAdd(context, Name.toString(), FName.toString(), RollNo.toString(), Fess.toString());




                                },
                                color: AppColors.ButtonColor,),
                              SizedBox(height: 20,)

                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back))
                  ],
                ),
              ),
            ),),
            HomeButton(),
          ],),
        )
    );
  }
}

