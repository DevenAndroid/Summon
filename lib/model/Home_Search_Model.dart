import 'package:get/get.dart';

class HomeSerachModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  HomeSerachModel({this.status, this.message, this.data, this.meta, this.link});

  HomeSerachModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (link != null) {
      data['link'] = link!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  dynamic distance;
  // List<Varints>? varints;
  RxInt? varientIndex = (0).obs;

  Data({this.id, this.name, this.image,this.distance, this.varientIndex});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    distance = json['distance'];
    // if (json['varints'] != null) {
    //   varints = <Varints>[];
    //   json['varints'].forEach((v) {
    //     varints!.add(Varints.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['distance'] = distance;
    // if (varints != null) {
    //   data['varints'] = varints!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Varints {
//   int? id;
//   int? vendorProductId;
//   int? marketPrice;
//   int? price;
//   String? variantQty;
//   String? variantQtyType;
//   int? minQty;
//   int? maxQty;
//   String? discountOff;
//
//   Varints(
//       {this.id,
//       this.vendorProductId,
//       this.marketPrice,
//       this.price,
//       this.variantQty,
//       this.variantQtyType,
//       this.minQty,
//       this.maxQty,
//       this.discountOff});
//
//   Varints.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorProductId = json['vendor_product_id'];
//     marketPrice = json['market_price'];
//     price = json['price'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     discountOff = json['discount_off'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['vendor_product_id'] = vendorProductId;
//     data['market_price'] = marketPrice;
//     data['price'] = price;
//     data['variant_qty'] = variantQty;
//     data['variant_qty_type'] = variantQtyType;
//     data['min_qty'] = minQty;
//     data['max_qty'] = maxQty;
//     data['discount_off'] = discountOff;
//     return data;
//   }
// }

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total_item'] = totalItem;
    data['per_page'] = perPage;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
