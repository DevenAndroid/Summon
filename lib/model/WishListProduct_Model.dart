class WishListProductModel {
  bool? status;
  String? message;
  Data? data;

  WishListProductModel({this.status, this.message, this.data});

  WishListProductModel.fromJson(Map<String, dynamic> json) {
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
  List<Reviews>? reviews;

  Data({this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  String? name;
  String? image;
  String? distance;
  String? deliveryCharge;
  bool? wishlist;
  String? avgRating;

  Reviews(
      {this.id,
        this.name,
        this.image,
        this.distance,
        this.deliveryCharge,
        this.wishlist,
        this.avgRating});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    distance = json['distance'];
    deliveryCharge = json['delivery_charge'];
    wishlist = json['wishlist'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['distance'] = this.distance;
    data['delivery_charge'] = this.deliveryCharge;
    data['wishlist'] = this.wishlist;
    data['avg_rating'] = this.avgRating;
    return data;
  }
}
