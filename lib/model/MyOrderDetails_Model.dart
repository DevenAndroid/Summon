class MyOrdersDetailsModel {
  bool? status;
  String? message;
  Data? data;

  MyOrdersDetailsModel({this.status, this.message, this.data});

  MyOrdersDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic deliveryCharges;
  dynamic walletSaving;
  dynamic couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  User? user;
  Vendor? vendor;
  dynamic driver;
  Address? address;
  String? orderType;
  String? paymentType;
  String? deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.deliveryCharges,
        this.walletSaving,
        this.couponDiscount,
        this.commissionDriver,
        this.commissionAdmin,
        this.grandTotal,
        this.user,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.paymentType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    deliveryCharges = json['delivery_charges'];
    walletSaving = json['wallet_saving'];
    couponDiscount = json['coupon_discount'];
    commissionDriver = json['commission_driver'];
    commissionAdmin = json['commission_admin'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    driver = json['driver'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['delivery_charges'] = this.deliveryCharges;
    data['wallet_saving'] = this.walletSaving;
    data['coupon_discount'] = this.couponDiscount;
    data['commission_driver'] = this.commissionDriver;
    data['commission_admin'] = this.commissionAdmin;
    data['grand_total'] = this.grandTotal;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    data['driver'] = this.driver;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['delivery_status'] = this.deliveryStatus;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class User {
  int? id;
  bool? isDriver;
  bool? isVendor;
  String? latitude;
  String? longitude;
  String? location;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  String? phone;
  String? earnedBalance;
  String? profileImage;
  bool? isDriverOnline;
  bool? isVendorOnline;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.latitude,
        this.longitude,
        this.location,
        this.firstName,
        this.lastName,
        this.name,
        this.email,
        this.phone,
        this.earnedBalance,
        this.profileImage,
        this.isDriverOnline,
        this.isVendorOnline,
        this.selfDelivery,
        this.asDriverVerified,
        this.asVendorVerified,
        this.isProfileComplete});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['earned_balance'] = this.earnedBalance;
    data['profile_image'] = this.profileImage;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['self_delivery'] = this.selfDelivery;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}

class Vendor {
  int? storeId;
  Null? id;
  String? storeName;
  String? phone;
  String? businessId;
  String? latitude;
  String? longitude;
  List<Null>? storeCategory;
  String? storeImage;
  String? businessIdImage;
  String? remark;
  bool? status;

  Vendor(
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

  Vendor.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    id = json['id'];
    storeName = json['store_name'];
    phone = json['phone'];
    businessId = json['businessId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['store_category'] != null) {
      storeCategory = <Null>[];
      json['store_category'].forEach((v) {
        // storeCategory!.add(new Null.fromJson(v));
      });
    }
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
      //     this.storeCategory!.map((v) => v.toJson()).toList();
    }
    data['storeImage'] = this.storeImage;
    data['business_id_image'] = this.businessIdImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  String? latitude;
  String? longitude;
  String? location;
  String? name;
  String? phone;
  String? image;
  Null? addressType;
  int? leaveAtDoor;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.name,
        this.phone,
        this.image,
        this.addressType,
        this.leaveAtDoor,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    addressType = json['address_type'];
    leaveAtDoor = json['leave_at_door'];
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
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address_type'] = this.addressType;
    data['leave_at_door'] = this.leaveAtDoor;
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
  int? variantId;
  int? price;
  List<Addons>? addons;
  int? qty;
  int? totalPrice;
  String? note;
  String? status;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.variantId,
        this.price,
        this.addons,
        this.qty,
        this.totalPrice,
        this.note,
        this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    qty = json['qty'];
    totalPrice = json['total_price'];
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['variant_id'] = this.variantId;
    data['price'] = this.price;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['note'] = this.note;
    data['status'] = this.status;
    return data;
  }
}

class Addons {
  int? id;
  String? name;
  String? calories;
  String? price;
  int? addonTypeId;
  String? addonType;
  bool? multiSelect;

  Addons(
      {this.id,
        this.name,
        this.calories,
        this.price,
        this.addonTypeId,
        this.addonType,
        this.multiSelect});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    addonTypeId = json['addon_type_id'];
    addonType = json['addon_type'];
    multiSelect = json['multi_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['addon_type_id'] = this.addonTypeId;
    data['addon_type'] = this.addonType;
    data['multi_select'] = this.multiSelect;
    return data;
  }
}
