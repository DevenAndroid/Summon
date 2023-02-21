import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) =>
    MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  MyOrdersModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  MyOrdersModel copyWith({
    bool? status,
    String? message,
    List<Datum>? data,
  }) =>
      MyOrdersModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.orderId,
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
    this.placedAt,
  });

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
  Driver? user;
  Driver? vendor;
  Driver? driver;
  dynamic address;
  String? orderType;
  String? deliveryStatus;
  dynamic itemCount;
  List<OrderItem>? orderItems;
  String? image;
  String? placedAt;

  Datum copyWith({
    int? orderId,
    dynamic itemTotal,
    dynamic surcharge,
    dynamic tax,
    dynamic deliveryCharges,
    dynamic packingFee,
    dynamic tipAmount,
    CouponDiscount? couponDiscount,
    dynamic commissionDriver,
    dynamic commissionAdmin,
    dynamic grandTotal,
    Driver? user,
    Driver? vendor,
    Driver? driver,
    dynamic address,
    String? orderType,
    String? deliveryStatus,
    dynamic itemCount,
    List<OrderItem>? orderItems,
    String? image,
    String? placedAt,
  }) =>
      Datum(
        orderId: orderId ?? this.orderId,
        itemTotal: itemTotal ?? this.itemTotal,
        surcharge: surcharge ?? this.surcharge,
        tax: tax ?? this.tax,
        deliveryCharges: deliveryCharges ?? this.deliveryCharges,
        packingFee: packingFee ?? this.packingFee,
        tipAmount: tipAmount ?? this.tipAmount,
        couponDiscount: couponDiscount ?? this.couponDiscount,
        commissionDriver: commissionDriver ?? this.commissionDriver,
        commissionAdmin: commissionAdmin ?? this.commissionAdmin,
        grandTotal: grandTotal ?? this.grandTotal,
        user: user ?? this.user,
        vendor: vendor ?? this.vendor,
        driver: driver ?? this.driver,
        address: address ?? this.address,
        orderType: orderType ?? this.orderType,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        itemCount: itemCount ?? this.itemCount,
        orderItems: orderItems ?? this.orderItems,
        image: image ?? this.image,
        placedAt: placedAt ?? this.placedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"],
        itemTotal: json["item_total"],
        surcharge: json["surcharge"],
        tax: json["tax"],
        deliveryCharges: json["delivery_charges"],
        packingFee: json["packing_fee"],
        tipAmount: json["tip_amount"],
        couponDiscount: json["coupon_discount"] == null
            ? null
            : CouponDiscount.fromJson(json["coupon_discount"]),
        commissionDriver: json["commission_driver"],
        commissionAdmin: json["commission_admin"],
        grandTotal: json["grand_total"],
        user: json["user"] == null ? null : Driver.fromJson(json["user"]),
        vendor: json["vendor"] == null ? null : Driver.fromJson(json["vendor"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        address: json["address"],
        orderType: json["order_type"],
        deliveryStatus: json["delivery_status"],
        itemCount: json["item_count"],
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        image: json["image"],
        placedAt: json["placed_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "item_total": itemTotal,
        "surcharge": surcharge,
        "tax": tax,
        "delivery_charges": deliveryCharges,
        "packing_fee": packingFee,
        "tip_amount": tipAmount,
        "coupon_discount": couponDiscount?.toJson(),
        "commission_driver": commissionDriver,
        "commission_admin": commissionAdmin,
        "grand_total": grandTotal,
        "user": user?.toJson(),
        "vendor": vendor?.toJson(),
        "driver": driver?.toJson(),
        "address": address,
        "order_type": orderType,
        "delivery_status": deliveryStatus,
        "item_count": itemCount,
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "image": image,
        "placed_at": placedAt,
      };
}

class CouponDiscount {
  CouponDiscount({
    this.id,
    this.userId,
    this.couponCode,
    this.discountType,
    this.discountedPrice,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? couponCode;
  String? discountType;
  dynamic discountedPrice;
  dynamic createdAt;
  dynamic updatedAt;

  CouponDiscount copyWith({
    int? id,
    int? userId,
    String? couponCode,
    String? discountType,
    int? discountedPrice,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      CouponDiscount(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        couponCode: couponCode ?? this.couponCode,
        discountType: discountType ?? this.discountType,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CouponDiscount.fromJson(Map<String, dynamic> json) => CouponDiscount(
        id: json["id"],
        userId: json["user_id"],
        couponCode: json["coupon_code"],
        discountType: json["discount_type"],
        discountedPrice: json["discounted_price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "coupon_code": couponCode,
        "discount_type": discountType,
        "discounted_price": discountedPrice,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Driver {
  Driver({
    this.id,
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
    this.deletedAt,
  });

  int? id;
  int? isDriver;
  int? isVendor;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Driver copyWith({
    int? id,
    int? isDriver,
    int? isVendor,
    dynamic walletBalance,
    dynamic earnedBalance,
    String? name,
    String? phone,
    String? email,
    int? otp,
    String? profileImage,
    String? latitude,
    String? longitude,
    String? location,
    dynamic defaultAddress,
    String? referalCode,
    dynamic deviceToken,
    dynamic deviceId,
    dynamic isDriverOnline,
    dynamic isVendorOnline,
    dynamic deliveryRange,
    dynamic selfDelivery,
    dynamic adminCommission,
    dynamic asDriverVerified,
    dynamic asVendorVerified,
    dynamic featuredStore,
    dynamic emailVerifiedAt,
    int? status,
    int? isProfileComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Driver(
        id: id ?? this.id,
        isDriver: isDriver ?? this.isDriver,
        isVendor: isVendor ?? this.isVendor,
        walletBalance: walletBalance ?? this.walletBalance,
        earnedBalance: earnedBalance ?? this.earnedBalance,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        otp: otp ?? this.otp,
        profileImage: profileImage ?? this.profileImage,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        defaultAddress: defaultAddress ?? this.defaultAddress,
        referalCode: referalCode ?? this.referalCode,
        deviceToken: deviceToken ?? this.deviceToken,
        deviceId: deviceId ?? this.deviceId,
        isDriverOnline: isDriverOnline ?? this.isDriverOnline,
        isVendorOnline: isVendorOnline ?? this.isVendorOnline,
        deliveryRange: deliveryRange ?? this.deliveryRange,
        selfDelivery: selfDelivery ?? this.selfDelivery,
        adminCommission: adminCommission ?? this.adminCommission,
        asDriverVerified: asDriverVerified ?? this.asDriverVerified,
        asVendorVerified: asVendorVerified ?? this.asVendorVerified,
        featuredStore: featuredStore ?? this.featuredStore,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        status: status ?? this.status,
        isProfileComplete: isProfileComplete ?? this.isProfileComplete,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        isDriver: json["is_driver"],
        isVendor: json["is_vendor"],
        walletBalance: json["wallet_balance"],
        earnedBalance: json["earned_balance"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        otp: json["otp"],
        profileImage: json["profile_image"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: json["location"],
        defaultAddress: json["default_address"],
        referalCode: json["referal_code"],
        deviceToken: json["device_token"],
        deviceId: json["device_id"],
        isDriverOnline: json["is_driver_online"],
        isVendorOnline: json["is_vendor_online"],
        deliveryRange: json["delivery_range"],
        selfDelivery: json["self_delivery"],
        adminCommission: json["admin_commission"],
        asDriverVerified: json["as_driver_verified"],
        asVendorVerified: json["as_vendor_verified"],
        featuredStore: json["featured_store"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        isProfileComplete: json["is_profile_complete"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_driver": isDriver,
        "is_vendor": isVendor,
        "wallet_balance": walletBalance,
        "earned_balance": earnedBalance,
        "name": name,
        "phone": phone,
        "email": email,
        "otp": otp,
        "profile_image": profileImage,
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "default_address": defaultAddress,
        "referal_code": referalCode,
        "device_token": deviceToken,
        "device_id": deviceId,
        "is_driver_online": isDriverOnline,
        "is_vendor_online": isVendorOnline,
        "delivery_range": deliveryRange,
        "self_delivery": selfDelivery,
        "admin_commission": adminCommission,
        "as_driver_verified": asDriverVerified,
        "as_vendor_verified": asVendorVerified,
        "featured_store": featuredStore,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "is_profile_complete": isProfileComplete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.productId,
    this.productName,
    this.variantId,
    this.price,
    this.itemQty,
    this.qty,
    this.totalPrice,
  });

  int? id;
  int? productId;
  String? productName;
  int? variantId;
  dynamic price;
  String? itemQty;
  int? qty;
  dynamic totalPrice;

  OrderItem copyWith({
    int? id,
    int? productId,
    String? productName,
    int? variantId,
    int? price,
    String? itemQty,
    int? qty,
    dynamic totalPrice,
  }) =>
      OrderItem(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        variantId: variantId ?? this.variantId,
        price: price ?? this.price,
        itemQty: itemQty ?? this.itemQty,
        qty: qty ?? this.qty,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        variantId: json["variant_id"],
        price: json["price"],
        itemQty: json["item_qty"],
        qty: json["qty"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "variant_id": variantId,
        "price": price,
        "item_qty": itemQty,
        "qty": qty,
        "total_price": totalPrice,
      };
}
