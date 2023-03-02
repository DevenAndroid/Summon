class SetStoreTimeModel {
  bool? status;
  String? message;
  List<Data>? data;

  SetStoreTimeModel({this.status, this.message, this.data});

  SetStoreTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? weekDay;
  String? startTime;
  String? endTime;
  bool? status;

  Data({this.id, this.weekDay, this.startTime, this.endTime, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['week_day'] = this.weekDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}
