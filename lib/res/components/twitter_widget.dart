import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../view_models/controllers/Profile/get_user_profile_controller.dart';
import '../../view_models/controllers/Profile/update_profile_controller.dart';
//import 'package:twitter_login/twitter_login.dart';

class TwitterLoginWidget extends StatefulWidget {
  const TwitterLoginWidget({Key? key}) : super(key: key);

  @override
  State<TwitterLoginWidget> createState() => _TwitterLoginWidgetState();
}

class _TwitterLoginWidgetState extends State<TwitterLoginWidget> {
  GetUserProfileController controller = Get.put(GetUserProfileController());
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());

  final String apiKey = 'lVDnoFckT9svgJOebJFcq7soz';
  final String apiSecretKey = '3GcLyAzXMoytULOffpeVqzAuVSHw7tYWRB1V8gEc0K1cn6DgOx';
  final String redirectURI = 'https://twitter.com/home';
  String _title="";
  String username = "";
  String _message = 'Logged out.';
  late String newMessage;
  RxString twitterUserName = 'Add Twitter'.obs;


  static final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: 'lVDnoFckT9svgJOebJFcq7soz',
    consumerSecret: '3GcLyAzXMoytULOffpeVqzAuVSHw7tYWRB1V8gEc0K1cn6DgOx',
  );

  @override
  void initState() {
    _title.toString();
    loginTwitter(controller.twitterUserName.value);
    print('++++++++++++++++++Twitter User name $username');
    //login();
    super.initState();
  }


  void loginTwitter(var username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('username $username');
    if (username != 'Add Twitter') {
      try {
        await launchUrlString('twitter://', mode: LaunchMode.externalApplication);
        print('launchUrlString $launchUrlString');
        print('nativeurl https://www.twitter.com');
      } catch (e) {
        print(e);
        await launchUrlString('https://www.twitter.com', mode: LaunchMode.platformDefault);
        print('weburl https://www.twitter.com');
      }
    }
    else {
      final TwitterLoginResult result = await twitterLogin.authorize();

      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          newMessage = 'Logged in! username: ${result.session.username}';
          twitterUserName.value = result.session.username;
          //initialize get twitter controller
          controller.twitterUserName.value = result.session.username;

          print("Updating Update Profile with Twitter User Name in Twitter Widget.......................... ${controller.twitterUserName.value}");
          updateProfileController.updateProfileApi("twitter", result.session.username.toString());
          print("Calling updateProfileController for Twitter User Name in Twitter Widget.......................... ${updateProfileController.twitter_username.value}");
          print("Calling getUserProfileController for Twitter User Name in Twitter Widget.......................... ${{controller.twitterUserName.value}}");

          pref.setString('twitterName', twitterUserName.value);
          print("Printing Twitter Name from Get User Controller  ${twitterUserName.value}");
          try {
            await launchUrlString('twitter://', mode: LaunchMode.externalApplication);
            print('launchUrlString $launchUrlString');
            print('nativeurl https://www.twitter.com');
          } catch (e) {
            print(e);
            await launchUrlString('https://www.twitter.com', mode: LaunchMode.platformDefault);
            print('weburl https://www.twitter.com');

          }
          print('UserName ${result.session.username}');
          break;
        case TwitterLoginStatus.cancelledByUser:
          newMessage = 'Login cancelled by user.';
          print('Login cancelled by user.');
          Get.back();
          break;
        case TwitterLoginStatus.error:
          newMessage = 'Login error: ${result.errorMessage}';
          print('Login error: ${result.errorMessage}');
          Get.back();
          break;
      }
    }
  }

  Future<void> _launchInMobileOrBrowser(var weburl, var nativeurl)async{
    print("running _launchInMobileOrBrowser.............");
    try {
      await launchUrlString(nativeurl, mode: LaunchMode.externalApplication);
      print('launchUrlString $launchUrlString');
      print('nativeurl $nativeurl');
    } catch (e) {
      print(e);
      await launchUrlString(weburl, mode: LaunchMode.platformDefault);
      print('weburl $weburl');
    }
  }






/*

  /// Use Twitter API v1.1
  Future login() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: apiKey,
      /// Consumer API Secret keys
      apiSecretKey: apiSecretKey,
      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: redirectURI,
    );

    print("redirectURI $redirectURI");

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();
    print('authResult $authResult');

    //print('authResult ${authResult.errorMessage}');
    //print('authResult ${authResult.user}');
    //print('authResult ${authResult.authToken}');
    print('authResult ${authResult.status}');
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        Navigator.of(context).pop();
      // success
        print('====== Login success ======');
        print(authResult.user?.name.toString());
        print(authResult.status);
        print(authResult.authToken);
        print(authResult.authTokenSecret);
        break;
      case TwitterLoginStatus.cancelledByUser:
      // cancel
        print('====== Login cancel ======');
        print(authResult.user?.name.toString());
        break;
      case TwitterLoginStatus.error:
      case null:
      // error
        print('====== Login error ======');
        break;
    }
  }

  /// Use Twitter API v2.
  Future loginV2() async {
    String Message;
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: apiKey,

      /// Consumer API Secret keys
      apiSecretKey: apiSecretKey,

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: redirectURI,
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.loginV2();
    print('authResult $authResult');

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        Navigator.of(context).pop();
      // success
        print('====== Login success ======');
        _title = 'Logged in! username: ${authResult.user!.name.toString()}';
        print('Twitter User name ${authResult.user!.name.toString()}');
        username = authResult.user!.name.toString();
        break;
      case TwitterLoginStatus.cancelledByUser:
      // cancel
        print('====== Login cancel ======');
        print('Twitter User name ${authResult.user!.name.toString()}');
        username = authResult.user!.name.toString();
        break;
      case TwitterLoginStatus.error:
        _title = 'Login error: ${authResult.errorMessage}';
      break;
      case null:
      // error
        print('====== Login error ======');
        break;
    }

  }


*/
/*
  String _message = 'Logged out.';
  late String newMessage;

  void _login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        newMessage = 'Logged in! username: ${result.session.username}';
        username = newMessage;
        print('UserName ${result.session.username}');
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        print('Login cancelled by user.');
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
        print('Login error: ${result.errorMessage}');
        break;
    }

    setState(() {
      _message = newMessage;
    });
  }*/



  @override
  Widget build(BuildContext context) {
    return  Scaffold();

    //   Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: const Color(0xFF167F67),
    //     title: Text('Twitter login'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(username),
    //         SizedBox(height: 10,),
    //         Text(_title),
    //         _title.isEmpty
    //             ? ElevatedButton(
    //           child: Text('Log in'),
    //           onPressed:() {
    //             //_login();
    //             //print("XXXXXXXXXXXXXXXXXXXXXXXXXX $username");
    //           },
    //         )
    //             : SizedBox(
    //           width: 10.0,
    //         ),
    //         _title.isNotEmpty? ElevatedButton(
    //           child: Text('Log out'),
    //           onPressed: null, //_login(),
    //         ):SizedBox(width: 10.0,),
    //       ],
    //     ),
    //   ),
    // );
  }
}