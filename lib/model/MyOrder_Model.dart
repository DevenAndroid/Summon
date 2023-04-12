class MyOrdersModel {
  bool? status;
  String? message;
  List<Data>? data;

  MyOrdersModel({this.status, this.message, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? orderId;
  dynamic itemTotal;
  dynamic surcharge;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  CouponDiscount? couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  User? user;
  User? vendor;
  Driver? driver;
  Address? address;
  String? orderType;
  String? deliveryStatus;
  dynamic itemCount;
  List<OrderItems>? orderItems;
  dynamic image;
  dynamic placedAt;

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
      this.itemCount,
      this.orderItems,
      this.image,
      this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    surcharge = json['surcharge'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    tipAmount = json['tip_amount'];
    couponDiscount = json['coupon_discount'] != null
        ? new CouponDiscount.fromJson(json['coupon_discount'])
        : null;
    commissionDriver = json['commission_driver'];
    commissionAdmin = json['commission_admin'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor = json['vendor'] != null ? new User.fromJson(json['vendor']) : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    itemCount = json['item_count'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    image = json['image'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['surcharge'] = this.surcharge;
    data['tax'] = this.tax;
    data['delivery_charges'] = this.deliveryCharges;
    data['packing_fee'] = this.packingFee;
    data['tip_amount'] = this.tipAmount;
    if (this.couponDiscount != null) {
      data['coupon_discount'] = this.couponDiscount!.toJson();
    }
    data['commission_driver'] = this.commissionDriver;
    data['commission_admin'] = this.commissionAdmin;
    data['grand_total'] = this.grandTotal;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['delivery_status'] = this.deliveryStatus;
    data['item_count'] = this.itemCount;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class CouponDiscount {
  int? id;
  int? userId;
  String? couponCode;
  String? discountType;
  dynamic discountedPrice;
  dynamic createdAt;
  dynamic updatedAt;

  CouponDiscount(
      {this.id,
      this.userId,
      this.couponCode,
      this.discountType,
      this.discountedPrice,
      this.createdAt,
      this.updatedAt});

  CouponDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    couponCode = json['coupon_code'];
    discountType = json['discount_type'];
    discountedPrice = json['discounted_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['coupon_code'] = this.couponCode;
    data['discount_type'] = this.discountType;
    data['discounted_price'] = this.discountedPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic walletBalance;
  dynamic earnedBalance;
  String? name;
  String? phone;
  String? email;
  dynamic otp;
  dynamic profileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['profile_image'] = this.profileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Driver {
  int? id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic name;
  dynamic phone;
  dynamic email;
  dynamic otp;
  dynamic profileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  String? referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  int? status;
  int? isProfileComplete;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Driver(
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

  Driver.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['profile_image'] = this.profileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic street;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class OrderItems {
  int? id;
  int? productId;
  String? productName;
  dynamic variantId;
  dynamic price;
  dynamic itemQty;
  dynamic qty;
  dynamic totalPrice;
  dynamic status;

  OrderItems(
      {this.id,
      this.productId,
      this.productName,
      this.variantId,
      this.price,
      this.itemQty,
      this.qty,
      this.totalPrice,
      this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    itemQty = json['item_qty'];
    qty = json['qty'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['variant_id'] = this.variantId;
    data['price'] = this.price;
    data['item_qty'] = this.itemQty;
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
