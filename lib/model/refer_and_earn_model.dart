class ReferAndEarnModel {
  bool? status;
  String? message;
  Data? data;

  ReferAndEarnModel({this.status, this.message, this.data});

  ReferAndEarnModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? referCode;
  String? referAmount;

  Data({this.referCode, this.referAmount});

  Data.fromJson(Map<String, dynamic> json) {
    referCode = json['referCode'];
    referAmount = json['referAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referCode'] = referCode;
    data['referAmount'] = referAmount;
    return data;
  }
}
