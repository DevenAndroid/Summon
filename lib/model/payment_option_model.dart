class PaymentOptionModel {
  bool? status;
  String? message;
  Data? data;

  PaymentOptionModel({this.status, this.message, this.data});

  PaymentOptionModel.fromJson(Map<String, dynamic> json) {
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
  bool? cod;
  dynamic earnedBalance;

  Data({this.cod,this.earnedBalance});

  Data.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    earnedBalance = json['earned_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['earned_balance'] = earnedBalance;
    return data;
  }
}