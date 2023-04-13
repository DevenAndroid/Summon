import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/verify_otp_model.dart';

Future<ModelVerifyOtp> verifyOtp(
    String userPoneNo, BuildContext context, data) async {
  var map = <String, dynamic>{};
  map['phone'] = userPoneNo;
  map['otp'] = data;

  print("otpData map$map");
  try {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.otpApi),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200 ||response.statusCode == 400) {
    print("<<<<<<<otpData from repository=======>${response.body}");
    return ModelVerifyOtp.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
  } catch (e) {
    throw Exception(e.toString());
  }
}
