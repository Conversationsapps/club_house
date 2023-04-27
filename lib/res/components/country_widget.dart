import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/res/components/round_button.dart';
import 'package:club_house/view_models/controllers/Profile/update_profile_controller.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_profile/update_profile_model.dart';
import '../../utils/utils.dart';
import '../../view_models/controllers/Profile/addUserLocation_controller.dart';
import '../../view_models/controllers/user_prefrence/user_preferences.dart';
import '../dimensions.dart';

class CountryWidget extends StatefulWidget {
  const CountryWidget({Key? key}) : super(key: key);

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  AddLocationController addLocationController = Get.put(AddLocationController());
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());

  bool isAdded = false;
  String userId = '';
  String stateName = '';
  String countryName = '';
  String latitude = '';
  String longitude = '';
  String cityName = '';


  @override
  void initState() {
    getUserCountryFromSharedPreference();
    super.initState();
  }

    Widget updateCountry(){
    return ///Adding CSC Picker Widget in app
      Obx(() => Center(
          child: CSCPicker(
            ///Enable disable state dropdown [OPTIONAL PARAMETER]
            showStates: true,

            /// Enable disable city drop down [OPTIONAL PARAMETER]
            showCities: true,

            ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
            flagState: CountryFlag.DISABLE,

            ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),

            ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            countryDropdownLabel: "*Country",
            stateDropdownLabel: "*State",
            cityDropdownLabel: "*City",

            ///Default Country
            //defaultCountry: DefaultCountry.India,

            ///Disable country dropdown (Note: use it with default country)
            //disableCountry: true,

            ///selected item style [OPTIONAL PARAMETER]
            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 10.0,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 10.0,

            ///triggers once country selected in dropdown
            onCountryChanged: (value) {
              setState((){
                ///store value in country variable
               // countryName = value;
               // user = user.copyWith(city: value);
              });
            },

            ///triggers once state selected in dropdown
            onStateChanged: (value) {
              setState(() {
                ///store value in state variable
                //stateName = value!;
                addLocationController.stateName.value = value.toString();

              });
            },
            ///triggers once city selected in dropdown
            onCityChanged: (value)async {
              setState((){
                ///store value in city variable
                cityName = value!;
                //addLocationController.stateName.value = value.toString();
                updateProfileController.stateName.value = value.toString();
                print("changing City to ${updateProfileController.stateName.value}");
              });
              print("XXXXXXXXXXXXXXXXXXXXXXXXX changing City to ${updateProfileController.stateName.value}");
              print("new city =========================== changing City to ${addLocationController.stateName.value}");
            },
          ),
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        children: [
          Container(
              child: Center(child: updateCountry())),

           // RoundButton(
           //    width: Dimensions.getWidth,
           //    height: Dimensions.getHeight * 0.06,
           //    loading: addLocationController.isLoading.value,
           //    title: 'update',
           //    onPress: () {
           //      if (stateName!.isNotEmpty) {
           //        setState(() {
           //          addLocationController.stateName.value = stateName.toString();
           //          addLocationController.countryName.value = countryName.toString();
           //          // addLocationController.latitude.value = latitude.toString();
           //          // addLocationController.longitude.value = longitude.toString();
           //        });
           //       addLocationController.addLocationAPI();
           //        print("VVVVVVVVVVVVVVBBBBBBBBBBBBBBBBBBBBBBBBBB ${addLocationController.stateName}");
           //      } else if (stateName.isEmpty) {
           //        Utils.snackBar('Error', "couldn't get City Name",);
           //
           //      }else{
           //        Utils.snackBar('Error', "Unknown Error",);
           //      }
           //    },
           //  ),
        ],
      )),
      // Center(
      //   child: Container(
      //     height: 100,
      //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      //     child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //
      //         TextField(
      //           readOnly: true,
      //           onTap: () {
      //             print(">>>>>>>>>><<<<<<<<<<<<<<<<<<<On TAB");
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryWidget()));
      //           },
      //           decoration: InputDecoration(
      //               suffixIcon: Icon(Icons.arrow_forward_ios),
      //               hintStyle: TextStyle( color: AppColor.blackColorLight),
      //               hintText: stateName.toString(),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(12))),
      //           //controller:  stateName.toString(),
      //         ),
      //     ],),
      //   ),
      // ),
    );
  }



  Future getUserCountryFromSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('userId').toString();
      stateName = pref.getString('user_city').toString();
      countryName = pref.getString('user_country').toString();
      latitude = pref.getString('user_latitude').toString();
      longitude = pref.getString('user_longitude').toString();
      isAdded = true;
      if(countryName == 'null') {
        countryName = 'India';
        isAdded = false;
      }
      print("userId in Country Widget $userId");
      print("stateName in Country Widget $stateName");
      print("countryName in Country Widget $countryName");
      print("latitude in Country Widget $latitude");
      print("longitude in Country Widget $longitude");
    });
  }
}
