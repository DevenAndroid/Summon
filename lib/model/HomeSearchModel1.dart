class HomePageSearchModel1 {
  bool? status;
  String? message;
  List<SearchModelData>? data;
  Meta? meta;
  Link? link;

  HomePageSearchModel1(
      {this.status, this.message, this.data, this.meta, this.link});

  HomePageSearchModel1.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchModelData>[];
      json['data'].forEach((v) {
        data!.add(new SearchModelData.fromJson(v));
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

class SearchModelData {
  int? id;
  String? name;
  String? distance;
  String?  deliveryCharge;
  String? image;
  String? avgRating;

  SearchModelData({this.id, this.name, this.distance, this.deliveryCharge, this.image, this.avgRating});

  SearchModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    deliveryCharge = json['delivery_charge'];
    image = json['image'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['delivery_charge'] = this.deliveryCharge;
    data['image'] = this.image;
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
