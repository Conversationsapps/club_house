// To parse this JSON data, do
//
//     final addLocationResponseModel = addLocationResponseModelFromJson(jsonString);

import 'dart:convert';

AddLocationResponseModel addLocationResponseModelFromJson(String str) => AddLocationResponseModel.fromJson(json.decode(str));

String addLocationResponseModelToJson(AddLocationResponseModel data) => json.encode(data.toJson());

class AddLocationResponseModel {
  AddLocationResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  Data data;
  bool status;
  String message;

  factory AddLocationResponseModel.fromJson(Map<String, dynamic> json) => AddLocationResponseModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  Data({
    required this.user,
    required this.rel,
    required this.location,
  });

  User user;
  Rel rel;
  Location location;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["User"]),
    rel: Rel.fromJson(json["rel"]),
    location: Location.fromJson(json["Location"]),
  );

  Map<String, dynamic> toJson() => {
    "User": user.toJson(),
    "rel": rel.toJson(),
    "Location": location.toJson(),
  };
}

class Location {
  Location({
    required this.identity,
    required this.labels,
    required this.properties,
    required this.elementId,
  });

  Identity identity;
  List<String> labels;
  LocationProperties properties;
  String elementId;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    identity: Identity.fromJson(json["identity"]),
    labels: List<String>.from(json["labels"].map((x) => x)),
    properties: LocationProperties.fromJson(json["properties"]),
    elementId: json["elementId"],
  );

  Map<String, dynamic> toJson() => {
    "identity": identity.toJson(),
    "labels": List<dynamic>.from(labels.map((x) => x)),
    "properties": properties.toJson(),
    "elementId": elementId,
  };
}

class Identity {
  Identity({
    required this.low,
    required this.high,
  });

  int low;
  int high;

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
    low: json["low"],
    high: json["high"],
  );

  Map<String, dynamic> toJson() => {
    "low": low,
    "high": high,
  };
}

class LocationProperties {
  LocationProperties({
    required this.country,
    required this.city,
    required this.latittude,
    required this.name,
    required this.countryId,
    required this.longitude,
  });

  String country;
  String city;
  String latittude;
  String name;
  Identity countryId;
  String longitude;

  factory LocationProperties.fromJson(Map<String, dynamic> json) => LocationProperties(
    country: json["country"],
    city: json["city"],
    latittude: json["latittude"],
    name: json["name"],
    countryId: Identity.fromJson(json["country_id"]),
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "city": city,
    "latittude": latittude,
    "name": name,
    "country_id": countryId.toJson(),
    "longitude": longitude,
  };
}

class Rel {
  Rel({
    required this.identity,
    required this.start,
    required this.end,
    required this.type,
    required this.properties,
    required this.elementId,
    required this.startNodeElementId,
    required this.endNodeElementId,
  });

  Identity identity;
  Identity start;
  Identity end;
  String type;
  RelProperties properties;
  String elementId;
  String startNodeElementId;
  String endNodeElementId;

  factory Rel.fromJson(Map<String, dynamic> json) => Rel(
    identity: Identity.fromJson(json["identity"]),
    start: Identity.fromJson(json["start"]),
    end: Identity.fromJson(json["end"]),
    type: json["type"],
    properties: RelProperties.fromJson(json["properties"]),
    elementId: json["elementId"],
    startNodeElementId: json["startNodeElementId"],
    endNodeElementId: json["endNodeElementId"],
  );

  Map<String, dynamic> toJson() => {
    "identity": identity.toJson(),
    "start": start.toJson(),
    "end": end.toJson(),
    "type": type,
    "properties": properties.toJson(),
    "elementId": elementId,
    "startNodeElementId": startNodeElementId,
    "endNodeElementId": endNodeElementId,
  };
}

class RelProperties {
  RelProperties();

  factory RelProperties.fromJson(Map<String, dynamic> json) => RelProperties(
  );

  Map<String, dynamic> toJson() => {
  };
}

class User {
  User({
    required this.identity,
    required this.labels,
    required this.properties,
    required this.elementId,
  });

  Identity identity;
  List<String> labels;
  UserProperties properties;
  String elementId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    identity: Identity.fromJson(json["identity"]),
    labels: List<String>.from(json["labels"].map((x) => x)),
    properties: UserProperties.fromJson(json["properties"]),
    elementId: json["elementId"],
  );

  Map<String, dynamic> toJson() => {
    "identity": identity.toJson(),
    "labels": List<dynamic>.from(labels.map((x) => x)),
    "properties": properties.toJson(),
    "elementId": elementId,
  };
}

class UserProperties {
  UserProperties({
    required this.passwordSalt,
    required this.password,
    required this.userType,
    required this.vCode,
    required this.mobileNum,
    required this.userName,
    required this.vCodeExpiry,
    required this.accStatus,
    required this.dateRegistered,
    required this.email,
    required this.token,
  });

  String passwordSalt;
  String password;
  Identity userType;
  String vCode;
  String mobileNum;
  String userName;
  String vCodeExpiry;
  String accStatus;
  String dateRegistered;
  String email;
  String token;

  factory UserProperties.fromJson(Map<String, dynamic> json) => UserProperties(
    passwordSalt: json["password_salt"],
    password: json["password"],
    userType: Identity.fromJson(json["user_type"]),
    vCode: json["v_code"],
    mobileNum: json["mobile_num"],
    userName: json["user_name"],
    vCodeExpiry: json["v_code_expiry"],
    accStatus: json["acc_status"],
    dateRegistered: json["date_registered"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "password_salt": passwordSalt,
    "password": password,
    "user_type": userType.toJson(),
    "v_code": vCode,
    "mobile_num": mobileNum,
    "user_name": userName,
    "v_code_expiry": vCodeExpiry,
    "acc_status": accStatus,
    "date_registered": dateRegistered,
    "email": email,
    "token": token,
  };
}
