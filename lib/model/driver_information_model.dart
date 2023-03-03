class DriverInformationModel {
  bool? status;
  String? message;
  Data? data;

  DriverInformationModel({this.status, this.message, this.data});

  DriverInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? dob;
  String? aadharNo;
  String? panNo;
  String? vehicleNo;
  String? licenceNo;
  String? bankStatement;
  String? panCardImage;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? licenceFrontImage;
  String? licenceBackImage;

  Data(
      {this.dob,
        this.aadharNo,
        this.panNo,
        this.vehicleNo,
        this.licenceNo,
        this.bankStatement,
        this.panCardImage,
        this.aadharFrontImage,
        this.aadharBackImage,
        this.licenceFrontImage,
        this.licenceBackImage});

  Data.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    vehicleNo = json['vehicle_no'];
    licenceNo = json['licence_no'];
    bankStatement = json['bank_statement'];
    panCardImage = json['pan_card_image'];
    aadharFrontImage = json['aadhar_front_image'];
    aadharBackImage = json['aadhar_back_image'];
    licenceFrontImage = json['licence_front_image'];
    licenceBackImage = json['licence_back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dob'] = dob;
    data['aadhar_no'] = aadharNo;
    data['pan_no'] = panNo;
    data['vehicle_no'] = vehicleNo;
    data['licence_no'] = licenceNo;
    data['bank_statement'] = bankStatement;
    data['pan_card_image'] = panCardImage;
    data['aadhar_front_image'] = aadharFrontImage;
    data['aadhar_back_image'] = aadharBackImage;
    data['licence_front_image'] = licenceFrontImage;
    data['licence_back_image'] = licenceBackImage;
    return data;
  }
}
