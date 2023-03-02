import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_common_ressponse.dart';
import '../model/update_profile_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> driverRegistrationRepo({
  mapData,
  required fieldName1,
  required fieldName2,
  required fieldName3,
  required fieldName4,
  required fieldName5,
  required fieldName6,
  required File file1,
  required File file2,
  required File file3,
  required File file4,
  required File file5,
  required File file6,
  required context,
}) async {
  try {
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.driverRegisterUrl));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user =
    ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    request.headers.addAll(headers);
    request.fields.addAll(mapData);
    if (file1.path != "" && file2.path != "" && file3.path != "" && file4.path != "" && file5.path != "" && file6.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));
      request.files.add(await multipartFile(fieldName2, file2));
      request.files.add(await multipartFile(fieldName3, file3));
      request.files.add(await multipartFile(fieldName4, file4));
      request.files.add(await multipartFile(fieldName5, file5));
      request.files.add(await multipartFile(fieldName6, file6));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
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
