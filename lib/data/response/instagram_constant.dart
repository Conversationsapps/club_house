

class InstagramConstant{
  static InstagramConstant? _instance;

  static InstagramConstant get instance{
    _instance ??= InstagramConstant._init();
    return _instance!;
  }

  InstagramConstant._init();

  static const String clientID = '856242892144794';
  static const String appSecret = '5f7ec1a48759a670cd0e1791893b4c7c';
  static const String redirectUri = 'https://etteinnovations.com/';
  static const String scope = 'user_profile';
  static const String responseType = 'code';
  final String url ='https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=user_profile,user_media&response_type=$responseType';
}