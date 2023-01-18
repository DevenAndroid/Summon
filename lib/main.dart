import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.light(),
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      initialRoute: "/splashScreen",
      getPages: MyRouter.route,
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: AppTheme.primaryColor,
          scaffoldBackgroundColor: Color(0xffFFFFFF),
          // highlightColor: AppTheme.primaryColor,
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(AppTheme.primaryColor),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppTheme.primaryColor)),
    );
  }
}
