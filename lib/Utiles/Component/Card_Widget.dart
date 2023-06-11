import 'package:flutter/material.dart';

import '../color.dart';

class CardWidget extends StatelessWidget {
  String title, value;
  CardWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kPrimaryColor,
      elevation: 50,
      child: ListTile(
        title: Text(title,style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 18
        ),),
        trailing: Text(value,style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: 14
        ),),
      ),
    );
  }
}