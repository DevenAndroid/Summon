import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/update_profile_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/resend_otp_model.dart';
import '../model/verify_otp_model.dart';

Future<UpdateProfileModel> updateProfile(
    emailAddress, name, profileImage, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  var map = <String, dynamic>{};
  map['name'] = name;
  map['email'] = emailAddress;
  map['profile_image'] = profileImage;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.updateProfileUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    print("<<<<<<<UpdateProfileData from repository=======>${response.body}");
    return UpdateProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
