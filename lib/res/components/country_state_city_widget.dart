import 'dart:convert';

import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/res/components/round_button.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:club_house/view_models/controllers/Profile/get_user_profile_controller.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';
import '../../view_models/controllers/Profile/addUserLocation_controller.dart';
import '../../view_models/controllers/Profile/update_profile_controller.dart';
import '../../view_models/controllers/clubs/clubs_controller.dart';
import '../../view_models/controllers/user_prefrence/user_prefrences_view_model.dart';
import '../dimensions.dart';

class CSCWidget extends StatefulWidget {

   CSCWidget({Key? key,}) : super(key: key);

  @override
  State<CSCWidget> createState() => _CSCWidgetState();
}

class _CSCWidgetState extends State<CSCWidget> {
  /// Variables to store country state city data in onChanged method.
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = "";

  List _dummyClubs = [];
  List _dummyClubs2 = [];
  List<int> addedIds = [];
  bool isClub1 = true;
  bool isClub2 = true;

  static int _len = 10;
  List<bool> isChecked = List.generate(_len, (index) => false);

  String location = 'Null, Press Button';
  String dummyClubName = '';
  String dummyClubId = '';

  String? locality = '';
  String country = '';
  String latitude = '';
  String longitude = '';
  //JoinClubsController controller = Get.put(JoinClubsController());
  AddLocationController addLocationController = Get.put(AddLocationController());

  UserPrefrences userPrefrences = UserPrefrences();
  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  GetUserProfileController getUserProfileController = Get.put(GetUserProfileController());
  // Fetch content from the json file
  // Future<void> readDummyJson1() async {
  //   final String response = await rootBundle.loadString('assets/dummyclub1.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _dummyClubs = data["data"];
  //     dummyClubName = _dummyClubs2[data]['properties']['club_name'].toString();
  //     print(dummyClubName =
  //         _dummyClubs2[data]['properties']['club_name'].toString());
  //     print(_dummyClubs[data]['identity']['low'].toString());
  //     print('printing dummy  clubs data ${data["data"]}');
  //   });
  // }

  @override
  void initState() {
   // readDummyJson1();
    super.initState();
  }
  // Widget dummyData1(BuildContext context) {
  //
  //   // Display the data loaded from sample.json
  //   print("Clube data length ${_dummyClubs.length.toString()}");
  //   String _getTitle() => "Checkbox Demo : Checked = ${isChecked.where((check) => check == true).length}, Unchecked = ${isChecked.where((check) => check == false).length}";
  //   String _title = "Checkbox Demo";
  //   return _dummyClubs.isNotEmpty
  //       ? Container(
  //     height: 200,
  //     child: ListView.builder(
  //       itemCount: _dummyClubs.length,
  //       itemBuilder: (context, index) {
  //
  //         return Column(
  //           children: [
  //             ListTile(
  //               title: Text(_dummyClubs[index]['properties']['club_name']),
  //               trailing: Checkbox(
  //                   onChanged: (checked) {
  //                     setState(
  //                           () {
  //                         isChecked[index] = checked!;
  //                         //_title = _getTitle();
  //                         int selectVal = _dummyClubs[index]['identity']['low'];
  //                         checked! ? addedIds.add(selectVal) : addedIds.remove(selectVal);
  //                         print("List Of IDs $addedIds");
  //                         print('Selected Value $selectVal');
  //                       },
  //                     );
  //                   },
  //                   value: isChecked[index]),
  //             ),
  //
  //           ],
  //         );
  //       },
  //     ),
  //   )
  //       : Container();
  // }

  // void itemChange(bool val, int index) {
  //   setState(() {
  //     _dummyClubs[index]['identity']['low'] = val;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Pick Location'),
      // ),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Adding CSC Picker Widget in app
                  CSCPicker(
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
                      setState(() {
                        ///store value in country variable
                       // country = value;
                        addLocationController.countryName.value = value.toString();
                        updateProfileController.countryName.value = value.toString();
                        print("OnCountryChange  ${addLocationController.countryName.value}");
                      });
                    },

