import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:get/get.dart';
import '../model/onboardData.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static var onBoardingScreen = "/onBoardingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
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
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: OnBoardData.length,
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
                    image: OnBoardData[index].image.toString(),
                    title: OnBoardData[index].title.toString(),
                    description: OnBoardData[index].description.toString(),
                  );
                }),
          ),
        ],
      ),
    ));
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
          width: isActive ? 16 : 14,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppTheme.backgroundcolor),
              color:
                  isActive ? AppTheme.primaryColor : AppTheme.backgroundcolor,
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
    return Container(
        width: width,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const Spacer(),
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Get.offAllNamed(LoginScreen.loginScreen);
                      },
                      child: indexValue == 2
                          ? const SizedBox()
                          : Text(
                              "Skip",
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                            ))),
              SizedBox(
                height: height * .08,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: AppTheme.blackcolor, fontSize: 14),
              ),
              const Spacer(),
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
              SizedBox(
                height: height * .07,
              ),
              SizedBox(
                  height: height * .07,
                  width: width * .90,
                  child: ElevatedButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                        if (indexValue == 2) {
                          Get.toNamed(LoginScreen.loginScreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppTheme.primaryColor,
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      child: const Text(
                        "NEXT",
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              )
            ],
          ),
        ));
  }
}
