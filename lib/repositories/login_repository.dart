import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelLogIn> createLogin(
    String userPoneNo, String referalCode, BuildContext context) async {
  var map = <String, dynamic>{};

  map['phone'] = userPoneNo;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST PARAM ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrl.loginApi),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelLogIn.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
