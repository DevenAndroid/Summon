import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/add_address_repository.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resources/app_theme.dart';
import '../controller/GetSaveAddressController.dart';
import '../controller/MyAddress_controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';
import 'Update_Address_Screen.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);
  static var addNewCardPage = "/addNewCardPage";

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  TextEditingController nameOnCardController=TextEditingController();
  TextEditingController cardNumberController=TextEditingController();
  TextEditingController ccvController=TextEditingController();
  TextEditingController expiryController=TextEditingController();

  final _formKey=GlobalKey<FormState>;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leadingWidth: AddSize.size20 * 2.3,
          backgroundColor: Color(0xffF9F9F9),
          centerTitle: true,
          title: Text(
            "Add New Card",
            style: GoogleFonts.ibmPlexSansArabic(
                color:Color(0xff000000),
                fontSize:
                AddSize
                    .font20,
                fontWeight:
                FontWeight
                    .w500),
          ),
          leading: Padding(
            padding: EdgeInsets.only(right: AddSize.padding10),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.BACKICON,
                  height: AddSize.size20,
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: AssetImage(AppAssets.scanner)),
            )
          ],
        ),
        // backAppBar(title: "My Address", context: context),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                SizedBox(
                height: height * .01,
                ),
                  SizedBox(
                    height: height * .08,
                    child: TextField(
                      maxLines: 3,
                      controller: nameOnCardController,
                      style: const TextStyle(fontSize: 17),
                      // textAlignVertical: TextAlignVertical.center,
                      // textInputAction: TextInputAction.n,
                      onSubmitted: (value) => {},
                      decoration: InputDecoration(
                        filled: true,

                        border:  OutlineInputBorder(
                            borderSide:BorderSide(color: Color(0xffC0CCD4)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Color(0xffC0CCD4)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Color(0xffC0CCD4)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))
                        ),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: width * .03,
                            vertical: height * .02),
                        hintText: 'Name on card',
                        hintStyle: GoogleFonts.ibmPlexSansArabic(
                            fontSize: AddSize.font16,
                            color: Color(0xffACACB7),
                            fontWeight: FontWeight.w700),

                        // prefixIcon: IconButton(
                        //   onPressed: () {
                        //     // Get.to(const SearchScreenData());
                        //
                        //   },
                        //   icon: const Icon(
                        //     Icons.place_rounded,
                        //     color: Color(0xffD3D1D8),
                        //     size: 30,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  SizedBox(
                    height: height * .08,
                    child: TextField(
                      maxLines: 3,
                      controller: cardNumberController,
                      style: const TextStyle(fontSize: 17),
                      // textAlignVertical: TextAlignVertical.center,
                      // textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) => {},
                      decoration: InputDecoration(
                        filled: true,

                        border:  OutlineInputBorder(
                            borderSide:BorderSide(color: Color(0xffC0CCD4)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Color(0xffC0CCD4)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Color(0xffC0CCD4)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))
                        ),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: width * .03,
                            vertical: height * .02),
                        hintText: 'Card number',
                        hintStyle: GoogleFonts.ibmPlexSansArabic(
                            fontSize: AddSize.font16,
                            color: Color(0xffACACB7),
                            fontWeight: FontWeight.w700),

                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            height: 35,
                            width: 35,
                            image: AssetImage(
                              AppAssets.paymentCardIcon
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * .08,
                          child: TextField(
                            maxLines: 3,
                            controller: expiryController,
                            style: const TextStyle(fontSize: 17),
                            // textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) => {},
                            decoration: InputDecoration(
                              filled: true,

                              border:  OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: width * .03,
                                  vertical: height * .02),
                              hintText: 'Expires',
                              hintStyle: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: AddSize.font16,
                                  color: Color(0xffACACB7),
                                  fontWeight: FontWeight.w700),

                              // prefixIcon: IconButton(
                              //   onPressed: () {
                              //     // Get.to(const SearchScreenData());
                              //
                              //   },
                              //   icon: const Icon(
                              //     Icons.place_rounded,
                              //     color: Color(0xffD3D1D8),
                              //     size: 30,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: height * .08,
                          child: TextField(
                            maxLines: 3,
                            controller: ccvController,
                            style: const TextStyle(fontSize: 17),
                            // textAlignVertical: TextAlignVertical.center,
                            // textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) => {},
                            decoration: InputDecoration(
                              filled: true,

                              border:  OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Color(0xffC0CCD4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: width * .03,
                                  vertical: height * .02),
                              hintText: 'CVV',
                              hintStyle: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: AddSize.font16,
                                  color: Color(0xffACACB7),
                                  fontWeight: FontWeight.w700),

                              // prefixIcon: IconButton(
                              //   onPressed: () {
                              //     // Get.to(const SearchScreenData());
                              //
                              //   },
                              //   icon: const Icon(
                              //     Icons.place_rounded,
                              //     color: Color(0xffD3D1D8),
                              //     size: 30,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: AppTheme.primaryColor.withOpacity(.80),
                  minimumSize:
                  const Size(double.maxFinite, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              child: Text(
                "Save",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                    color: AppTheme.backgroundcolor,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16),
              )),
        ),
      ),

    );
  }
}
