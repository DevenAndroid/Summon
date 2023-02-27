class DriverDeliveryOrderList {
  bool? status;
  String? message;
  List<Data>? data;

  DriverDeliveryOrderList({this.status, this.message, this.data});

  DriverDeliveryOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  int? orderId;
  String? paymentMethod;
  int? orderTotal;
  Location? location;

  Data(
      {this.date,
        this.orderId,
        this.paymentMethod,
        this.orderTotal,
        this.location});

  Data.fromJson(Map<String, dynamic> json) {
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
  Null? deletedAt;

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
