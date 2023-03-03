import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';

class AdminResponse extends StatefulWidget {
  const AdminResponse({Key? key}) : super(key: key);
  static var adminResponse = "/adminResponse";

  @override
  State<AdminResponse> createState() => _AdminResponseState();
}

class _AdminResponseState extends State<AdminResponse> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Driver Information", context: context),
        body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding20,vertical: AddSize.padding20),
          child: Text("data"),
        ),
    );
  }
}
