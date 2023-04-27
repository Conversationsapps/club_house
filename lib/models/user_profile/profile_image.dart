
class ProfileImage{
  late final String imagePath;

  ProfileImage({required this.imagePath,});

  ProfileImage copy({
    String? imagePath,

  })=>
      ProfileImage(
        imagePath: imagePath ?? this.imagePath,
      );

  static ProfileImage fromJson(Map<String, dynamic> json) => ProfileImage(
      imagePath: json['imagePath'],
      );


  Map<String, dynamic> toJson()=>{
    'imagePath':imagePath,
  };
}