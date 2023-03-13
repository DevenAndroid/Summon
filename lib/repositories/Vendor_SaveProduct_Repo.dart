import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> vendorSaveProductRepo({
  mapData,
  required fieldName1,
  required File file1,
  required context,
}) async {
  print(mapData);
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.vendorSaveProductUrl));
    //print("image part");
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
    print(request.fields);

    if (file1.path != "") {
      print("imge part");
      request.files.add(await multipartFile(fieldName1, file1));
    }

    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();

    String gg = await response.stream.bytesToString();
    log(gg);
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideLoader(loader);
      log(gg);
      return ModelCommonResponse.fromJson(jsonDecode(gg));
    } else {
      log(gg);
      return ModelCommonResponse.fromJson(jsonDecode(gg));
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
