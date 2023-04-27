class RegisterResponseModel {
  List<Data>? data;
  String? message;
  bool? status;

  RegisterResponseModel({this.data, this.message, this.status});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
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
  String? passwordSalt;
  String? password;
  String? mobileNum;
  String? vCode;
  Identity? userType;
  String? userName;
  String? vCodeExpiry;
  String? accStatus;
  String? email;
  String? dateRegistered;
  String? token;
  int? userId;

  Properties(
      {this.passwordSalt,
        this.password,
        this.mobileNum,
        this.vCode,
        this.userType,
        this.userName,
        this.vCodeExpiry,
        this.accStatus,
        this.email,
        this.dateRegistered,
        this.token,
        this.userId});

  Properties.fromJson(Map<String, dynamic> json) {
    passwordSalt = json['password_salt'];
    password = json['password'];
    mobileNum = json['mobile_num'];
    vCode = json['v_code'];
    userType = json['user_type'] != null ? new Identity.fromJson(json['user_type']) : null;
    userName = json['user_name'];
    vCodeExpiry = json['v_code_expiry'];
    accStatus = json['acc_status'];
    email = json['email'];
    dateRegistered = json['date_registered'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_salt'] = this.passwordSalt;
    data['password'] = this.password;
    data['mobile_num'] = this.mobileNum;
    data['v_code'] = this.vCode;
    if (this.userType != null) {
      data['user_type'] = this.userType!.toJson();
    }
    data['user_name'] = this.userName;
    data['v_code_expiry'] = this.vCodeExpiry;
    data['acc_status'] = this.accStatus;
    data['email'] = this.email;
    data['date_registered'] = this.dateRegistered;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}
