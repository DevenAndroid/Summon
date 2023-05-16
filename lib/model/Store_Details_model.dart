import 'package:get/get.dart';

class StoreDetailsModel {
  bool? status;
  String? message;
  Data? data;

  StoreDetailsModel({this.status, this.message, this.data});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
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
  StoreDetails? storeDetails;
  List<LatestProducts>? latestProducts;

  Data({this.storeDetails, this.latestProducts});

  Data.fromJson(Map<String, dynamic> json) {
    storeDetails = json['storeDetails'] != null
        ? new StoreDetails.fromJson(json['storeDetails'])
        : null;
    if (json['LatestProducts'] != null) {
      latestProducts = <LatestProducts>[];
      json['LatestProducts'].forEach((v) {
        latestProducts!.add(new LatestProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeDetails != null) {
      data['storeDetails'] = this.storeDetails!.toJson();
    }
    if (this.latestProducts != null) {
      data['LatestProducts'] =
          this.latestProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreDetails {
  dynamic id;
  dynamic userId;
  dynamic storeName;
  dynamic phone;

  String? storeImage;
  dynamic distance;
  dynamic availability;
  bool? wishlist;
  dynamic avgRating;
  List<String>? storeCategories;

  StoreDetails(
      {this.id,
        this.userId,
        this.storeName,
        this.phone,
        this.storeImage,
        this.distance,
        this.availability,
        this.wishlist,
        this.avgRating,
        this.storeCategories});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeName = json['store_name'];
    phone = json['phone'];
    storeImage = json['store_image'];
    distance = json['distance'];
    availability = json['availability'];
    wishlist = json['wishlist'];
    avgRating = json['avg_rating'];
    storeCategories = json['store_categories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_name'] = this.storeName;
    data['phone'] = this.phone;
    data['store_image'] = this.storeImage;
    data['distance'] = this.distance;
    data['availability'] = this.availability;
    data['wishlist'] = this.wishlist;
    data['avg_rating'] = this.avgRating;
    data['store_categories'] = this.storeCategories;
    return data;
  }
}

class LatestProducts {
  String? title;
  RxString varientIndex="".obs;
  List<Variants>? variants=[];
  List<ProductData>? productData;

  LatestProducts({this.title, this.productData});

  LatestProducts.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  dynamic id;
  dynamic name;
  dynamic calories;
  dynamic content;
  dynamic image;
  List<Variants>? variants;
  dynamic avgRating;

  ProductData(
      {this.id,
        this.name,
        this.calories,
        this.content,
        this.image,
        this.variants,
        this.avgRating});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    content = json['content'];
    image = json['image'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['content'] = this.content;
    data['image'] = this.image;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = this.avgRating;
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic size;
  dynamic sizeName;
  dynamic price;
  dynamic minQty;
  dynamic maxQty;

  Variants(
      {this.id,
        this.size,
        this.sizeName,
        this.price,
        this.minQty,
        this.maxQty});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    sizeName = json['size_name'];
    price = json['price'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['size_name'] = this.sizeName;
    data['price'] = this.price;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    return data;
  }
}
