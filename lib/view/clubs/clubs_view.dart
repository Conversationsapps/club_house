import 'dart:convert';
import 'package:club_house/utils/utils.dart';
import 'package:club_house/view_models/controllers/Profile/get_user_profile_controller.dart';
import 'package:club_house/view_models/controllers/Profile/update_profile_controller.dart';
import 'package:club_house/view_models/controllers/clubs/clubs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../res/components/round_button.dart';
import '../../res/dimensions.dart';
import '../../view_models/controllers/user_prefrence/user_prefrences_view_model.dart';

class Clubs extends StatefulWidget {
  const Clubs({Key? key}) : super(key: key);

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  List _dummyClubs = [];
  List<int> addedIds = [];
  bool isClub1 = true;
  bool isClub2 = true;

  static int _len = 10;
  List<bool> isChecked = List.generate(_len, (index) => false);
  String dummyClubName = '';
  String dummyClubId = '';

  String locality = '';

  JoinClubsController controller = Get.put(JoinClubsController());
  GetUserProfileController getUserProfileController = Get.put(GetUserProfileController());
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  UserPrefrences userPrefrences = UserPrefrences();


  // Fetch content from the json file
  Future<void> readDummyJson1() async {

    try{
      String response = await rootBundle.loadString('assets/dummyclub1.json');
      print(response);
      var data = await json.decode(response);

      setState(() {
        _dummyClubs = data["data"];
      });
    } catch(e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    readDummyJson1();
  }

  Widget dummyData1(BuildContext context) {
    return _dummyClubs.length != 0 ?
    Container(
            height: 200,
            child: ListView.builder(
              itemCount: _dummyClubs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title:
                          Text(_dummyClubs[index]['properties']['club_name']),
                      trailing: Checkbox(
                          onChanged: (checked) {
                            setState(
                              () {
                                isChecked[index] = checked!;
                                //_title = _getTitle();
                                int selectVal = _dummyClubs[index]['identity']['low'];
                                checked!  ? addedIds.add(selectVal) : addedIds.remove(selectVal);
                              },
                            );
                          },
                          value: isChecked[index]),
                    ),
                  ],
                );
              },
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), () {
      // Do something
    });
    return WillPopScope(
      onWillPop: () async {
        //Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          body: Center(
        child: Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please Join below Clubs in $locality city'),
              dummyData1(context),
              Obx(
                () => RoundButton(
                  width: Dimensions.getWidth,
                  height: Dimensions.getHeight * 0.06,
                  loading: controller.isLoading.value,
                  title: 'Submit',
                  onPress: () {
                    print("addedIds $addedIds");
                    if (addedIds.isNotEmpty) {
                      controller.isLoading.value = true;
                      controller.clubIds = addedIds;
                      print('controller.clubIds ${controller.clubIds}');
                      controller.joinClubsTesting(context);
                      //updateProfileController.updateProfileApi("");
                      getUserProfileController.getUserProfileAPI();
                    } else if (addedIds.isEmpty) {
                      Utils.snackBar('Error', "Please select one textBox",);
                    } else {
                      Utils.snackBar('Error', "Unknown Error",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
