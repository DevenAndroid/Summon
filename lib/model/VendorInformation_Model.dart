class VendorInformationModel {
  bool? status;
  String? message;
  Data? data;

  VendorInformationModel({this.status, this.message, this.data});

  VendorInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? storeName;
  String? phone;
  String? storeImage;
  String? address;
  String? location;
  String? latitude;
  String? longitude;
  String? aadharNo;
  String? panNo;
  String? deliveryRange;
  String? bankStatement;
  String? panCardImage;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? remark;
  bool? status;

  Data(
      {this.id,
        this.storeName,
        this.phone,
        this.storeImage,
        this.address,
        this.location,
        this.latitude,
        this.longitude,
        this.aadharNo,
        this.panNo,
        this.deliveryRange,
        this.bankStatement,
        this.panCardImage,
        this.aadharFrontImage,
        this.aadharBackImage,
        this.remark,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    phone = json['phone'];
    storeImage = json['storeImage'];
    address = json['address'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    aadharNo = json['aadharNo'];
    panNo = json['panNo'];
    deliveryRange = json['delivery_range'];
    bankStatement = json['bank_statement'];
    panCardImage = json['pan_card_image'];
    aadharFrontImage = json['aadhar_front_image'];
    aadharBackImage = json['aadhar_back_image'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['phone'] = this.phone;
    data['storeImage'] = this.storeImage;
    data['address'] = this.address;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['aadharNo'] = this.aadharNo;
    data['panNo'] = this.panNo;
    data['delivery_range'] = this.deliveryRange;
    data['bank_statement'] = this.bankStatement;
    data['pan_card_image'] = this.panCardImage;
    data['aadhar_front_image'] = this.aadharFrontImage;
    data['aadhar_back_image'] = this.aadharBackImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}
