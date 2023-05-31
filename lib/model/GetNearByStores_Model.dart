class GetNearByStoreModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetNearByStoreModel({this.status, this.message, this.data});

  GetNearByStoreModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? latitude;
  String? longitude;
  String? image;
  String? distance;
  String? deliveryCharge;
  String? avgRating;

  Data(
      {this.id,
        this.name,
        this.latitude,
        this.longitude,
        this.image,
        this.distance,
        this.deliveryCharge,
        this.avgRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    distance = json['distance'];
    deliveryCharge = json['delivery_charge'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['distance'] = this.distance;
    data['delivery_charge'] = this.deliveryCharge;
    data['avg_rating'] = this.avgRating;
    return data;
  }
}