                    onStateChanged: (value){
                      setState(() {
                        locality = value.toString();
                       addLocationController.stateName.value = value.toString();
                        print("OnStateChange  ${addLocationController.countryName.value}");
                      });
                    },

                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                       // locality = value.toString();
                        addLocationController.stateName.value = value.toString();
                        updateProfileController.city.value = value.toString();
                        print("OnCountryChange  ${addLocationController.countryName.value}");
                      });
                    },
                  ),

                  ///print newly selected country state and city in Text Widget
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         address = "$cityValue, $stateValue, $countryValue";
                  //       });
                  //     },
                  //     child: Text("Print Data")),
                  Text(address),
                  SizedBox(height: 20,),

                 // Text('Your City is: $locality'),
                  SizedBox(
                    height: 30,
                  ),
                  // Text('Please Join below Clubs in $stateValue city'),
                  // dummyData1(context),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                            () => RoundButton(
                          width: 100,
                          height: Dimensions.getHeight * 0.06,
                          loading: addLocationController.isLoading.value,
                          title: 'Submit',
                          onPress: () async {
                            if (addLocationController.countryName.value.isNotEmpty && addLocationController.stateName.value.isNotEmpty) {
                              //controller.clubIds = addedIds;
                              addLocationController.stateName.value;
                              //addLocationController.countryName.value = country.toString();
                              addLocationController.countryName.value;
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.setString('city', addLocationController.stateName.value);
                              addLocationController.latitude.value = "0.32343";
                              addLocationController.longitude.value = "0.5456456";
                              // addLocationController.latitude.value = latitude.toString();
                              // addLocationController.longitude.value = longitude.toString();
                              print("updateProfileController.stateName.value ${addLocationController.stateName.value}");
                              addLocationController.addLocationAPI();
                              updateProfileController.updateProfileApi("","");
                              // controller.joinClubsTesting();
                              Get.back();
                              //Get.toNamed(RoutesName.profile);
                              getUserProfileController.getUserProfileAPI();
                            } else if (addLocationController.countryName.value.isEmpty && addLocationController.stateName.value.isEmpty) {
                              Utils.snackBar('Error', "Couldn't get City Name",);
                              // controller.v_code.text = _otp.toString();

                            }else{
                              Utils.snackBar('Error', "Couldn't get City Name, please select all fields",);

                            }
                          },
                        ),
                      ),
                      RoundButton(
                        backgroundColor: AppColor.redColor,
                        width: 100,
                        height: Dimensions.getHeight * 0.06,
                        title: 'Cancel',
                        onPress: () async {
                          //Get.back();
                          Get.toNamed(RoutesName.profile);
                        },
                      ),

                  ],)


                  // Obx(() => controller.isLoading.value ? const SizedBox(height: 40, width: 40, child: CircularProgressIndicator(color: AppColor.primaryColor,),
                  // ):
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         if (locality.isNotEmpty && addedIds.isNotEmpty) {
                  //           setState(() {
                  //             controller.clubIds = addedIds;
                  //           });
                  //           controller.joinClubAPI();
                  //         } else if (addedIds.isEmpty) {
                  //           Utils.snackBar('Error', "Please select one textBox",);
                  //         } else if (locality.isEmpty) {
                  //           Utils.snackBar('Error', "Couldn't get City Name",);
                  //           // controller.v_code.text = _otp.toString();
                  //         }else{
                  //           Utils.snackBar('Error', "Unknown Error",);
                  //         }
                  //       },
                  //       style: ButtonStyle(
                  //           backgroundColor: const MaterialStatePropertyAll(
                  //               AppColor.primaryColor),
                  //           foregroundColor:
                  //           const MaterialStatePropertyAll(AppColor.whiteColor),
                  //           shape: MaterialStatePropertyAll(
                  //               RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(
                  //                       25)))),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(14),
                  //         child: Text('Submit'),
                  //       )),
                  // )
                  // ),




                ],
              ),
            )),
      ),
    );
  }
}
