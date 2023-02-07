import 'dart:convert';
import 'dart:io';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_profile_model.dart';

Future<ProfileModel> userProfileData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print(user.authToken);
  http.Response response =
      await http.get(Uri.parse(ApiUrl.userProfileUrl), headers: headers);
  if (response.statusCode == 200) {
    print("<<<<<<<UserProfileData from repository=======>${response.body}");
    return ProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
