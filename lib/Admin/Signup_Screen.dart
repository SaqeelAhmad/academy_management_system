import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Utiles/Component/Input_Text_Filed.dart';
import '../Utiles/Component/Round_Button.dart';
import '../Utiles/Utils.dart';
import '../Utiles/color.dart';
import 'View_Modle/Signup_Controller.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController Signup = Get.put(SignupController());

  final AccademyFocusNode = FocusNode();
  final MdFocusNode = FocusNode();
  final EmailFocusNode = FocusNode();
  final PasswordFocusNode = FocusNode();
  final nullfocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // AccademyController.dispose();
    // MdController.dispose();
    // EmailController.dispose();
    // PasswordController.dispose();
    AccademyFocusNode.dispose();
    MdFocusNode.dispose();
    EmailFocusNode.dispose();
    PasswordFocusNode.dispose();
    nullfocusNode.dispose();
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(
                              "Register your Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 28),
                            ),
                          ),
                          ListTile(
                            title: Text("Academy Name"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InputTextField(
                              Color: Colors.black,
                              myController: Signup.AccademyController.value,
                              focusNode: AccademyFocusNode,
                              onFiledSubmittedValue: (Value) {
                                Utils.fieldFocus(
                                    context, AccademyFocusNode, MdFocusNode);
                              },
                              onValidator: (value) {},
                              KeyBoardType: TextInputType.name,
                              enable: true,
                              hint: 'Academy Name...',
                              obscureText: false,
                            ),
                          ),
                          ListTile(
                            title: Text("Md Name"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InputTextField(
                              Color: Colors.black,
                              myController: Signup.MdController.value,
                              focusNode: MdFocusNode,
                              onFiledSubmittedValue: (Value) {
                                Utils.fieldFocus(
                                    context, MdFocusNode, EmailFocusNode);
                              },
                              onValidator: (value) {},
                              KeyBoardType: TextInputType.name,
                              enable: true,
                              hint: 'Md Name...',
                              obscureText: false,
                            ),
                          ),
                          ListTile(
                            title: Text("Email"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InputTextField(
                              Color: Colors.black,
                              myController: Signup.EmailController.value,
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
                              PrefixIcon: const Icon(
                                Icons.email,
                                color: AppColors.kTextColor,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("Password"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InputTextField(
                                Color: Colors.black,
                                myController: Signup.PasswordController.value,
                                focusNode: PasswordFocusNode,
                                onFiledSubmittedValue: (newValue) {
                                  Utils.fieldFocus(
                                      context, PasswordFocusNode, nullfocusNode);
                                },
                                onValidator: (val) =>
                                    val.length < 6 ? 'Password too short.' : null,
                                KeyBoardType: TextInputType.emailAddress,
                                enable: true,
                                hint: 'Password',
                                obscureText: _obscureText,
                                // PrefixIcon: 0xe3b1,
                                PrefixIcon: const Icon(
                                  Icons.lock,
                                  color: AppColors.kTextColor,
                                ),
                                Suffix: GestureDetector(
                                  onTap: _toggle,
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        AppColors.kTextColor, //kTextColorSecondary,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: Obx(() =>  RoundButton(
                      title: 'Register',
                      onPrass: () {




                        Signup.Register(context);
                        if (_formKey.currentState!.validate()) {
                          Signup.Register(context);

                        }
                      },
                      loading: Signup.Loading.value,
                      color: AppColors.ButtonColor,
                    ),),
                  ),

                ],
              ),
            ),
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }
}
