// To parse this JSON data, do
//
//     final joinClubModel = joinClubModelFromJson(jsonString);

import 'dart:convert';

JoinClubModel joinClubModelFromJson(String str) => JoinClubModel.fromJson(json.decode(str));

String joinClubModelToJson(JoinClubModel data) => json.encode(data.toJson());

class JoinClubModel {
  JoinClubModel({
    required this.clubIds,
    required this.userId,
  });

  List<int> clubIds;
  int userId;

  factory JoinClubModel.fromJson(Map<String, dynamic> json) => JoinClubModel(
    clubIds: List<int>.from(json["club_ids"].map((x) => x)),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "club_ids": List<dynamic>.from(clubIds.map((x) => x)),
    "user_id": userId,
  };
}
