




import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

class ProfileController extends GetxController{

  final Uid = FirebaseAuth.instance.currentUser!.uid;
  final Data = FirebaseDatabase.instance.ref().child("Users");

  // final DataStore = Fire
  RxString ImagePath = ''.obs;
  Future getImageCamera(String Nods)async{

    final ImagePicker _picker= ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null){
      ImagePath.value = image.path.toString();
      ImageUpgrade(Nods);

    }
  }
  Future getImagegalery( String Nods)async{

    final ImagePicker _picker= ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null){
      ImagePath.value = image.path.toString();
      ImageUpgrade(Nods);
    }

  }


  void ImageUpgrade (String Nods) async{
    firebase_storge.Reference refStorge = firebase_storge.FirebaseStorage.instance
        .ref(Nods + FirebaseAuth.instance.currentUser!.uid);
    firebase_storge.UploadTask uploadTask =
    refStorge.putFile(File(ImagePath.value//.path
    ).absolute);
    await Future.value(uploadTask);
    final NewUrl = await refStorge.getDownloadURL();
    Data.child(Uid).update({
      Nods : NewUrl.toString()
    }).then((value) => {
      Get.snackbar(Nods, "Upgrade your "+Nods),
    }).onError((error, stackTrace) =>{
      Get.snackbar('Exception', error.toString()),
    });


  }


}