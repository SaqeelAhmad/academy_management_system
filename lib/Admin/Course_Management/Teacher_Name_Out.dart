

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Item {
  final String Id;
  final String Name;

  Item({required this.Id, required this.Name});
}


class Rollon {

 final String  Name;
  Rollon({required this.Name});
}


class Student {
  String key;
  int registerNo;

  Student({required this.registerNo, required this.key});

  Student.fromSnapshot( snapshot)
      : key = snapshot.key,
        registerNo = snapshot.value['registerNo'];

  Map<String, dynamic> toJson() {
    return {
      'registerNo': registerNo,
    };
  }
}



