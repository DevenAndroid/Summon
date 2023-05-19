class MyAddressModel {
  bool? status;
  String? message;
  List<Data>? data;

  MyAddressModel({this.status, this.message, this.data});

  MyAddressModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  dynamic latitude;
  dynamic longitude;
  dynamic name;
  dynamic phone;
  dynamic image;
  dynamic note;
  int? leaveAtDoor;

  Data(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.name,
        this.phone,
        this.image,
        this.note,
        this.leaveAtDoor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    note = json['note'];
    leaveAtDoor = json['leave_at_door'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['note'] = this.note;
    data['leave_at_door'] = this.leaveAtDoor;
    return data;
  }
}
