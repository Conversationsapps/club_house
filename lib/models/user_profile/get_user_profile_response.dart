// To parse this JSON data, do
//
//     final getUserResponseModel = getUserResponseModelFromJson(jsonString);

import 'dart:convert';

GetUserResponseModel getUserResponseModelFromJson(String str) => GetUserResponseModel.fromJson(json.decode(str));

String getUserResponseModelToJson(GetUserResponseModel data) => json.encode(data.toJson());

class GetUserResponseModel {
  GetUserResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  Data data;
  bool status;
  String message;

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) => GetUserResponseModel(
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
    required this.userProfile,
    required this.location,
    this.clubs,
  });

  List<UserProfile> userProfile;
  List<Location> location;
  dynamic clubs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProfile: List<UserProfile>.from(json["UserProfile"].map((x) => UserProfile.fromJson(x))),
    location: List<Location>.from(json["Location"].map((x) => Location.fromJson(x))),
    clubs: json["clubs"],
  );

  Map<String, dynamic> toJson() => {
    "UserProfile": List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "Location": List<dynamic>.from(location.map((x) => x.toJson())),
    "clubs": clubs,
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

class UserProfile {
  UserProfile({
    required this.identity,
    required this.labels,
    required this.properties,
    required this.elementId,
  });

  Identity identity;
  List<String> labels;
  UserProfileProperties properties;
  String elementId;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    identity: Identity.fromJson(json["identity"]),
    labels: List<String>.from(json["labels"].map((x) => x)),
    properties: UserProfileProperties.fromJson(json["properties"]),
    elementId: json["elementId"],
  );

  Map<String, dynamic> toJson() => {
    "identity": identity.toJson(),
    "labels": List<dynamic>.from(labels.map((x) => x)),
    "properties": properties.toJson(),
    "elementId": elementId,
  };
}

class UserProfileProperties {
  UserProfileProperties({
    required this.occupation,
    required this.gender,
    required this.latitude,
    required this.lName,
    required this.twitterUsername,
    required this.about,
    required this.locationId,
    required this.updatedAt,
    required this.userId,
    required this.dob,
    required this.fName,
    required this.instagramUsername,
    required this.longitude,
  });

  String occupation;
  String gender;
  double latitude;
  String lName;
  String twitterUsername;
  String about;
  Identity locationId;
  String updatedAt;
  Identity userId;
  String dob;
  String fName;
  String instagramUsername;
  double longitude;

  factory UserProfileProperties.fromJson(Map<String, dynamic> json) => UserProfileProperties(
    occupation: json["occupation"],
    gender: json["gender"],
    latitude: json["latitude"]?.toDouble(),
    lName: json["l_name"],
    twitterUsername: json["twitter_username"],
    about: json["about"],
    locationId: Identity.fromJson(json["location_id"]),
    updatedAt: json["updated_at"],
    userId: Identity.fromJson(json["user_id"]),
    dob: json["dob"],
    fName: json["f_name"],
    instagramUsername: json["instagram_username"],
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "gender": gender,
    "latitude": latitude,
    "l_name": lName,
    "twitter_username": twitterUsername,
    "about": about,
    "location_id": locationId.toJson(),
    "updated_at": updatedAt,
    "user_id": userId.toJson(),
    "dob": dob,
    "f_name": fName,
    "instagram_username": instagramUsername,
    "longitude": longitude,
  };
}
