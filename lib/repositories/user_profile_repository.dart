import 'dart:convert';
import 'dart:io';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Social_Login_Model.dart';
import '../model/model_common_ressponse.dart';
import '../model/user_profile_model.dart';

Future<ProfileModel> userProfileData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  print("this is User details.....${user}");
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5N2UxY2E3Yy1lZTI0LTQxOTctYmZiYS1iNjE2YzNjZmQ4MjciLCJqdGkiOiJjNWNhNmZkZjYxNmE3M2U2MDhiOTE0YWE4NGM5YWU0MGQzYTY2OWFjNjIxN2U0ZDE0YTBkZmJhMmUwMTBlNzU3MWNhMTJmNTQxYTA0MzU5MCIsImlhdCI6MTY4MjUxMDQzMy43MTE1ODUsIm5iZiI6MTY4MjUxMDQzMy43MTE1ODksImV4cCI6MTcxNDEzMjgzMy43MDg3NDksInN1YiI6IjQzIiwic2NvcGVzIjpbXX0.lflwGuY1aYZEJ5YnoKjvxXyOCaDfPJMZwQEmZCu3COKdQb80cIsJwqQhn_SKSpvhh-R2W8uEwf33VxRSI_eumDCCe-LpKrLDk8U35qDn-1ybSO8ALxEWnNR0HNCvZIMC2yZasJYHCsajuk_glCqnGoj-o85FNTiKTbie3k4NvazMTB8V8-MZHwdPLcWST_LSgLf8279MI47qEasjqNKb3A9EGzt-2o0x5zOZleTEM7D2tkc0030NDXnt0AYfDG9CCkTSB5CnWHycUq_AZ6Mv18_yeLfkrlCVm3zT83hwYYXIA6m-9fotlW1Ijoo3jD11Yl33qbS91QoA1a0r4kOOv8da-zBvFRAVYPL7q6NBYcfHqZbWeyh0xv6T-kjaq2TW1wgk1nTaZDJEihhGSbDzBBtviEs5ySAbqoVJBrriPizmwssU2SCXaVotOSsYJWCSNZXxitVOYNXHInH0a-bA6l8D_2z4EvhO_5H64J7QNs6ZF_vSulmhY7qqv6aERdgQP_zlY2kLT_cYMKgyUKpPB_zdsI-vPm6ncuqxb_aFFX_Fjag9JGDRrWzTWgQJqYF4kvSenc4YpA6YwUZtCB6C3PyhS2LpKvfARsdEc2dULcrS7EA1gys9C_GzxFlSfWOUcXg9GXIL5SgJOv_lLFGzFB76qD5D_DMfzHf0cJQfiSs'

  };
  print("these are headers:: ${headers}");

 // print(user.authToken);
  http.Response response =
      await http.get(Uri.parse(ApiUrl.userProfileUrl), headers: headers);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    print("<<<<<<<UserProfileData from repository=======>${response.body}");
    return ProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
