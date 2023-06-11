

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils.dart';
import '../color.dart';
import 'Profile_Controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController ProfileScreen = Get.put(ProfileController());

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    UsersData();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    UsersData();
  }

  String? ProfileImage , AcademyName ,
      MdName , Email , MakeDate, Logo;

  Future<void> UsersData() async {
    final Uid = FirebaseAuth.instance.currentUser!.uid;
    final Data = await FirebaseDatabase.instance
        .ref()
        .child("Users")
        .child(Uid.toString())
        .get();
    setState(() {
      ProfileImage = Data.child("Profile").value.toString();
      AcademyName = Data.child("Academy Name").value.toString();
      MdName = Data.child("Md Name").value.toString();
      Email = Data.child("Email").value.toString();
      MakeDate = Data.child("Now Time").value.toString();
      Logo = Data.child("Logo").value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            if (AcademyName == null)
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.kTextColor,
                ),
              )
            else
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "Profile",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                   ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Card(
                          color:AppColors.kPrimaryColor,

                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(Logo.toString(),
                                width: double.infinity,height: 250,fit: BoxFit.cover,),
                              Center(
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Card(color: AppColors.kPrimaryColor,
                                      elevation: 50,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100.0),
                                        side: BorderSide(
                                            color: AppColors.kTextColor, width: 2),
                                      ),
                                      child: ClipOval(
                                        child:
                                        Image.network(
                                          ProfileImage.toString(),
                                          // child: Image.file(File(ProfileImage.toString()),
                                          height: 140, width: 140, fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: AppColors.kPrimaryColor,
                                              width: 140,
                                              height: 140,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.kTextColor,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Card(

                                        color: AppColors.kPrimaryColor,
                                        elevation: 50,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100.0),
                                          side: BorderSide(
                                              color: AppColors.kTextColor, width: 2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              customButton: const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 28,
                                                color: AppColors.kTextColor,
                                              ),
                                              items: [
                                                ...MenuItems.firstItems.map(
                                                  (item) => DropdownMenuItem<MenuItem>(
                                                    value: item,
                                                    child: MenuItems.buildItem(item),
                                                  ),
                                                ),
                                                const DropdownMenuItem<Divider>(
                                                    enabled: false, child: Divider()),
                                                ...MenuItems.secondItems.map(
                                                  (item) => DropdownMenuItem<MenuItem>(
                                                    value: item,
                                                    child: MenuItems.buildItem(item),
                                                  ),
                                                ),
                                              ],
                                              onChanged: (value) {
                                                MenuItems.onChanged(
                                                    context, value as MenuItem);
                                              },
                                              dropdownStyleData: DropdownStyleData(
                                                width: 160,
                                                padding:
                                                    const EdgeInsets.symmetric(vertical: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: AppColors.kPrimaryColor,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(0, 8),
                                              ),
                                              menuItemStyleData: MenuItemStyleData(
                                                customHeights: [
                                                  ...List<double>.filled(
                                                      MenuItems.firstItems.length, 48),
                                                  8,
                                                  ...List<double>.filled(
                                                      MenuItems.secondItems.length, 48),
                                                ],
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: InkWell(
                            onTap: (){
                              ProfileScreen.getImagegalery("Logo");
                            },
                              child: Icon(Icons.image)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        elevation: 50,
                        color: AppColors.kPrimaryColor,
                        child: ListTile(
                          title: Text("Academy Name"),
                          trailing: Text(AcademyName.toString()),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      color: AppColors.kPrimaryColor,
                      child: ListTile(
                        title: Text("MD Name"),
                        trailing: Text(MdName.toString()),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      color: AppColors.kPrimaryColor,
                      child: ListTile(
                        title: Text("Email"),
                        trailing: Text(Email.toString()),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      color: AppColors.kPrimaryColor,
                      child: ListTile(
                        title: Text("Data of Make"),
                        trailing: Text(Utils.getHumanReadableDate(MakeDate)),
                      ),
                    ),
                  ],
                ),
              ),
            InkWell(
                onTap: () {
                  Get.back();
                  // Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 28,
                )),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    Camera,
  ];
  static const List<MenuItem> secondItems = [Gallery];

  static const Camera =
      MenuItem(text: 'Camera', icon: Icons.camera_alt_outlined);

  static const Gallery = MenuItem(text: 'Gallery', icon: Icons.image);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    ProfileController ProfileScreen = Get.put(ProfileController());

    switch (item) {
      case MenuItems.Camera:
        ProfileScreen.getImageCamera("Profile");
        //Do something
        break;
      case MenuItems.Gallery:
        ProfileScreen.getImagegalery("Profile");
        //Do something
        break;
    }
  }






}
