class VendorBankDetailsModel {
  bool? status;
  String? message;
  Data? data;

  VendorBankDetailsModel({this.status, this.message, this.data});

  VendorBankDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null && json['data'].toString() != "[]" ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? bank;
  String? accountName;
  String? accountNo;
  String? ifscCode;

  Data({this.id, this.bank, this.accountName, this.accountNo, this.ifscCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bank;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    return data;
  }
}
