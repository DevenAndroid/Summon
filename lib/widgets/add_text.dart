import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import 'dimensions.dart';

SizedBox addHeight(double size) => SizedBox(height: size);
SizedBox addWidth(double size) => SizedBox(width: size);

String? validateMobile(String? value) {
  if (value!.length != 10) {
    return 'Enter Mobile Number & must be of 10 digit';
  } else {
    return null;
  }
}

String? validateName(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Name';
  } else {
    return null;
  }
}

String? validateAdhar(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Adhar Number';
  } else {
    return null;
  }
}

String? validatePan(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Pan Number';
  } else {
    return null;
  }
}

String? validateMoney(String? money) {
  if (money!.isEmpty) {
    return 'Please add money';
  } else {
    return null;
  }
}

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.userActive,
      textColor: Colors.white,
      fontSize: 16.0);
}

AppBar backAppBar(
    {required title,
    required BuildContext context,
    String dispose = "",
    Color? backgroundColor = AppTheme.backgroundcolor,
    Color? textColor = Colors.black,
    Widget? icon,
    disposeController}) {
  return AppBar(
    // toolbarHeight: 60,
    elevation: 0,
    leadingWidth: AddSize.size20 * 1.6,
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w500, fontSize: 20, color: textColor),
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: AddSize.padding10),
      child: GestureDetector(
          onTap: () {
            Get.back();
            if (dispose == "dispose") {}
          },
          child: icon ??
              Image.asset(
                AppAssets.back,
                height: AddSize.size20,
              )),
    ),
  );
}

class AddText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final String? fontfamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? color;
  const AddText({
    Key? key,
    required this.text,
    this.fontSize = 0,
    this.fontWeight = FontWeight.w500,
    this.textAlign,
    this.textOverflow,
    this.decoration,
    this.color = Colors.black,
    this.height = 1,
    this.fontfamily,
    this.maxLines,
    this.letterSpacing,
    this.wordSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
          color: color == Colors.black ? AppTheme.userText : color,
          fontSize: fontSize == 0 ? AddSize.font14 : fontSize,
          decoration: decoration,
          height: height,
          letterSpacing: letterSpacing,
          fontFamily: fontfamily,
          wordSpacing: wordSpacing,
          fontWeight: fontWeight),
    );
  }
}
