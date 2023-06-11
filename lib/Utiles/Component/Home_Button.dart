


import 'package:flutter/material.dart';

import '../../Admin/Home_Screen.dart';
import '../color.dart';


class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,

      width: 120,
      decoration: BoxDecoration(
        color: AppColors.ButtonColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight:Radius.circular(100), ),
      ),
      child: Center(child: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(Icons.home,color:  AppColors.whiteColor,),
                ),
                Text("Home",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColors.whiteColor,fontSize: 24),),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
            },
          ),


        ],
      ),),
    );
  }
}
