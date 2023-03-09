class SetStoreTimeModel {
  bool? status;
  dynamic message;
  List<StoreTimeData>? data;

  SetStoreTimeModel({this.status, this.message, this.data});

  SetStoreTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreTimeData>[];
      json['data'].forEach((v) {
        data!.add(StoreTimeData.fromJson(v));
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

class StoreTimeData {
  dynamic id;
  dynamic weekDay;
  dynamic startTime;
  dynamic endTime;
  bool? status;

  StoreTimeData(
      {this.id, this.weekDay, this.startTime, this.endTime, this.status});

  StoreTimeData.fromJson(Map<String, dynamic> json) {
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
