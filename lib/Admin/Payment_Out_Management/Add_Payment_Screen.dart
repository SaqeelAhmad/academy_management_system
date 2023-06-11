

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Card_Widget.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Round_Button.dart';
import '../../Utiles/color.dart';
import 'Add_Payment_Controller.dart';
import 'Payment_Out_Screen.dart';


class AddPaymentScreen extends StatelessWidget {
  String Name, FName, CNIC, Mobile, Salary;
  AddPaymentScreen({Key? key,
  required this.Salary, required this.FName, required this.Name,
    required this.Mobile, required this.CNIC
  }) : super(key: key);

  final SearchController = TextEditingController();

  final SearchFocusNode = FocusNode();
  final AddPaymentController PaymentController= Get.put(AddPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SafeArea(child:
          Column(
            children: [
              AppBarComponent(Title: 'Add Salary',),
              Text("Salary Add Details",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 28
              ),),
              Container(child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      CardWidget(title: "Name", value: Name),
                      CardWidget(title: "Father Name", value: FName),
                      CardWidget(title: "CNIC", value: CNIC),
                      CardWidget(title: "Mobile", value: Mobile),
                      CardWidget(title: "Salary", value: "PR "+Salary),
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


                          items: PaymentController.MonthItems
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

                            PaymentController.SelectMonth = value;


                          },
                          onSaved: (value) {
                            PaymentController. SelectMonth = value;
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

                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: RoundButton(title: "Taken Salary", onPrass: (){
                          PaymentController.AddPayment(context, Name, FName, Mobile, CNIC, Salary);

                        },color: AppColors.ButtonColor,
                          loading: PaymentController.Loading.value,
                        ),
                      ),
                      SizedBox(height: 15,),


                    ],
                  ),
                ),
              ),),
              HomeButton(),
            ],
          ),
          ),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentOutScreen()));
          }, icon: Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}
