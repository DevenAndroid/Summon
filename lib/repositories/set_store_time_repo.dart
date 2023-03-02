import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Set_Store_Time_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<SetStoreTimeModel> setStoreTimeRepo(
  start_time,
  end_time,
) async {
  var map = <String, dynamic>{};
  map['start_time'] = start_time;
  map['end_time'] = end_time;

  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.storeAvailabilityUrl),
        body: jsonEncode(map), headers: headers);
    log("Set store time Repository...${response.body}");
    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      log("Set store time Repository..${response.body}");
      return SetStoreTimeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}