import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:fresh2_arrive/screens/SignUp_Screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../repositories/login_repo.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/commonTextField.dart';
import '../widgets/dimensions.dart';
import 'custum_bottom_bar.dart';
import 'loginScreen1.dart';
class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);
  static var loginScreen2 = '/loginScreen2';

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    SizedBox(height: 90,),
                    AddText(text: 'Login',fontWeight: FontWeight.w600,fontSize: 36,color: Colors.black,),
                    SizedBox(height: 40,),

                    Text('Email',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17,color: AppTheme.loginTextColor),),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    CommonTextFieldWidget(
                      controller: emailController,
                      hint: 'Enter Your email or phone',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      //maxLength: 10,
                      bgColor: AppTheme.loginTextColor.withOpacity(0.5),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText:
                            'Please Enter email or phone '),
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
                      height: AddSize.size20,
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
                      height: AddSize.size10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(onTap: (){},
                            child: Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: AppTheme.loginTextColor),)),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size40,
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            login(email: emailController.text,password: passwordController.text).then((value1) => {
                              showToast(value1.message.toString()),
                              Get.offAllNamed(CustomNavigationBar.customNavigationBar),

                            });
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
                        child: const Text('LOGIN',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17,color: Colors.white),),
                    ),
                    SizedBox(
                      height: AddSize.size25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppTheme.loginTextColor),),
                        SizedBox(width: 3,),
                        InkWell(onTap: (){
                          Get.toNamed(LoginScreen1.loginScreen1);
                        },
                            child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppTheme.primaryColor),)),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size30,
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
                      height: AddSize.size40,
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
