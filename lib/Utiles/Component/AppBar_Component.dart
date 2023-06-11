


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Admin/Admin_Login.dart';
import '../color.dart';






class AppBarComponent extends StatefulWidget {
  String Title;
 AppBarComponent({Key? key, required this.Title}) : super(key: key);

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  void initState()  {
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
  String? ProfileImage, AcademyName, MdName, Email, MakeDate,Logo;
  Future<void> UsersData () async {
    final Uid = FirebaseAuth.instance.currentUser!.uid;
    final Data = await FirebaseDatabase.instance.ref().child("Users")
        .child(Uid.toString()).get();
    setState(() {

      ProfileImage = Data.child("Profile").value.toString();
      AcademyName = Data.child("Academy Name").value.toString();
      MdName = Data.child("Md Name").value.toString();
      Email = Data.child("Email").value.toString();
      MakeDate = Data.child("Now Time").value.toString();
      Logo = Data.child("Logo").value.toString();

    });
  }

  late final selectedItem ;
  bool _isBold = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kPrimaryColor,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                //color: Colors.red,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black)
                ),
                child: InkWell(
                  onTap: (){
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> Scaffold(
                          backgroundColor: AppColors.kPrimaryColor,
                          body: Center(child: Image.network(Logo.toString(),fit: BoxFit.cover,width: 300,height: 300,)),
                        )));
                    },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: 

                    Image.network(
                      Logo.toString()
                    , fit: BoxFit.cover,
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
                      errorBuilder: (context, url, error) => new Icon(Icons.error),
                    ),
                  ),
                ),width: 70,height:70,),

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
                    child:  Text(widget.Title,textAlign: TextAlign.center,
                      style: Theme.of(context)
                        .textTheme.subtitle1!.copyWith(fontSize: 28),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: (){

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Scaffold(
                            backgroundColor: AppColors.kPrimaryColor,
                            body: Center(child: Image.network(ProfileImage.toString(),fit: BoxFit.cover,width: 300,height: 300,)),
                          )));
                    },

                    child: Container(
                      //color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black)
                      ),width: 50,height:50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                        Image.network(ProfileImage.toString()
                          , fit: BoxFit.cover,
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

                          errorBuilder: (context, url, error) => new Icon(Icons.error),

                        ),
                      ),),
                  ),
                  PopupMenuButton(
                      icon: Icon(Icons.more_vert,color: Colors.black,),
                      color: AppColors.kPrimaryColor,
                      onSelected: (value) {
                        setState(() {
                          switch (value){
                            case 1:{selectedItem = Get.toNamed("/Profile");}
                            break;
                            case 2: {selectedItem = Get.defaultDialog(
                                backgroundColor: AppColors.kPrimaryColor,
                                title:  'Log out?',

                                confirm: TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  auth.signOut().then((value) => {
                                    Get.snackbar('Log Out', "You'r account is logout."),
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AdminLogin())),

                                  }).onError((error, stackTrace) => {

                                 Get.snackbar('Error', error.toString()),


                                  });
                                }, child: Text('Log Out',
                                  style: Theme.of(context).textTheme.subtitle1,)),
                                cancel: TextButton(onPressed: (){
                                  Navigator.pop(context);





                                }, child: Text('Cancel',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.alertColor),)),
                              middleText: 'Are you sure want to log out?'


                            );
                            }
                            break;

                          // case 3:{selectedItem = value;}
                          // break;
                          // case 4:{selectedItem = value;}
                          // break;
                          }

                        });

                        Navigator.pushNamed(context, value.toString());
                      }, itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )),
                      PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )),


                    ];
                  }),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
