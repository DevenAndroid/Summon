// To parse this JSON data, do
//
//     final removeCartItemModel = removeCartItemModelFromJson(jsonString);

import 'dart:convert';

RemoveCartItemModel removeCartItemModelFromJson(String str) =>
    RemoveCartItemModel.fromJson(json.decode(str));

String removeCartItemModelToJson(RemoveCartItemModel data) =>
    json.encode(data.toJson());

class RemoveCartItemModel {
  RemoveCartItemModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<dynamic>? data;

  RemoveCartItemModel copyWith({
    bool? status,
    String? message,
    List<dynamic>? data,
  }) =>
      RemoveCartItemModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RemoveCartItemModel.fromJson(Map<String, dynamic> json) =>
      RemoveCartItemModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
