import 'VendorAddProduct_Model.dart';

class AddonsModel {
  List<AddonDataaa>? addonData;

  AddonsModel({this.addonData});

  AddonsModel.fromJson(Map<String, dynamic> json) {
    if (json['addon_data'] != null) {
      addonData = <AddonDataaa>[];
      json['addon_data'].forEach((v) {
        addonData!.add(new AddonDataaa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addonData != null) {
      data['addon_data'] = this.addonData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonDataaa {
  String? title;
  String? multiSelect;
  String? name;
  String? calories;
  String? price;

  AddonDataaa(
      {this.title, this.multiSelect, this.name, this.calories, this.price});

  AddonDataaa.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    multiSelect = json['multi_select'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
  }

  // AddonDataaa.fromSingleAddon(SinglePageAddons item) {
  //   title = item.title;
  //   multiSelect = (item.multiSelectAddons ?? false) ? 1 : 0;
  //   name = item.;
  //   calories = item.title;
  //   price = item.title;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['multi_select'] = this.multiSelect;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    return data;
  }
}
