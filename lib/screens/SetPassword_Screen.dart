import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/registration_form_textField.dart';
import 'Forgot_Password_Screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);
  static var setPasswordScreen = "/setPasswordScreen";
  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController oldPassController=TextEditingController();
  final TextEditingController newPassPassController=TextEditingController();
  final TextEditingController confirmPassController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  RxBool isOldPasswordShow=false.obs;
  RxBool isNewPasswordShow=false.obs;
  RxBool isConfrimPasswordShow=false.obs;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: -40,
                left: 0,
                right: -320,
                child: Container(
                  height: 150,
                  width: 150,
              child: Image.asset(AppAssets.BG1),
            )),
            Positioned(
                top: 20,
                left: -350,
                right: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(AppAssets.BG3),
                )),
            Positioned(
                top: -30,
                left: -180,
                right: 0,
                child: Container(
                  height: 130,
                  width: 130,
                  child: Image.asset(AppAssets.BG2),
                )),
            Positioned(
                top: 70,
                left: -300,
                right: 0,
                child: Container(
                  height: 45,
                  width: 45,
                  child: Image.asset(AppAssets.BACKICON),
                )),
            Positioned.fill(child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 35,right: 25,top: 40),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(height: 90,),
                          Text("Set Password", style: TextStyle(fontSize: 33, color:Color(0xff000000), fontWeight:FontWeight.w500 ),),
                        SizedBox(height: 7,),
                        Text("Enter your phone number to verify your\nSet Password", style: TextStyle(fontSize: 14, color:Color(0xff000000), fontWeight:FontWeight.w300 ),),
                        SizedBox(height: 30,),
                        Text("Old Password", style: TextStyle(fontSize: 16, color:Color(0xff909090), fontWeight:FontWeight.w400 ),),
                        SizedBox(height: 9,),
                        RegistrationTextField1(
                          obscureText: isOldPasswordShow.value,
                          hint: "Password",
                          controller: oldPassController,
                          validator:(value){
                                if(value!.isEmpty){
                                  return "Enter the Old Password";
                                }
                          },
                          suffix: GestureDetector(
                            onTap: () {
                              isOldPasswordShow.value =
                              !isOldPasswordShow.value;
                              setState(() {

                              });
                            },
                            child: Icon(
                                isOldPasswordShow.value
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye,
                                size: 18,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("New Password", style: TextStyle(fontSize: 16, color:Color(0xff909090), fontWeight:FontWeight.w400 ),),
                        SizedBox(height: 9,),
                        RegistrationTextField1(
                          obscureText: isNewPasswordShow.value,
                          hint: "Password",
                          controller: newPassPassController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password is required'),
                            MinLengthValidator(8,
                                errorText:
                                'Password must be at least 8 digits long'),
                            PatternValidator(
                                r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                errorText:
                                'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                          ]),

                          suffix: GestureDetector(
                            onTap: () {
                              isNewPasswordShow.value =
                              !isNewPasswordShow.value;
                              setState(() {

                              });
                            },
                            child: Icon(
                                isNewPasswordShow.value
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye,
                                size: 18,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Confirm New Password", style: TextStyle(fontSize: 16, color:Color(0xff909090),
                            fontWeight:FontWeight.w400 ),),
                        SizedBox(height: 9,),
                        RegistrationTextField1(
                          obscureText: isConfrimPasswordShow.value,
                          hint: "Password",
                          controller: confirmPassController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password is required'),
                            MinLengthValidator(8,
                                errorText:
                                'Password must be at least 8 digits long'),
                            PatternValidator(
                                r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                errorText:
                                'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                          ]),
                          suffix: GestureDetector(
                            onTap: () {
                              isConfrimPasswordShow.value =
                              !isConfrimPasswordShow.value;
                              setState(() {

                              });
                            },
                            child: Icon(
                                isConfrimPasswordShow.value
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye,
                                size: 18,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 45,),
                        ElevatedButton(
                            onPressed: () async {
                            },
                            style: ElevatedButton.styleFrom(
                                primary: AppTheme.primaryColor,
                                minimumSize: const Size(double.maxFinite, 60),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            child: const Text(
                              "Save Password",
                            )),
                        SizedBox(height: 18,),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("        Not remember your old password?"
                                ,style: TextStyle(fontSize: 15, color:Color(0xff1B233A),
                                fontWeight:FontWeight.w400 ),),
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: (){
                                Get.to(ForgotPasswordScreen());
                              },
                              child: Text("Forgot Password"
                                ,style: TextStyle(fontSize: 15, color:Color(0xffFE724C),
                                    fontWeight:FontWeight.w400,decoration: TextDecoration.underline),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
