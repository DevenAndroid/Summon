import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/new_signup_model.dart';
import '../resources/api_url.dart';

Future <NewSignupModel>  signup({name,email,password,confirmPassword}) async {

try {
  var map = <String, dynamic>{};

  map ['name'] = name;
  map ['email'] = email;
  map ['password'] = password;
  map ['confirm_password'] = confirmPassword;
  print(map);


  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",

  };

  final response = await http.post(Uri.parse(ApiUrl.signupUrl),
      body: jsonEncode(map), headers: header);

  print(response.body);
  log(response.statusCode.toString());
  log(response.body);

  if (response.statusCode == 200) {
    return NewSignupModel.fromJson(jsonDecode(response.body));
  }

  else {
    return NewSignupModel.fromJson(jsonDecode(response.body));
  }
}
  catch (e){
  throw Exception(e);
  }

}