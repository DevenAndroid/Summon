import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:fresh2_arrive/screens/loginScreen2.dart';
import 'package:fresh2_arrive/screens/vendor_screen/Add_vendor_product.dart';
import 'package:fresh2_arrive/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/onboardData.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import 'Onboarding_Data.dart';
import 'custum_bottom_bar.dart';

class OnBoardingScreenPage extends StatefulWidget {
  const OnBoardingScreenPage({Key? key}) : super(key: key);
  static var onBoarding = "/onBoarding";

  @override
  State<OnBoardingScreenPage> createState() => _OnBoardingScreenPageState();
}

class _OnBoardingScreenPageState extends State<OnBoardingScreenPage> {
  late PageController _pageController;
  final RxInt _pageIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                    itemCount: OnBoardingData.length,
                    controller: _pageController,
                    pageSnapping: true,
                    // physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex.value = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return OnboardContent(
                        pageController: _pageController,
                        indexValue: _pageIndex.value,
                        image: OnBoardingData[index].image.toString(),
                        title: OnBoardingData[index].title.toString(),
                        description: OnBoardingData[index].description.toString(),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool isActive;

  const CustomIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: isActive ? 35 : 15,
          height: 10,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppTheme.backgroundcolor),
              color:
              isActive ? Color(0xffFFC529) : Color(0xffFFC529).withOpacity(.40),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
        ));
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, description;
  final int indexValue;
  final PageController pageController;

  const OnboardContent(
      {Key? key,
        required this.pageController,
        required this.image,
        required this.title,
        required this.description,
        required this.indexValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Stack(
        children:[

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: height * .70,
              width: width,
              decoration: BoxDecoration(
                  image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.contain,)),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height * .42,
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...List.generate(
                            OnBoardData.length,
                                (index) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CustomIndicator(
                                isActive: index == indexValue,
                              ),
                            )),
                      ],
                    ),
                   SizedBox(height: height* .04,),
                   // const Spacer(),
                    // const Spacer(),
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     child: TextButton(
                    //         onPressed: () {
                    //           Get.offAllNamed(LoginScreen.loginScreen);
                    //         },
                    //         child: indexValue == 2
                    //             ? const SizedBox()
                    //             : Text(
                    //           "Skip",
                    //           textAlign: TextAlign.right,
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .headline5!
                    //               .copyWith(
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 20),
                    //         ))),
                    // SizedBox(
                    //   height: height * .08,
                    // ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alegreyaSans(fontStyle: FontStyle.italic,
                          fontSize: 36,
                          color: Color(0xff131A38),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style:
                       GoogleFonts.alegreyaSans(
                         height: 1.5,
                          fontSize: 17,
                          color: Color(0xff616772),
                          fontWeight: FontWeight.w400),
                    ),

                    SizedBox(
                      height: height * .06,
                    ),
                    Container(
                        height: height * .10,
                        width: width * .95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                            if (indexValue == 2) {
                              // Get.toNamed(LoginScreen.loginScreen);
                              // Get.toNamed(CustomNavigationBar.customNavigationBar);
                              Get.toNamed(WelcomeScreen.welcomeScreen);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: AppTheme.primaryColor.withOpacity(.80),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          child: Icon(Icons.arrow_forward,size: 40,)
                          // Image.asset(AppAssets.arrowIcon,height: 30,width: 30,),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    )
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
