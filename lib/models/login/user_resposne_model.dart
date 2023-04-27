class LoginResponseModel {
  Data? data;
  bool? status;
  String? message;

  LoginResponseModel({this.data, this.status, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? passwordSalt;
  String? password;
  String? vCode;
  Identity? userType;
  String? mobileNum;
  String? userName;
  String? vCodeExpiry;
  String? accStatus;
  String? dateRegistered;
  String? email;
  String? token;

  Properties(
      {this.passwordSalt,
        this.password,
        this.vCode,
        this.userType,
        this.mobileNum,
        this.userName,
        this.vCodeExpiry,
        this.accStatus,
        this.dateRegistered,
        this.email,
        this.token});

  Properties.fromJson(Map<String, dynamic> json) {
    passwordSalt = json['password_salt'];
    password = json['password'];
    vCode = json['v_code'];
    userType = json['user_type'] != null
        ? new Identity.fromJson(json['user_type'])
        : null;
    mobileNum = json['mobile_num'];
    userName = json['user_name'];
    vCodeExpiry = json['v_code_expiry'];
    accStatus = json['acc_status'];
    dateRegistered = json['date_registered'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_salt'] = this.passwordSalt;
    data['password'] = this.password;
    data['v_code'] = this.vCode;
    if (this.userType != null) {
      data['user_type'] = this.userType!.toJson();
    }
    data['mobile_num'] = this.mobileNum;
    data['user_name'] = this.userName;
    data['v_code_expiry'] = this.vCodeExpiry;
    data['acc_status'] = this.accStatus;
    data['date_registered'] = this.dateRegistered;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
