

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/new_login_model.dart';
import '../resources/api_url.dart';

Future <LoginModel>  login({email,password}) async {

  try {
    var map = <String, dynamic>{};
    map ['email'] = email;
    map ['password'] = password;
    print(map);

    var header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",

    };

    final response = await http.post(Uri.parse(ApiUrl.loginUrl),
        body: jsonEncode(map), headers: header);
    print(response.body);
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return LoginModel.fromJson(jsonDecode(response.body));
    }

    else {
      return LoginModel.fromJson(jsonDecode(response.body));
    }
  }
  catch (e){
    throw Exception(e);
  }

}