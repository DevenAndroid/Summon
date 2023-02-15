import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Home_Search_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<HomeSerachModel> homeSearchRepo(String keyword) async {
  var map = <String, dynamic>{};
  map['keyword'] = keyword;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  print(map);

  try {
    final response = await http.post(Uri.parse(ApiUrl.homeSearchUrl),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      print("Homepage Search Data...${response.body}");
      return HomeSerachModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
