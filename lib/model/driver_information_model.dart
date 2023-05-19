class DriverInformationModel {
  bool? status;
  String? message;
  Data? data;

  DriverInformationModel({this.status, this.message, this.data});

  DriverInformationModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? dob;
  String? nationalId;
  String? carYear;
  String? make;
  String? model;
  String? color;
  String? numberPlate;
  String? licenceFrontImage;
  String? licenceBackImage;

  Data(
      {this.id,
        this.dob,
        this.nationalId,
        this.carYear,
        this.make,
        this.model,
        this.color,
        this.numberPlate,
        this.licenceFrontImage,
        this.licenceBackImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dob = json['dob'];
    nationalId = json['national_id'];
    carYear = json['car_year'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    numberPlate = json['number_plate'];
    licenceFrontImage = json['licence_front_image'];
    licenceBackImage = json['licence_back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dob'] = this.dob;
    data['national_id'] = this.nationalId;
    data['car_year'] = this.carYear;
    data['make'] = this.make;
    data['model'] = this.model;
    data['color'] = this.color;
    data['number_plate'] = this.numberPlate;
    data['licence_front_image'] = this.licenceFrontImage;
    data['licence_back_image'] = this.licenceBackImage;
    return data;
  }
}
