import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/add_text.dart';

Locale locale = Locale('en','US');

class LanguageChangeScreen extends StatefulWidget {
  const LanguageChangeScreen({Key? key}) : super(key: key);
  static var languageChangeScreen = "/languageChangeScreen";


  @override
  State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
}

class _LanguageChangeScreenState extends State<LanguageChangeScreen> {

  RxString selectedLAnguage = "English".obs;

  // int? value;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    selectedLAnguage.value=locale==Locale('en','US') ? "English" : "عربي";
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        appBar: backAppBar(title: "Language".tr, context: context),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Radio<String>(
                          value: "English",
                          groupValue: selectedLAnguage.value,
                          onChanged: (value) {
                            locale=Locale('en','US');
                            Get.updateLocale(locale);
                            selectedLAnguage.value = value!;
                            setState(() {

                            });

                            print(selectedLAnguage);
                          }),
                      Text("English",
                        style: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000)),),

                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Radio<String>(
                          value: "عربي",
                          groupValue: selectedLAnguage.value,
                          onChanged: (value) {
                            locale=Locale('ar','AR');
                            Get.updateLocale(locale);
                            selectedLAnguage.value = value!;
                            setState(() {

                            });

                             print(selectedLAnguage);
                          }),
                      Text("عربي",
                        style: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000)),),


                    ],
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
