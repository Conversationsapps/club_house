
import 'dart:io';
import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/res/components/country_state_city_widget.dart';
import 'package:club_house/view_models/controllers/Profile/addUserLocation_controller.dart';
import 'package:club_house/view_models/controllers/Profile/delete_user_profile_controller.dart';
import 'package:club_house/view_models/controllers/Profile/update_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_profile/profile_image.dart';
import '../../models/user_profile/update_profile_model.dart';
import '../../res/components/build_appbar.dart';
import '../../res/components/button_widget.dart';
import '../../res/components/profile_widgets.dart';
import '../../res/components/textFieldWidgets.dart';
import '../../view_models/controllers/Profile/get_user_profile_controller.dart';
import '../../view_models/controllers/user_prefrence/image_profile_user_reference.dart';
import '../../view_models/controllers/user_prefrence/user_preferences.dart';
import '../../view_models/controllers/user_prefrence/user_prefrences_view_model.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UpdateUserProfileModel user;
  late ProfileImage profileImg;
  UserPrefrences userPrefrences = UserPrefrences();
  UserPrefrences pref = UserPrefrences();
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  AddLocationController addLocationController = Get.put(AddLocationController());
  GetUserProfileController getUserProfileController = Get.put(GetUserProfileController());
  DeleteUserProfileController deleteUserProfileController = Get.put(DeleteUserProfileController());
  String stateName = "";

  List<UpdateUserProfileModel> userModel = <UpdateUserProfileModel>[];

  void getUserInfo() async {
     SharedPreferences sp = await SharedPreferences.getInstance();
     updateProfileController.f_nameController.value.text = sp.getString('firstName').toString();
     updateProfileController.l_nameController.value.text = sp.getString('lastName').toString();
     updateProfileController.occupationserviceController.value.text = sp.getString('occupation').toString();
     updateProfileController.genderController.value.text = sp.getString('gender').toString();
     updateProfileController.dobController.value.text = sp.getString('dob').toString();
     updateProfileController.aboutController.value.text = sp.getString('about').toString();
     updateProfileController.city.value = sp.getString('city').toString();
     updateProfileController.countryName.value = sp.getString('country').toString();
}

  @override
  void initState() {
    super.initState();
    //user = UserPreference.getUser();
    //userPrefrences.getUserProfileInfo();
    getUserInfo();
    //updateProfileController.get
    addLocationController.stateName.value;
    updateProfileController.stateName.value;
    //UpdateProfileController().fetchUsers();
    //getCity();
    // print('userPreferences SavedData ${userPrefrences.getUser()}');
    // print('userPreferences SavedProfileData ${userPrefrences.getUserProfile()}');
    //print('userPreferences SavedProfileInfo ${userPrefrences.getUserProfileInfo().toString()}');
    //print('.................Printing Model ${userInfo.data?.properties?.userId!.low}');
    print('++++++++++++________________________State Name ${addLocationController.stateName.value}');

    profileImg = ImageProfilePreference.getProfileImg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Obx( () => ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidgets(
                  imagePath: profileImg.imagePath,
                  onClicked: ()async{
                    final image = await ImagePicker().getImage(source: ImageSource.gallery);
                    if(image == null){
                      return;
                    }else{
                      final directory = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${directory.path}/$name');
                      final newImage = await File(image.path).copy(imageFile.path);
                      setState(() {
                        profileImg = profileImg.copy(imagePath: newImage.path);
                        print({"Get Image Location and Name: $imageFile"});
                        print({"Image Path: $name"});
                        print({"Image Location: $newImage"});
                        print({"Image Location: $newImage"});
                        print({"Image Location: $newImage"});
                      });
                    }
                    print("Hello Testing Call Back");

                  }, isEdit: true,),
                SizedBox(height: 25,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                      label: const Text('First Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller:  updateProfileController.f_nameController.value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                        label: const Text('Last Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller:  updateProfileController.l_nameController.value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                        label: const Text('Occupation'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller:  updateProfileController.occupationserviceController.value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                        label: const Text('Gender'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller:  updateProfileController.genderController.value,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                        label: const Text('DOB'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller: updateProfileController.dobController.value,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        label: Text('About Me'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    controller:  updateProfileController.aboutController.value,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      print(">>>>>>>>>><<<<<<<<<<<<<<<<<<<On TAB");
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryWidget()));
                       showDialog(context: context, builder: (BuildContext context){
                         return SimpleDialog(
                           title: const Text('Please change Location'),
                           children: [
                             Container(
                               margin: const EdgeInsets.symmetric(horizontal: 10),
                               height: 500,
                               child:CSCWidget(),
                             ),
                           ],
                         );
                       });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_forward_ios),
                      hintStyle: TextStyle( color: AppColor.blackColorLight),
                      //hintText: updateProfileController.city.value,//addLocationController.stateName.value,
                      hintText:  getUserProfileController.city.value,//addLocationController.stateName.value,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                    //controller:  stateName.toString(),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    gradeButton(),
                    deleteButton(),
                  ],
                ),
              ]),
      ));
  }

  Widget gradeButton() {
    return ButtonWidget(
      text: 'Update',
      onClicked: () {
        if(getUserProfileController.city.value == null || getUserProfileController.city.value.isEmpty ){
          Get.snackbar("Error", "Please Select your City");
        }else{
          //UserPreference.setUser(user);
          //addLocationController.addLocationAPI();
          updateProfileController.updateProfileApi("editProfile", "");
          getUserProfileController.getUserProfileAPI();
          ImageProfilePreference.setProfileImg(profileImg);
          Navigator.of(this.context).pop();
          getUserProfileController.getUserProfileAPI();
        }
        updateProfileController.updateProfileApi("editProfile","");
        getUserProfileController.getUserProfileAPI();
      },
      color: AppColor.primaryColor,

    );

  }
  Widget deleteButton() {
    return ButtonWidget(
      text: 'delete account',
      onClicked: () {
        //UserPreference.setUser(user);
       // controller.updateProfileApi();
        deleteUserProfileController.deleteUserProfileApi();
        ImageProfilePreference.setProfileImg(profileImg);
        //Navigator.of(this.context).pop();
      }, color: AppColor.redColor,
    );
  }
}
