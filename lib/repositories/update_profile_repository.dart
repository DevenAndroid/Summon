import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/update_profile_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<UpdateProfileModel> editUserProfileRepo({
  mapData,
  required fieldName1,
  required File file1,
  required context,
}) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user =
        ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll(mapData);

    if (file1.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return UpdateProfileModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      return UpdateProfileModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    return UpdateProfileModel(message: "No Internet Access", status: false);
  } catch (e) {
    return UpdateProfileModel(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
