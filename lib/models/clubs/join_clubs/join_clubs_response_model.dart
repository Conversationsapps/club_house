// To parse this JSON data, do
//
//     final joinClubResponseModel = joinClubResponseModelFromJson(jsonString);

import 'dart:convert';

JoinClubResponseModel joinClubResponseModelFromJson(String str) => JoinClubResponseModel.fromJson(json.decode(str));

String joinClubResponseModelToJson(JoinClubResponseModel data) => json.encode(data.toJson());

class JoinClubResponseModel {

  Data data;
  bool status;
  String message;

  JoinClubResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });



  factory JoinClubResponseModel.fromJson(Map<String, dynamic> json) => JoinClubResponseModel(
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
    required this.club,
    required this.rel,
    required this.user,
  });

  Club club;
  Rel rel;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    club: Club.fromJson(json["club"]),
    rel: Rel.fromJson(json["rel"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "club": club.toJson(),
    "rel": rel.toJson(),
    "user": user.toJson(),
  };
}

class Club {
  Club({
    required this.identity,
    required this.labels,
    required this.properties,
    required this.elementId,
  });

  Identity identity;
  List<String> labels;
  ClubProperties properties;
  String elementId;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    identity: Identity.fromJson(json["identity"]),
    labels: List<String>.from(json["labels"].map((x) => x)),
    properties: ClubProperties.fromJson(json["properties"]),
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

class ClubProperties {
  ClubProperties({
    required this.founderId,
    required this.categoryId,
    required this.updatedAt,
    required this.createdAt,
    required this.clubName,
    required this.locationId,
  });

  Identity founderId;
  Identity categoryId;
  AtedAt updatedAt;
  AtedAt createdAt;
  String clubName;
  Identity locationId;

  factory ClubProperties.fromJson(Map<String, dynamic> json) => ClubProperties(
    founderId: Identity.fromJson(json["founder_id"]),
    categoryId: Identity.fromJson(json["category_id"]),
    updatedAt: AtedAt.fromJson(json["updated_at"]),
    createdAt: AtedAt.fromJson(json["created_at"]),
    clubName: json["club_name"],
    locationId: Identity.fromJson(json["location_id"]),
  );

  Map<String, dynamic> toJson() => {
    "founder_id": founderId.toJson(),
    "category_id": categoryId.toJson(),
    "updated_at": updatedAt.toJson(),
    "created_at": createdAt.toJson(),
    "club_name": clubName,
    "location_id": locationId.toJson(),
  };
}

class AtedAt {
  AtedAt({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
    required this.nanosecond,
    required this.timeZoneOffsetSeconds,
  });

  Identity year;
  Identity month;
  Identity day;
  Identity hour;
  Identity minute;
  Identity second;
  Identity nanosecond;
  Identity timeZoneOffsetSeconds;

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
    year: Identity.fromJson(json["year"]),
    month: Identity.fromJson(json["month"]),
    day: Identity.fromJson(json["day"]),
    hour: Identity.fromJson(json["hour"]),
    minute: Identity.fromJson(json["minute"]),
    second: Identity.fromJson(json["second"]),
    nanosecond: Identity.fromJson(json["nanosecond"]),
    timeZoneOffsetSeconds: Identity.fromJson(json["timeZoneOffsetSeconds"]),
  );

  Map<String, dynamic> toJson() => {
    "year": year.toJson(),
    "month": month.toJson(),
    "day": day.toJson(),
    "hour": hour.toJson(),
    "minute": minute.toJson(),
    "second": second.toJson(),
    "nanosecond": nanosecond.toJson(),
    "timeZoneOffsetSeconds": timeZoneOffsetSeconds.toJson(),
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
