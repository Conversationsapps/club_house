import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/response/instagram_constant.dart';
import '../../models/isocia_network_model/instagram_mode.dart';
import '../../view_models/controllers/Profile/get_user_profile_controller.dart';
import '../../view_models/controllers/Profile/update_profile_controller.dart';
import '../routes/routes_name.dart';
import 'build_appbar.dart';

class InstagramView extends StatefulWidget {
  const InstagramView({Key? key}) : super(key: key);

  @override
  State<InstagramView> createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  GetUserProfileController controller = Get.put(GetUserProfileController());
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      final webview = FlutterWebviewPlugin();
      final InstagramModel instagram = InstagramModel();

      buildRedirectToHome(webview, instagram, context);

      return WebviewScaffold(
        url: InstagramConstant.instance.url,
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
      );
    });
  }

  Future<void> buildRedirectToHome(FlutterWebviewPlugin webview, InstagramModel instagram, BuildContext context) async {
    webview.onUrlChanged.listen((String url) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      if (url.contains(InstagramConstant.redirectUri)) {
        instagram.getAuthorizationCode(url);
        await instagram.getTokenAndUserID().then((isDone) {
          if (isDone) {
            instagram.getUserProfile().then((isDone) async {
              await webview.close();
              print('${instagram.username} logged in!');
              preferences.setString('instagram', controller.instagram.value);
              print("Printing instagram Name from Get User Controller  ${controller.instagram.value}");
              controller.instagram.value = instagram.username.toString();
              updateProfileController.updateProfileApi('Instagram', instagram.username);
/*
              Get.toNamed(RoutesName., arguments: [
                // {"userId": value.data![0].identity!.low},
                {"userId": "1"},
                {"f_name": controller.fName.value},
                {"l_name": controller.lName.value},
                {"about": controller.about.value},
                {"dob": controller.dob.value},
                {"gender": controller.gender.value},
                {"occupation": controller.occupation.value},
              ]);
*/



              /*SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("instagramUsername", instagramName.toString());*/

              final String username = instagram.username.toString();
              var url = Uri.parse("http://instagram.com/_u/${controller.instagram.value}");
              WidgetsBinding.instance.addPostFrameCallback((_)async {
                await Get.to(_launchInBrowser(url));
              });

              // await Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => HomeView(
              //       token: instagram.authorizationCode.toString(),
              //       name: instagram.username.toString(),
              //     ),
              //   ),
              // );
            });
          }
        });
      }
    });
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

// class HomeView extends StatelessWidget {
//   final String token;
//   final String name;
//
//   const HomeView({Key? key, required this.token, required this.name}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Welcome $name",)),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Token $token"),
//         ],
//       ),
//     );
//   }
// }

