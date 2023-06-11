
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utiles/Component/AppBar_Component.dart';
import '../../Utiles/Component/Home_Button.dart';
import '../../Utiles/Component/Input_Text_Filed.dart';
import '../../Utiles/color.dart';
import 'Time_List.dart';


class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  State<TimeSlotScreen> createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  final SearchController = TextEditingController();
  final SearchFocusNode = FocusNode();
  String Search = "";

  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarComponent(Title: 'Time Slot'),
            SizedBox(
              height: 10,
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
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Serial',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Time",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
            Expanded(
              child: TimeList(Search: Search,),

            ),
            HomeButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  AppColors.ButtonColor,
        onPressed: () {
          Get.toNamed("/AddTimeSlotScreen");
        },
        child: Icon(Icons.add,color: AppColors.whiteColor,),
      ),
    );
  }


}


