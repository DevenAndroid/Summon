class CheckOutDataModel {
  bool? status;
  String? message;
  Data? data;

  CheckOutDataModel({this.status, this.message, this.data});

  CheckOutDataModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic surcharge;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  dynamic couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  dynamic  user;
  dynamic  vendor;
  Null? driver;
  Address? address;
  String? orderType;
  String? deliveryStatus;
  List<OrderItems>? orderItems;
  String? placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.surcharge,
        this.tax,
        this.deliveryCharges,
        this.packingFee,
        this.tipAmount,
        this.couponDiscount,
        this.commissionDriver,
        this.commissionAdmin,
        this.grandTotal,
        this.user,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    surcharge = json['surcharge'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    tipAmount = json['tip_amount'];
    couponDiscount = json['coupon_discount'];
    commissionDriver = json['commission_driver'];
    commissionAdmin = json['commission_admin'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor = json['vendor'] != null ? User.fromJson(json['vendor']) : null;
    driver = json['driver'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['surcharge'] = surcharge;
    data['tax'] = tax;
    data['delivery_charges'] = deliveryCharges;
    data['packing_fee'] = packingFee;
    data['tip_amount'] = tipAmount;
    data['coupon_discount'] = couponDiscount;
    data['commission_driver'] = commissionDriver;
    data['commission_admin'] = commissionAdmin;
    data['grand_total'] = grandTotal;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    data['driver'] = driver;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic walletBalance;
  dynamic earnedBalance;
  String? name;
  String? phone;
  String? email;
  int? otp;
  String? profileImage;
  String? latitude;
  String? longitude;
  String? location;
  Null? defaultAddress;
  String? referalCode;
  Null? deviceToken;
  Null? deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  Null? emailVerifiedAt;
  int? status;
  int? isProfileComplete;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class Address {
  int? id;
  int? userId;
  String? latitude;
  String? longitude;
  String? location;
  String? flatNo;
  String? street;
  String? landmark;
  String? addressType;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.street,
        this.landmark,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    street = json['street'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['flat_no'] = flatNo;
    data['street'] = street;
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class OrderItems {
  dynamic id;
  dynamic productId;
  String? productName;
  dynamic variantId;
  dynamic price;
  String? itemQty;
  dynamic qty;
  dynamic totalPrice;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.variantId,
        this.price,
        this.itemQty,
        this.qty,
        this.totalPrice});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    itemQty = json['item_qty'];
    qty = json['qty'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['variant_id'] = variantId;
    data['price'] = price;
    data['item_qty'] = itemQty;
    data['qty'] = qty;
    data['total_price'] = totalPrice;
    return data;
  }
}
