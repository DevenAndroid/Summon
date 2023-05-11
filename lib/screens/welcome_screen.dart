import 'dart:convert';
import 'dart:developer';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/social_login_repo.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/add_text.dart';
import 'custum_bottom_bar.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static var welcomeScreen = "/welcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  void initState() {
    super.initState();
    //googleLogin(context,"google",value.credential!.accessToken!);
  }
  @override

  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.welcomeIMG),
                fit: BoxFit.fill
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 34,top: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to", style: GoogleFonts.ibmPlexSansArabic(color:Color(0xff111719),fontWeight: FontWeight.w700,fontSize: 53),),
                  Text("Summon", style: GoogleFonts.ibmPlexSansArabic(color:AppTheme.primaryColor,fontWeight: FontWeight.w700,fontSize: 53),),
                  SizedBox(height: 5,),
                  Text("Say no to order fees",
                    style: GoogleFonts.ibmPlexSansArabic(color:Color(0xff30384F),fontWeight: FontWeight.w400,fontSize: 18),),
                 // SizedBox(height: 250,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Divider(
                  //         height: 5,
                  //         thickness: 2,
                  //         color: Colors.grey.shade300,
                  //       ),
                  //     ),
                  //     SizedBox(width: 7,),
                  //     Text(" sign in with", style: TextStyle(color:Color(0xff111719),fontWeight: FontWeight.w500,fontSize: 16),),
                  //     SizedBox(width: 7,),
                  //     Expanded(
                  //       child: Divider(
                  //         height: 5,
                  //         thickness: 2,
                  //         color: Colors.grey.shade300,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: height * .4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          signInWithGoogle();
                        },
                        child: Expanded(
                          child: Container(
                            height: 60,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 15,),
                                Image.asset('assets/images/superg.png',height: 35,width: 35,),
                                SizedBox(width: 8,),
                                Text("Sign in\nGoogle", style: GoogleFonts.ibmPlexSansArabic(color:Color(0xff000000),fontWeight: FontWeight.w700,fontSize: 12),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 25,),
                      InkWell(
                        onTap: (){

                        },
                        child: Expanded(
                          child: Container(
                            height: 60,
                            width: 140,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10)
                           ),
                            child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 15,),
                                    Image.asset(AppAssets.Apple,height: 35,width: 35,),
                                    SizedBox(width: 8,),
                                    Text("Sign in\nApple", style: GoogleFonts.ibmPlexSansArabic(color:Color(0xff000000),fontWeight: FontWeight.w700,fontSize: 12),),
                                  ],
                                ),

                          ),
                        ),
                      ),
                      //Spacer(),

                    ],
                  )

                ],
              ),
            ),
          ),
           Positioned.fill(child: IgnorePointer(
          ignoring: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,Color.fromARGB(0, 0, 0, 50)
                 // Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
        )),
          // Positioned(
          //   top: 12,
          //   right: -20,
          //   child: GestureDetector(
          //     onTap: (){
          //       Get.toNamed(CustomNavigationBar.customNavigationBar);
          //     },
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //
          //         Image.asset(AppAssets.skipImage,height: 120,width: 120),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    print("Token---------${googleAuth.accessToken}");
    final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log(value.credential!.accessToken!);
    print("this is login details .credential!.accessToken");
   // Get.to(CustomNavigationBar());

    googleLogin("google", value.credential!.accessToken!, context)
        .then((value) async {
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
       pref.setString('user_info', jsonEncode(value));
        print("USER INFORMATION...${pref.getString('user_info')}");

        showToast(value.message);
        Get.offAllNamed(CustomNavigationBar.customNavigationBar);
        // tokenData().then((value) async {
        //   SharedPreferences pref = await SharedPreferences.getInstance();
        //   pref.setString('token', jsonEncode(value));
        // });
      } else {
        showToast(value.message);
      }
    });
  }

  // login with apple
  loginWithApple() async {

    final appleProvider =
    AppleAuthProvider().addScope("email").addScope("fullName");
    await FirebaseAuth.instance
        .signInWithProvider(appleProvider)
        .then((value) async {
      log("Token -------${value.credential!.accessToken}");
      // socialLogin("apple", value.credential!.accessToken, context)
      //     .then((value1) async {
      //   if (value1.status == true) {
      //     SharedPreferences pref = await SharedPreferences.getInstance();
      //     pref.setString('user_info', jsonEncode(value1));
      //     showToast(value1.message);
      //     Get.offAllNamed(CustomNavigationBar.route);
      //     tokenData().then((value1) async {
      //       SharedPreferences pref = await SharedPreferences.getInstance();
      //       pref.setString('token', jsonEncode(value1));
      //     });
      //   } else {
      //     showToast(value1.message);
      //   }
      // });
    });
  }
}
