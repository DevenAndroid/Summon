import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/category_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';

Future<CategoryModel> categoryData({page, pagination, BuildContext? context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  if (context != null) {
    Overlay.of(context).insert(loader);
  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response =
      await http.get(Uri.parse("${ApiUrl.categoriesUrl}?page=$page&pagination=$pagination"), headers: headers);
  Helpers.hideLoader(loader);
  print("<<<<<<<CategoryData from repository=======>${response.body}");
  if (response.statusCode == 200) {
    print("<<<<<<<CategoryData from repository=======>${response.body}");
    return CategoryModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
