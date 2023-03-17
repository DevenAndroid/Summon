class VendorInformationModel {
  bool? status;
  String? message;
  Data? data;

  VendorInformationModel({this.status, this.message, this.data});

  VendorInformationModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? storeImage;
  String? aadharNo;
  String? panNo;
  String? deliveryRange;
  String? bankStatement;
  String? panCardImage;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? storeName;
  String? remark;
  bool? status;

  Data(
      {this.id,
      this.storeImage,
      this.aadharNo,
      this.panNo,
      this.deliveryRange,
      this.bankStatement,
      this.panCardImage,
      this.aadharFrontImage,
      this.aadharBackImage,
      this.storeName,
      this.remark,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeImage = json['storeImage'];
    aadharNo = json['aadharNo'];
    panNo = json['panNo'];
    deliveryRange = json['delivery_range'];
    bankStatement = json['bank_statement'];
    panCardImage = json['pan_card_image'];
    aadharFrontImage = json['aadhar_front_image'];
    aadharBackImage = json['aadhar_back_image'];
    storeName = json['store_name'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeImage'] = storeImage;
    data['aadharNo'] = aadharNo;
    data['panNo'] = panNo;
    data['delivery_range'] = deliveryRange;
    data['bank_statement'] = bankStatement;
    data['pan_card_image'] = panCardImage;
    data['aadhar_front_image'] = aadharFrontImage;
    data['aadhar_back_image'] = aadharBackImage;
    data['store_name'] = storeName;
    data['remark'] = remark;
    data['status'] = status;
    return data;
  }
}
