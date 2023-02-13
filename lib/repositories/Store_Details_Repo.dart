import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Store_Details_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<StoreDetailsModel> storeDetailsRepo() async {
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
  try {
    final response =
        await http.get(Uri.parse(ApiUrl.storeDetailsUrl), headers: headers);

    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      print("Store details Data...${response.body}");
      return StoreDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
