class DriverDeliveryOrderList {
  bool? status;
  String? message;
  Data? data;

  DriverDeliveryOrderList({this.status, this.message, this.data});

  DriverDeliveryOrderList.fromJson(Map<String, dynamic> json) {
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
  int? deliveredOrders;
  int? pendingOrders;
  List<List1>? list;

  Data({this.deliveredOrders, this.pendingOrders, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    deliveredOrders = json['deliveredOrders'];
    pendingOrders = json['pendingOrders'];
    if (json['list'] != null) {
      list = <List1>[];
      json['list'].forEach((v) {
        list!.add(List1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliveredOrders'] = deliveredOrders;
    data['pendingOrders'] = pendingOrders;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class List1 {
  String? date;
  int? orderId;
  String? paymentMethod;
  dynamic orderTotal;
  Location? location;

  List1(
      {this.date,
        this.orderId,
        this.paymentMethod,
        this.orderTotal,
        this.location});

  List1.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderId = json['order_id'];
    paymentMethod = json['payment_method'];
    orderTotal = json['order_total'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['order_id'] = orderId;
    data['payment_method'] = paymentMethod;
    data['order_total'] = orderTotal;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
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
  dynamic deletedAt;

  Location(
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

  Location.fromJson(Map<String, dynamic> json) {
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
