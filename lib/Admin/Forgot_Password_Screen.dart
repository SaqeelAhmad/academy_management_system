
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utiles/Component/Input_Text_Filed.dart';
import '../Utiles/Component/Round_Button.dart';
import '../Utiles/color.dart';
import 'View_Modle/Forgot_Password_Controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController PasswordController =
      Get.put(ForgotPasswordController());

  final EmailFocusNode = FocusNode();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 10),
            child: InkWell(
              onTap: (){
                Get.back();
              },
                child: Icon(Icons.arrow_back)),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Forgot your password',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InputTextField(
                      Color: Colors.black,
                      myController: PasswordController.EmailController.value,
                      focusNode: EmailFocusNode,
                      onFiledSubmittedValue: (Value) {
                        // Utils.fieldFocus(
                        //     context, EmailFocusNode, PasswordFocusNode);
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
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                        ),
                        child: RoundButton(
                          title: "Send",
                          onPrass: () {
                            if (_formKey.currentState!.validate()) {
                              PasswordController.ForgotPasword();
                            }
                          },
                          color: AppColors.ButtonColor,
                          loading: PasswordController.loading.value,
                        ),
                      )),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
