class CouponModel {
  bool? status;
  String? message;
  List<Data>? data;

  CouponModel({this.status, this.message, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic vendorId;
  dynamic couponCode;
  dynamic couponDetails;
  dynamic validFrom;
  dynamic validTo;
  dynamic discountType;
  dynamic maxReedem;
  dynamic maxUser;
  dynamic maxDiscount;
  dynamic minOrderValue;
  dynamic amount;

  Data(
      {this.id,
        this.vendorId,
        this.couponCode,
        this.couponDetails,
        this.validFrom,
        this.validTo,
        this.discountType,
        this.maxReedem,
        this.maxUser,
        this.maxDiscount,
        this.minOrderValue,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    couponCode = json['coupon_code'];
    couponDetails = json['coupon_details'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    discountType = json['discount_type'];
    maxReedem = json['max_reedem'];
    maxUser = json['max_user'];
    maxDiscount = json['max_discount'];
    minOrderValue = json['min_order_value'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['coupon_code'] = couponCode;
    data['coupon_details'] = couponDetails;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['discount_type'] = discountType;
    data['max_reedem'] = maxReedem;
    data['max_user'] = maxUser;
    data['max_discount'] = maxDiscount;
    data['min_order_value'] = minOrderValue;
    data['amount'] = amount;
    return data;
  }
}
