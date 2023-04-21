import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';

import '../repositories/signup_repo.dart';
import '../resources/app_theme.dart';
import '../widgets/commonTextField.dart';
import '../widgets/dimensions.dart';
import 'Otp_Screen.dart';
import 'loginScreen2.dart';
class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);
  static var loginScreen1 = '/loginScreen1';
  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/Ellipse126.png',height: 80,),
                  Image.asset('assets/images/Ellipse127.png',height: 75,width: 165,),
                  Padding(
                    padding: const EdgeInsets.only(left: 335),
                    child: Image.asset('assets/images/Ellipse128.png',height: 70,),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25,),
                    AddText(text: 'Sign Up',fontWeight: FontWeight.w600,fontSize: 36,color: Colors.black,),
                    SizedBox(height: 30,),
                    Text('Full Name',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: AppTheme.loginTextColor),),
                    SizedBox(
                      height: AddSize.size5,
                    ),
                    CommonTextFieldWidget(
                      controller:  nameController,
                      hint: 'Enter Your name',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      //maxLength: 10,
                      bgColor: AppTheme.loginTextColor,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText:
                            'Please Enter name '),
                        // PatternValidator(r'^[0-9]',
                        //     errorText: 'Only digits are allow'),
                        // MinLengthValidator(10,
                        //     errorText:
                        //         'Phone number must be at list 10 digit'),
                        // MaxLengthValidator(10,
                        //     errorText:
                        //         'Phone number is not greater then 10 digit'),
                      ]),
                    ),
                    SizedBox(
                      height: AddSize.size5,
                    ),
                    Text('Email',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: AppTheme.loginTextColor),),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    CommonTextFieldWidget(
                      controller: emailController,
                      hint: 'Enter Your Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      //maxLength: 10,
                      bgColor: AppTheme.loginTextColor.withOpacity(0.5),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText:
                            'Please Enter email '),
                        // PatternValidator(r'^[0-9]',
                        //     errorText: 'Only digits are allow'),
                        // MinLengthValidator(10,
                        //     errorText:
                        //         'Phone number must be at list 10 digit'),
                        // MaxLengthValidator(10,
                        //     errorText:
                        //         'Phone number is not greater then 10 digit'),
                      ]),
                    ),
                    SizedBox(
                      height: AddSize.size5,
                    ),

                    Text('Password',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: AppTheme.loginTextColor),),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    CommonTextFieldWidget(
                      controller: passwordController,
                      //obscureText: obscureText,
                      hint: 'Password',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      bgColor: AppTheme.loginTextColor.withOpacity(0.5),
                      suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                              : const Icon(
                            Icons.visibility,
                            // color: Colors.red,
                            color: Color(0xFFFFA629),
                          )),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Please enter your password'),
                        MinLengthValidator(8,
                            errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                        PatternValidator(
                            r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                            errorText: "Password must be at least with 1 special character & 1 numerical"),
                      ]),
                    ),
                    SizedBox(
                      height: AddSize.size5,
                    ),
                    Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: AppTheme.loginTextColor),),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    CommonTextFieldWidget(
                      controller: confirmPasswordController,
                      //obscureText: obscureText,
                      hint: 'Confirm Password',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      bgColor: AppTheme.loginTextColor.withOpacity(0.5),
                      suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                              : const Icon(
                            Icons.visibility,
                            // color: Colors.red,
                            color: Color(0xFFFFA629),
                          )),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Please enter your password'),
                        MinLengthValidator(8,
                            errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                        PatternValidator(
                            r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                            errorText: "Password must be at least with 1 special character & 1 numerical"),
                      ]),
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            signup(
                           name:    nameController.text,
                             email:  emailController.text,
                             password:  passwordController.text,
                              confirmPassword:  confirmPasswordController.text
                                ).then((value1) => {
                               if(value1.status == true){
                                 showToast(value1.message.toString()),
                                Get.toNamed(LoginScreen2.loginScreen2)
                               }
                               else{
                                showToast(value1.message.toString()),
                               }
                            });


                           // Get.toNamed(LoginScreen2.loginScreen2);
                          }
                          //var fcmToken =
                         // await FirebaseMessaging.instance.getToken();
                          // if (_formKey.currentState!.validate() &&
                          //     _isValue == true) {
                          //   createLogin(userPoneNo:phoneNumberController.text,
                          //       referalCode:referralCodeController.text, context:context, fcmToken: fcmToken!)
                          //       .then((value) async {
                          //     showToast(value.message.toString());
                          //     if (value.status == true) {
                          //       showToast(value.message.toString());
                          //       Get.toNamed(OtpScreen.otpScreen,
                          //           arguments: [
                          //             phoneNumberController.text,
                          //             value.data.toString()
                          //           ]);
                          //     }
                          //   });
                          // }
                          // else {
                          //   showValidation = true;
                          //   setState(() {});
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppTheme.primaryColor,
                            minimumSize: const Size(double.maxFinite, 60),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        child: Text('SIGN UP',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color: Colors.white),),
                    ),
                    SizedBox(
                      height: AddSize.size15,
                    ),
                    Center(child: InkWell(onTap: (){
                      Get.toNamed(LoginScreen2.loginScreen2);
                    },
                        child: Text('Already have an account?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppTheme.loginTextColor),))),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text('Or sign up with',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: AppTheme.loginTextColor),),
                        SizedBox(width: 10,),
                        Container(
                          height: 1,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(onTap: (){},
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset('assets/images/superg.png',height: 30,width: 30,),
                                SizedBox(width: 20,),
                                AddText(text: 'GOOGLE',fontSize: 13,fontWeight: FontWeight.w500,)
                              ],
                            ),
                          ),
                        ),
                        //Spacer(),
                        InkWell(onTap: (){},
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset('assets/images/Group.png',height: 30,width: 30,),
                                SizedBox(width: 20,),
                                AddText(text: 'APPLE',fontSize: 13,fontWeight: FontWeight.w500,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
