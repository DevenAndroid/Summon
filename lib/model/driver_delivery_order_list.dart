import 'CheckOut_Model1.dart';

class DriverDeliveryOrderList {
  bool? status;
  dynamic message;
  Data? data;

  DriverDeliveryOrderList({this.status, this.message, this.data});

  DriverDeliveryOrderList.fromJson(Map<String, dynamic> json) {
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
  dynamic username;
  bool? deliveryMode;
  dynamic deliveredOrders;
  dynamic earningBalance;
  List<ListData>? list;
  AcceptedOrderDetail? acceptedOrderDetail;

  Data(
      {this.username,
        this.deliveryMode,
        this.deliveredOrders,
        this.earningBalance,
        this.list,
        this.acceptedOrderDetail});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    deliveryMode = json['delivery_mode'];
    deliveredOrders = json['deliveredOrders'];
    earningBalance = json['earningBalance'];
    if (json['list'] != null) {
      list = <ListData>[];
      json['list'].forEach((v) {
        list!.add(new ListData.fromJson(v));
      });
    }
    acceptedOrderDetail = json['acceptedOrderDetail'] != null
        ? new AcceptedOrderDetail.fromJson(json['acceptedOrderDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['delivery_mode'] = this.deliveryMode;
    data['deliveredOrders'] = this.deliveredOrders;
    data['earningBalance'] = this.earningBalance;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.acceptedOrderDetail != null) {
      data['acceptedOrderDetail'] = this.acceptedOrderDetail!.toJson();
    }
    return data;
  }
}

class ListData {
  dynamic date;
  dynamic orderId;
  dynamic paymentMethod;
  List<OrderItem>? orderItem;
  dynamic orderTotal;
  Location? location;
  VendorLocation? vendorLocation;
  dynamic distance;

  ListData(
      {this.date,
        this.orderId,
        this.paymentMethod,
        this.orderItem,
        this.orderTotal,
        this.location,
        this.vendorLocation,
        this.distance});

  ListData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderId = json['order_id'];
    paymentMethod = json['payment_method'];
    if (json['orderItem'] != null) {
      orderItem = <OrderItem>[];
      json['orderItem'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    orderTotal = json['order_total'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    vendorLocation = json['vendor_location'] != null
        ? new VendorLocation.fromJson(json['vendor_location'])
        : null;
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['order_id'] = this.orderId;
    data['payment_method'] = this.paymentMethod;
    if (this.orderItem != null) {
      data['orderItem'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    data['order_total'] = this.orderTotal;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.vendorLocation != null) {
      data['vendor_location'] = this.vendorLocation!.toJson();
    }
    data['distance'] = this.distance;
    return data;
  }
}

class OrderItem {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic variantId;
  dynamic price;
  List<Addons>? addons;
  dynamic qty;
  dynamic totalPrice;
  dynamic note;
  dynamic status;

  OrderItem(
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

  OrderItem.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic title;
  dynamic name;
  dynamic calories;
  dynamic price;
  bool? multiSelect;

  Addons(
      {this.id,
        this.title,
        this.name,
        this.calories,
        this.price,
        this.multiSelect});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    multiSelect = json['multi_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['multi_select'] = this.multiSelect;
    return data;
  }
}

class Location {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic note;
  dynamic longitude;
  Null? location;
  dynamic name;
  dynamic phone;
  dynamic image;
  dynamic addressType;
  bool? leaveAtDoor;
  dynamic createdAt;
  dynamic updatedAt;
  Null? deletedAt;

  Location(
      {this.id,
        this.userId,
        this.latitude,
        this.note,
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

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    note = json['note'];
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
    data['note'] = this.note;
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

class VendorLocation {
  dynamic storeId;
  dynamic id;
  dynamic storeName;
  dynamic phone;
  dynamic businessId;
  dynamic latitude;
  dynamic longitude;
  List<int>? storeCategory;
  dynamic storeImage;
  dynamic businessIdImage;
  dynamic remark;
  bool? status;

  VendorLocation(
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

  VendorLocation.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    id = json['id'];
    storeName = json['store_name'];
    phone = json['phone'];
    businessId = json['businessId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    storeCategory = json['store_category'].cast<int>();
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
    data['store_category'] = this.storeCategory;
    data['storeImage'] = this.storeImage;
    data['business_id_image'] = this.businessIdImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}

class AcceptedOrderDetail {
  dynamic orderId;
  dynamic itemTotal;
  dynamic deliveryCharges;
  dynamic walletSaving;
  Null? couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  User? user;
  Vendor? vendor;
  User? driver;
  Location? address;
  dynamic orderType;
  dynamic paymentType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  AcceptedOrderDetail(
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

  AcceptedOrderDetail.fromJson(Map<String, dynamic> json) {
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
    driver = json['driver'] != null ? new User.fromJson(json['driver']) : null;
    address =
    json['address'] != null ? new Location.fromJson(json['address']) : null;
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
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
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
  dynamic id;
  bool? isDriver;
  bool? isVendor;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic firstName;
  dynamic lastName;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic earnedBalance;
  dynamic profileImage;
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
  dynamic storeId;
  dynamic id;
  dynamic storeName;
  dynamic phone;
  dynamic businessId;
  dynamic latitude;
  dynamic longitude;
  List<Null>? storeCategory;
  dynamic storeImage;
  dynamic businessIdImage;
  dynamic remark;
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
          // this.storeCategory!.map((v) => v.toJson()).toList();
    }
    data['storeImage'] = this.storeImage;
    data['business_id_image'] = this.businessIdImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}
