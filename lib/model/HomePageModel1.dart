class HomePageModel1 {
  bool? status;
  String? message;
  Data? data;

  HomePageModel1({this.status, this.message, this.data});

  HomePageModel1.fromJson(Map<String, dynamic> json) {
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
  List<LatestCategory>? latestCategory;
  List<RecommendedProduct>? recommendedProduct;
  List<PopularProduct>? popularProduct;

  Data(
      {this.sliderData,
        this.latestCategory,
        this.recommendedProduct,
        this.popularProduct});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
    if (json['latestCategory'] != null) {
      latestCategory = <LatestCategory>[];
      json['latestCategory'].forEach((v) {
        latestCategory!.add(new LatestCategory.fromJson(v));
      });
    }
    if (json['recommendedProduct'] != null) {
      recommendedProduct = <RecommendedProduct>[];
      json['recommendedProduct'].forEach((v) {
        recommendedProduct!.add(new RecommendedProduct.fromJson(v));
      });
    }
    if (json['popularProduct'] != null) {
      popularProduct = <PopularProduct>[];
      json['popularProduct'].forEach((v) {
        popularProduct!.add(new PopularProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliderData != null) {
      data['sliderData'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    if (this.latestCategory != null) {
      data['latestCategory'] =
          this.latestCategory!.map((v) => v.toJson()).toList();
    }
    if (this.recommendedProduct != null) {
      data['recommendedProduct'] =
          this.recommendedProduct!.map((v) => v.toJson()).toList();
    }
    if (this.popularProduct != null) {
      data['popularProduct'] =
          this.popularProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  int? id;
  String? title;
  String? link;
  String? image;

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

class LatestCategory {
  int? id;
  String? name;
  String? slug;
  String? image;

  LatestCategory({this.id, this.name, this.slug, this.image});

  LatestCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }
}

class RecommendedProduct {
  int? id;
  String? name;
  String? sKU;
  String? type;
  String? content;
  String? image;
  bool? status;
  List<Variants>? variants;
  List<Addons>? addons;

  RecommendedProduct(
      {this.id,
        this.name,
        this.sKU,
        this.type,
        this.content,
        this.image,
        this.status,
        this.variants,
        this.addons});

  RecommendedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sKU = json['SKU'];
    type = json['type'];
    content = json['content'];
    image = json['image'];
    status = json['status'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['SKU'] = this.sKU;
    data['type'] = this.type;
    data['content'] = this.content;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  int? id;
  dynamic size;
  String? sizeName;
  String? price;
  int? minQty;
  int? maxQty;

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

class Addons {
  int? id;
  String? name;
  String? price;
  int? addonTypeId;
  String? addonType;

  Addons({this.id, this.name, this.price, this.addonTypeId, this.addonType});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    addonTypeId = json['addon_type_id'];
    addonType = json['addon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['addon_type_id'] = this.addonTypeId;
    data['addon_type'] = this.addonType;
    return data;
  }
}

class PopularProduct {
  int? id;
  String? name;
  String? image;
  String? type;
  List<Variants>? variants;
  List<Addons>? addons;

  PopularProduct(
      {this.id, this.name, this.image, this.type, this.variants, this.addons});

  PopularProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
