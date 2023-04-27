
import 'package:club_house/view/profile/update_profile_view.dart';
import 'package:club_house/view_models/controllers/Profile/get_user_profile_controller.dart';
import 'package:club_house/view_models/controllers/Profile/update_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/button_widget.dart';
import '../../res/components/numbers_widget.dart';
import '../../res/components/profile_widgets.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controllers/user_prefrence/image_profile_user_reference.dart';
import '../../view_models/controllers/user_prefrence/user_preferences.dart';
import '../../view_models/controllers/user_prefrence/user_prefrences_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetUserProfileController controller = Get.put(GetUserProfileController());
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  UserPrefrences userPrefrences = UserPrefrences();
  dynamic argumentData = Get.arguments;
  String newName = "";
  bool isAdded = false;
  bool isTwitterAdded = false;
  var user = '';
  var  twitterLoginName2;
  late String newMessage;

  static final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: 'lVDnoFckT9svgJOebJFcq7soz',
    consumerSecret: '3GcLyAzXMoytULOffpeVqzAuVSHw7tYWRB1V8gEc0K1cn6DgOx',
  );


  @override
  void initState(){
    controller.getUserProfileAPI();
    if (kDebugMode) {
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final profileImg = ImageProfilePreference.getProfileImg();
    final user = UserPreference.getUser();

    return Scaffold(
      //appBar: buildAppBar(context),
      body: Obx(() => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidgets(
            onClicked: ()async{
              await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const EditProfilePage()));
              setState(() {});},
              isEdit: false,
              imagePath: profileImg.imagePath,
            ),
            SizedBox(height: 10,),
            buildName(),
            buildSocialMedia(),
            buildStatus(),
            buildUpgradeButton(),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            const NumbersWidget(),
            SizedBox(height: 10,),
            buildFavoriteClubs(),
            SizedBox(height: 20,),
            //buildFavoriteRooms(),
            SizedBox(height: 16,),
            buildAbout(),
            Container(
              width: 200,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                  onPressed: () {
                        userPrefrences.removeUser().then((value) {
                          //Get.toNamed(RoutesName.loginScreen);
                          Get.offAllNamed(RoutesName.welcomeScreen);
                          userPrefrences.removeUser();
                        });
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Logout', style: TextStyle(color: AppColor.whiteColor,),),
                      SizedBox(width: 20,),
                      Icon(Icons.logout, color: AppColor.whiteColor,),
                    ],
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildStatus(){
    return Container(
      width: 10,
      decoration: BoxDecoration(
        shape:BoxShape.rectangle,

      ),
      padding: EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Unverified", style: TextStyle(fontSize: 20, color: Colors.grey.shade700),),
          Icon(Icons.check_circle, color: Colors.yellow.shade700,)
        ],
      ),
    );
  }

  Widget buildName(){
    return Obx( () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(controller.fName.value.toString(),style: TextStyle(fontSize: 20, color: Colors.black )),
            SizedBox(width: 15,),
            Text(controller.lName.value,style: TextStyle(fontSize: 20, color: Colors.black54)),
          ],),
          SizedBox(height: 4,),
          Text(controller.gender.value , style: TextStyle(fontSize: 20, color: Colors.grey)),
          SizedBox(height: 4,),
          Text(controller.occupation.value, style: TextStyle(fontSize: 16, color: Colors.grey),),
          SizedBox(height: 4,),
          Text(controller.dob.value, style: TextStyle(fontSize: 16, color: Colors.grey),),
          SizedBox(height: 4,),
          Text(controller.city.value, style: TextStyle(fontSize: 16, color: Colors.grey),),
          SizedBox(height: 4,),
          Text(controller.country.value, style: TextStyle(fontSize: 16, color: Colors.grey),),
      ],),
    );
  }
  Widget buildUpgradeButton(){
    return ButtonWidget(
      color: AppColor.primaryColor,
        text: "Upgrade to Pro",
        onClicked: (){
        });
  }
  Widget buildSocialMedia(){
    final socialAdd = UserPreference.getUser();
    //var user
    // getInsta();
    // getTwitter();
    var weburl = "http://instagram.com/_u/${controller.instagram.value}";
    var nativeurl = "instagram://user?username=${controller.instagram.value}";
   // var url = Uri.parse("http://instagram.com/_u/$instagramName");
    return  Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.blue,)),
            TextButton(onPressed: ()async{
              controller.login(controller.twitterUserName.value);
            }, child: Text(controller.twitterUserName.value, style: const TextStyle(fontSize: 16, color: AppColor.greyColorLight),))
           ],
        ),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.red,)),

                TextButton(onPressed: (){
                  isAdded ? WidgetsBinding.instance.addPostFrameCallback((_)async {
                  await Get.to(_launchInMobileOrBrowser(weburl,nativeurl));
                  }) : Get.toNamed(RoutesName.instagramPage);
                }, child: Obx(() => Text(controller.instagram.value ,style: const TextStyle(fontSize: 16, color: AppColor.primaryColor),))),
              ],
            )
          ],
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
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
  Widget buildAbout(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About Me",style: TextStyle(fontSize: 25, color: Colors.grey),),
            SizedBox(height: 16,),
            Text(controller.about.value,  style: TextStyle(fontSize: 18, color: Colors.grey,),)

          ],
        ),
      ),
    );

  }
  Widget buildFavoriteClubs(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("clubs", style: TextStyle(fontSize: 18, color: AppColor.primaryColor),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextButton.icon(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.greyColor)),
                  onPressed: (){}, icon: Icon(Icons.headphones, color: AppColor.secondaryColor,), label: Text(controller.club1.value,
                style: TextStyle(color:AppColor.whiteColor),)),
              SizedBox(width: 20,),
              controller.club2.value  == "" ? Container():Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.greyColor)),
                    onPressed: (){}, icon: Icon(Icons.fitness_center, color: AppColor.secondaryColor,), label: Text(controller.club2.value,
                    style: TextStyle(color:AppColor.whiteColor))),
              ),

                TextButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.greyColor)),
                    onPressed: (){
                      Get.toNamed(RoutesName.clubs, arguments: [
                          // {"userId": value.data![0].identity!.low},
                              {"userId": "1"},
                          {"email": "gng"},
                          {"from": 'profile'},
                          ]);
                    }, icon: Icon(Icons.add, color: AppColor.whiteColor,), label: Text("Add More Clubs",
                    style: TextStyle(color:AppColor.whiteColor))),

            ],),
          ),
        ]),
    );

  }
  void loginTwitter(var username) async {
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

          //initialize get twitter controller
          controller.twitterUserName.value = result.session.username;
          updateProfileController.updateProfileApi("", "");

          Get.toNamed(RoutesName.profile, arguments: [
            // {"userId": value.data![0].identity!.low},
            {"userId": "1"},
            {"f_name": controller.fName.value},
            {"l_name": controller.lName.value},
            {"about": controller.about.value},
            {"dob": controller.dob.value},
            {"gender": controller.gender.value},
            {"occupation": controller.occupation.value},
          ]);

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
}
