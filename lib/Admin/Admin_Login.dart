

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Utiles/Component/Input_Text_Filed.dart';
import '../Utiles/Component/Round_Button.dart';
import '../Utiles/Utils.dart';
import '../Utiles/color.dart';
import 'Signup_Screen.dart';
import 'View_Modle/Admin_Login_Controller.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  AdminLoginController LoginController = Get.put(AdminLoginController());

  final EmailFocusNode = FocusNode();
  final PasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    EmailFocusNode.dispose();
    PasswordFocusNode.dispose();
  }

  // Initially password is obscure
  bool _obscureText = true;
  bool isChecked = false;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }




  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;

    return Scaffold(
      body: Container(
        height: height * 1,
        width: width,
        color: AppColors.kPrimaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Khan Academy\n Management\n System',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 32)),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'ADMIN LOGIN',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text(
                            'EMAIL',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        InputTextField(
                          Color: Colors.black,
                          myController: LoginController.EmailController.value,
                          focusNode: EmailFocusNode,
                          onFiledSubmittedValue: (Value) {
                            Utils.fieldFocus(
                                context, EmailFocusNode, PasswordFocusNode);
                          },
                          onValidator: (value) {
                            RegExp regex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                                r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                            if (value!.isEmpty) {
                              return 'Please enter email';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid email';
                              } else {
                                return null;
                              }
                            }
                          },
                          KeyBoardType: TextInputType.emailAddress,
                          enable: true,
                          hint: 'Email',
                          obscureText: false,
                          //PrefixIcon: 0xe3c3,
                          PrefixIcon: const Icon(Icons.email,color: AppColors.kTextColor,),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          onTap: (){

                          },
                          title: const Text(
                            'Password',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        InputTextField(
                            Color: Colors.black,
                            myController: LoginController.PasswordController.value,
                            focusNode: PasswordFocusNode,
                            onFiledSubmittedValue: (newValue) {},
                            onValidator: (val) =>
                                val.length < 6 ? 'Password too short.' : null,
                            KeyBoardType: TextInputType.emailAddress,
                            enable: true,
                            hint: 'Password',
                            obscureText: _obscureText,
                            // PrefixIcon: 0xe3b1,
                            PrefixIcon: const Icon(Icons.lock,
                              color: AppColors.kTextColor,
                            ),
                            Suffix: GestureDetector(
                              onTap: _toggle,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility ,
                                color: AppColors.kTextColor , //kTextColorSecondary,
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Obx(() =>
                      Padding(
                        padding: const EdgeInsets.only(right: 30,left: 30),
                        child: RoundButton(
                          color: AppColors.ButtonColor,
                          title: "Login",
                          onPrass: () {


                            if (_formKey.currentState!.validate()) {
                              LoginController.Login(
                                context,

                              );

                            }
                          },
                          loading: LoginController.loading.value,
                        ),
                      )),




                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed("/ForgotPassword");
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                  }, child:  Text("Don,t hava an account ?",style: Theme.of(context).textTheme.subtitle2,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
