import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {

    'en_US' : {
      'email_hint' : 'Enter email',
      'email' : 'Email',
      'internet_exception' : "We're unable to show result.\nPlease check your data\nconnection.",
      'general_exception' : "We're unable to process your request.\nPlease try again.",
      'login' : 'Login',
      'register' : 'Register',
      'password_hint' : 'Enter Password',
      'password' : 'Password',
      'welcome_back' : 'Welcome\nBack',
      'welcome' : 'Welcome',
      'resendCode' : 'Resend Code',
      'OTPVerification' : 'OTP Verification',
      'loginSuccessfully' : 'Login Successfully',
      'codeVerify' : 'verification code is verified.',
      'registerSuccessfully' : 'Register Successfully',
      'responseMessage' : 'Please verify your account using verification code sent to your email address.',
      'registerResponseMessage' : 'Please verify you email using verification code sent to your email address.',
      'clubJoined':'club joined',
      'clubJoiningProblem':'club joining problem',
      'userProfileIsUpdated':'user profile is updated.'


    },
    'hi' : {
      'email_hint' : 'ईमेल दर्ज करें',
      'internet_exception' : "हम परिणाम दिखाने में असमर्थ हैं।\nकृपया अपना डेटा\nकनेक्शन जांचें",
    }
  };
}