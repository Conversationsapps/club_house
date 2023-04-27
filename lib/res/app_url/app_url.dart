
class AppUrl {

  static const String baseUrl = 'https://social-backend-377617.uw.r.appspot.com';


  static const String loginUrl = '$baseUrl/conversation/user/login';
  static const String registerUrl = '$baseUrl/conversation/user/registration';
  static const String otpUrl = '$baseUrl/conversation/user/login_otp';
  static const String verification = '$baseUrl/conversation/user/activation';
  static const String resendOtpUrl = '$baseUrl/conversation/user/login_otp';
  static const String updateProfileUrl = '$baseUrl/conversation/user/update_profile';
  static const String addUserLocationUrl = '$baseUrl/conversation/user/add_user_location';
  static const String getUserProfileUrl = '$baseUrl/conversation/user/get_user_profile/user_id=';
  static const String deleteUserProfileUrl = '$baseUrl/conversation/user/delete_account';
  static const String joinClubsUrl = '$baseUrl/club/join_clubs';
  static const String userListUrl = 'https://webhook.site/1f2cdcb2-2ec4-4c8a-a4b1-08a263b5b428';
  static const String dummyClubs = 'https://webhook.site/1f2cdcb2-2ec4-4c8a-a4b1-08a263b5b428';
}