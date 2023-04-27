class UpdateUserProfileModel {
  late int userId;
  late String about;
  late String dob;
  late String fName;
  late String lName;
  late String gender;
  late String city;
  late String occupationservice;
  String? instagramUsername;

  UpdateUserProfileModel(
      {required this.userId,
        required this.about,
        required this.dob,
        required this.fName,
        required this.lName,
        required this.gender,
        required this.city,
        required this.occupationservice,
        this.instagramUsername});


  UpdateUserProfileModel copyWith({
    int? userId,
    String? about,
    String? dob,
    String? fName,
    String? lName,
    String? gender,
    String? city,
    String? occupationservice,
    String? instagramUsername,
  }) =>
      UpdateUserProfileModel(
        userId: userId ?? this.userId,
        about: about ?? this.about,
        dob: dob ?? this.dob,
        fName: fName ?? this.fName,
        lName: lName ?? this.lName,
        gender: gender ?? this.gender,
        city: city ?? this.city,
        occupationservice: occupationservice ?? this.occupationservice,
        instagramUsername: instagramUsername ?? this.instagramUsername,
      );



  UpdateUserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    about = json['about'];
    dob = json['dob'];
    fName = json['f_name'];
    lName = json['l_name'];
    gender = json['gender'];
    city = json['city'];
    occupationservice = json['occupationservice'];
    instagramUsername = json['instagram_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['about'] = this.about;
    data['dob'] = this.dob;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['occupationservice'] = this.occupationservice;
    data['instagram_username'] = this.instagramUsername;
    return data;
  }
}
