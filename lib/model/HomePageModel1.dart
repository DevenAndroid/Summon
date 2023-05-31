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
  List<RecommendedStore>? recommendedStore;
  List<PopularStore>? popularStore;

  Data(
      {this.sliderData,
        this.latestCategory,
        this.recommendedStore,
        this.popularStore});

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
    if (json['recommendedStore'] != null) {
      recommendedStore = <RecommendedStore>[];
      json['recommendedStore'].forEach((v) {
        recommendedStore!.add(new RecommendedStore.fromJson(v));
      });
    }
    if (json['popularStore'] != null) {
      popularStore = <PopularStore>[];
      json['popularStore'].forEach((v) {
        popularStore!.add(new PopularStore.fromJson(v));
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
    if (this.recommendedStore != null) {
      data['recommendedStore'] =
          this.recommendedStore!.map((v) => v.toJson()).toList();
    }
    if (this.popularStore != null) {
      data['popularStore'] = this.popularStore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  dynamic id;
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

class LatestCategory {
  int? id;
  String? name;

  LatestCategory({this.id, this.name});

  LatestCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class RecommendedStore {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic distance;
  dynamic deliveryCharge;
  bool? wishlist;
  dynamic avgRating;

  RecommendedStore(
      {this.id,
        this.name,
        this.image,
        this.distance,
        this.deliveryCharge,
        this.wishlist,
        this.avgRating});

  RecommendedStore.fromJson(Map<String, dynamic> json) {
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
class PopularStore {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic distance;
  dynamic deliveryCharge;
  bool? wishlist;
  dynamic avgRating;

  PopularStore(
      {this.id,
        this.name,
        this.image,
        this.distance,
        this.deliveryCharge,
        this.wishlist,
        this.avgRating});

  PopularStore.fromJson(Map<String, dynamic> json) {
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
