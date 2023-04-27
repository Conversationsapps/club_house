class UpdateUserProfileResponseModel {
  Data? data;
  bool? status;
  String? message;

  UpdateUserProfileResponseModel({this.data, this.status, this.message});

  UpdateUserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Identity? identity;
  List<String>? labels;
  Properties? properties;
  String? elementId;

  Data({this.identity, this.labels, this.properties, this.elementId});

  Data.fromJson(Map<String, dynamic> json) {
    identity = json['identity'] != null
        ? new Identity.fromJson(json['identity'])
        : null;
    labels = json['labels'].cast<String>();
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    elementId = json['elementId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identity != null) {
      data['identity'] = this.identity!.toJson();
    }
    data['labels'] = this.labels;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['elementId'] = this.elementId;
    return data;
  }
}

class Identity {
  int? low;
  int? high;

  Identity({this.low, this.high});

  Identity.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    high = json['high'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['low'] = this.low;
    data['high'] = this.high;
    return data;
  }
}

class Properties {
  String? occupation;
  String? gender;
  String? lName;
  double? latitude;
  String? about;
  Identity? locationId;
  String? updatedAt;
  Identity? userId;
  String? dob;
  String? fName;
  String? instagramUsername;
  double? longitude;

  Properties(
      {this.occupation,
        this.gender,
        this.lName,
        this.latitude,
        this.about,
        this.locationId,
        this.updatedAt,
        this.userId,
        this.dob,
        this.fName,
        this.instagramUsername,
        this.longitude});

  Properties.fromJson(Map<String, dynamic> json) {
    occupation = json['occupation'];
    gender = json['gender'];
    lName = json['l_name'];
    latitude = json['latitude'];
    about = json['about'];
    locationId = json['location_id'] != null
        ? new Identity.fromJson(json['location_id'])
        : null;
    updatedAt = json['updated_at'];
    userId =
    json['user_id'] != null ? new Identity.fromJson(json['user_id']) : null;
    dob = json['dob'];
    fName = json['f_name'];
    instagramUsername = json['instagram_username'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupation'] = this.occupation;
    data['gender'] = this.gender;
    data['l_name'] = this.lName;
    data['latitude'] = this.latitude;
    data['about'] = this.about;
    if (this.locationId != null) {
      data['location_id'] = this.locationId!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['dob'] = this.dob;
    data['f_name'] = this.fName;
    data['instagram_username'] = this.instagramUsername;
    data['longitude'] = this.longitude;
    return data;
  }
}
