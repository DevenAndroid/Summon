// class NearStoreModel {
//   bool? status;
//   String? message;
//   List<NearStoreData>? data;
//   Meta? meta;
//   Link? link;
//
//   NearStoreModel({this.status, this.message, this.data, this.meta, this.link});
//
//   NearStoreModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <NearStoreData>[];
//       json['data'].forEach((v) {
//         data!.add(NearStoreData.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
//     link = json['link'] != null ? Link.fromJson(json['link']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (meta != null) {
//       data['meta'] = meta!.toJson();
//     }
//     if (link != null) {
//       data['link'] = link!.toJson();
//     }
//     return data;
//   }
// }
//
// class NearStoreData {
//   int? id;
//   String? name;
//   String? distance;
//   String? image;
//
//   NearStoreData({this.id, this.name, this.distance, this.image});
//
//   NearStoreData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     distance = json['distance'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['distance'] = distance;
//     data['image'] = image;
//     return data;
//   }
// }
//
// class Meta {
//   int? totalPage;
//   int? currentPage;
//   int? totalItem;
//   int? perPage;
//
//   Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     currentPage = json['current_page'];
//     totalItem = json['total_item'];
//     perPage = json['per_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total_page'] = totalPage;
//     data['current_page'] = currentPage;
//     data['total_item'] = totalItem;
//     data['per_page'] = perPage;
//     return data;
//   }
// }
//
// class Link {
//   bool? next;
//   bool? prev;
//
//   Link({this.next, this.prev});
//
//   Link.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//     prev = json['prev'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['next'] = next;
//     data['prev'] = prev;
//     return data;
//   }
// }

// new MOdel
class NearStoreModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  NearStoreModel({this.status, this.message, this.data, this.meta, this.link});

  NearStoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic distance;
  dynamic deliveryCharge;
  bool? wishlist;
  dynamic avgRating;

  Data(
      {this.id,
        this.name,
        this.image,
        this.distance,
        this.deliveryCharge,
        this.wishlist,
        this.avgRating});

  Data.fromJson(Map<String, dynamic> json) {
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

class Meta {
  int? totalPage;
  int? currentPage;
  int? totalItem;
  int? perPage;

  Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    totalItem = json['total_item'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['total_item'] = this.totalItem;
    data['per_page'] = this.perPage;
    return data;
  }
}

class Link {
  bool? next;
  bool? prev;

  Link({this.next, this.prev});

  Link.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}
