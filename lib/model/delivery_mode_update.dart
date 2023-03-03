class DeliveryModeUpdateModel {
  bool? status;
  String? message;
  Data? data;

  DeliveryModeUpdateModel({this.status, this.message, this.data});

  DeliveryModeUpdateModel.fromJson(Map<String, dynamic> json) {
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
  int? isDriver;
  int? isVendor;
  int? walletBalance;
  int? earnedBalance;
  dynamic name;
  String? phone;
  dynamic email;
  int? otp;
  dynamic profileImage;
  String? latitude;
  String? longitude;
  dynamic location;
  dynamic defaultAddress;
  String? referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  int? isDriverOnline;
  int? isVendorOnline;
  int? deliveryRange;
  int? selfDelivery;
  int? adminCommission;
  int? asDriverVerified;
  int? asVendorVerified;
  int? featuredStore;
  dynamic emailVerifiedAt;
  int? status;
  int? isProfileComplete;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.walletBalance,
        this.earnedBalance,
        this.name,
        this.phone,
        this.email,
        this.otp,
        this.profileImage,
        this.latitude,
        this.longitude,
        this.location,
        this.defaultAddress,
        this.referalCode,
        this.deviceToken,
        this.deviceId,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.adminCommission,
        this.asDriverVerified,
        this.asVendorVerified,
        this.featuredStore,
        this.emailVerifiedAt,
        this.status,
        this.isProfileComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    profileImage = json['profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_driver'] = isDriver;
    data['is_vendor'] = isVendor;
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['profile_image'] = profileImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['default_address'] = defaultAddress;
    data['referal_code'] = referalCode;
    data['device_token'] = deviceToken;
    data['device_id'] = deviceId;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['admin_commission'] = adminCommission;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['featured_store'] = featuredStore;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['is_profile_complete'] = isProfileComplete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
