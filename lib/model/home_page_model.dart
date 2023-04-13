import 'package:get/get.dart';

class HomePageModel {
  bool? status;
  String? message;
  Data? data;

  HomePageModel({this.status, this.message, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
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
  List<SliderData>? sliderData;
  List<BestFreshProduct>? bestFreshProduct;
  List<LatestCategory>? latestCategory;
  List<FeaturedStores>? featuredStores;

  Data(
      {this.sliderData,
      this.bestFreshProduct,
      this.latestCategory,
      this.featuredStores});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
    if (json['BestFreshProduct'] != null) {
      bestFreshProduct = <BestFreshProduct>[];
      json['BestFreshProduct'].forEach((v) {
        bestFreshProduct!.add(new BestFreshProduct.fromJson(v));
      });
    }
    if (json['latestCategory'] != null) {
      latestCategory = <LatestCategory>[];
      json['latestCategory'].forEach((v) {
        latestCategory!.add(new LatestCategory.fromJson(v));
      });
    }
    if (json['featuredStores'] != null) {
      featuredStores = <FeaturedStores>[];
      json['featuredStores'].forEach((v) {
        featuredStores!.add(new FeaturedStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliderData != null) {
      data['sliderData'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    if (this.bestFreshProduct != null) {
      data['BestFreshProduct'] =
          this.bestFreshProduct!.map((v) => v.toJson()).toList();
    }
    if (this.latestCategory != null) {
      data['latestCategory'] =
          this.latestCategory!.map((v) => v.toJson()).toList();
    }
    if (this.featuredStores != null) {
      data['featuredStores'] =
          this.featuredStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  int? id;
  dynamic title;
  dynamic link;
  dynamic image;

  SliderData({this.id, this.title, this.link, this.image});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class BestFreshProduct {
  int? id;
  dynamic name;
  dynamic image;
  List<Varints>? varints;
  RxInt? varientIndex = (0).obs;

  BestFreshProduct(
      {this.id, this.name, this.image, this.varints, this.varientIndex});

  BestFreshProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['varints'] != null) {
      varints = <Varints>[];
      json['varints'].forEach((v) {
        varints!.add(new Varints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.varints != null) {
      data['varints'] = this.varints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Varints {
  int? id;
  dynamic vendorProductId;
  dynamic marketPrice;
  dynamic price;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic minQty;
  dynamic maxQty;
  dynamic discountOff;

  Varints(
      {this.id,
      this.vendorProductId,
      this.marketPrice,
      this.price,
      this.variantQty,
      this.variantQtyType,
      this.minQty,
      this.maxQty,
      this.discountOff});

  Varints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorProductId = json['vendor_product_id'];
    marketPrice = json['market_price'];
    price = json['price'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    discountOff = json['discount_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_product_id'] = this.vendorProductId;
    data['market_price'] = this.marketPrice;
    data['price'] = this.price;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['discount_off'] = this.discountOff;
    return data;
  }
}

class LatestCategory {
  int? id;
  dynamic taxPercent;
  dynamic name;
  dynamic slug;
  dynamic image;

  LatestCategory({this.id, this.taxPercent, this.name, this.slug, this.image});

  LatestCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxPercent = json['tax_percent'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_percent'] = this.taxPercent;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }
}

class FeaturedStores {
  int? id;
  dynamic name;
  dynamic distance;
  dynamic image;

  FeaturedStores({this.id, this.name, this.distance, this.image});

  FeaturedStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['image'] = this.image;
    return data;
  }
}
