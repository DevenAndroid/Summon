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
  int? storeId;
  int? id;
  dynamic storeName;
  dynamic phone;
  dynamic businessId;
  String? latitude;
  String? longitude;
  List<dynamic>? storeCategory;
  String? storeImage;
  String? businessIdImage;
  String? remark;
  bool? status;

  Data(
      {this.storeId,
        this.id,
        this.storeName,
        this.phone,
        this.businessId,
        this.latitude,
        this.longitude,
        this.storeCategory,
        this.storeImage,
        this.businessIdImage,
        this.remark,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    id = json['id'];
    storeName = json['store_name'];
    phone = json['phone'];
    businessId = json['businessId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    storeCategory = json['store_category'].cast<dynamic>();
    // if (json['store_category'] != null) {
    //   storeCategory = <String>[];
    //   json['store_category'].forEach((v) {
    //     storeCategory!.add(new Null.fromJson(v));
    //   });
    // }
    storeImage = json['storeImage'];
    businessIdImage = json['business_id_image'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['phone'] = this.phone;
    data['businessId'] = this.businessId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.storeCategory != null) {
      // data['store_category'] =
      //     this.storeCategory!.map((v) => v!.toJson()).toList();
    }
    data['storeImage'] = this.storeImage;
    data['business_id_image'] = this.businessIdImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}
