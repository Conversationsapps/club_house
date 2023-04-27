import 'package:club_house/view/home/home_view.dart';
import 'package:club_house/view_models/controllers/Profile/addUserLocation_controller.dart';
import 'package:club_house/view_models/controllers/main/main_page_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:club_house/view_models/controllers/user_prefrence/user_prefrences_view_model.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/country_state_city_widget.dart';
import '../../view_models/controllers/Profile/get_user_profile_controller.dart';
import '../../view_models/controllers/Profile/update_profile_controller.dart';
import '../profile/profilePage.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainPgaeController = Get.put(MainPageController());
  UserPrefrences userPrefrences = UserPrefrences();
  UpdateProfileController controller = Get.put(UpdateProfileController());
  AddLocationController addLocationController = Get.put(AddLocationController());

  String location = 'Null, Press Button';
  String Address = '';
  String locality = '';
  String country = '';
  String latitude = '';
  String longitude = '';
  GetUserProfileController getUserProfileController = Get.put(GetUserProfileController());

  String? _currentAddress;
  Position? _currentPosition;

  bool _locationPermissionDenied = false;
  bool _isLoading = true;

  dynamic argumentData = Get.arguments;

  int activeIndex = 0;
  List<Widget> pages = [HomeView(), ProfilePage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      if(argumentData[0]['from'] == 'register') {
        print(argumentData[0]['from']);
        _getCurrentPosition();
      }

    }catch(e){

    }
    //checkPop();

    print('userPreferences SavedData ${userPrefrences.getUser()}');
    mainPgaeController.userListApi();
    print(mainPgaeController.rxRequestStatus.value);

    addLocationController.stateName.value;
    addLocationController.countryName.value;

  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
      print("Getting stateName Name before calling request permission ================   ${addLocationController.stateName.value}");
      permission = await Geolocator.requestPermission();
      print("Requesting Permission======================  ");
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever ) {
        print("Permission is denied Showing Dialog ======================  ");
        setState(() {
          _isLoading = false;
          _locationPermissionDenied = true;
          showMyDialog(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }else if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions Granted.')));
        return true;
      //}

    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        try {
          addLocationController.stateName.value = '${place.locality}';
          addLocationController.countryName.value = '${place.country}';
          addLocationController.latitude.value = '${position.latitude}';
          addLocationController.longitude.value = '${position.longitude}';

          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
          print("latitude name ${addLocationController.latitude.value}");
          print("longitude name ${addLocationController.longitude.value}");
          print("locality name ${addLocationController.stateName.value}");
          print("Country name ${addLocationController.countryName.value}");
          addLocationController.addLocationAPI();
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country},,'
              ' ${place.subAdministrativeArea}, ${place.postalCode}';
        } catch (e) {
          print(e);
        }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<String?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      setState(() {
        _locationPermissionDenied = true;
      });
      print('!hasPermission true');
      return 'hello';
    } else {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
        setState(() {
          _isLoading = false;
        });
        setState(() => _currentPosition = position);
        _getAddressFromLatLng(_currentPosition!);
      }).catchError((e) {
        debugPrint(e.toString());
      });
    }
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Please change Location'),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 500,
              child: CSCWidget(),
            ),
          ],
        );
      },
    );
  }

  Widget showSimpleDialog() {
    Future.delayed(
        Duration.zero, () => showMyDialog(context)); // import 'dart:async';
    return Container(
      child: Text(""),
    );
  }

  void showLocationChoice() {
    _isLoading
        ? const Center(child: CircularProgressIndicator())
        : addLocationController.stateName.value.isEmpty
            ? showSimpleDialog()
            : Center(
                child: Column(
                  children: [
                    Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                    Text('ADDRESS: ${_currentAddress ?? ""}'),
                    Text(
                        'longitude: ${addLocationController.longitude.value ?? ""}'),
                    Text(
                        'latitude: ${addLocationController.latitude.value ?? ""}'),
                    Text(
                        'countryName: ${addLocationController.countryName.value ?? ""}'),
                    Text(
                        'stateName: ${addLocationController.stateName.value ?? ""}'),
                    const Text('This is the location page.'),
                  ],
                ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('DashBoard'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          buttonBackgroundColor: AppColor.whiteColor,
          color: AppColor.primaryColor,
          onTap: (index) {
            setState(() {
              activeIndex = index;
            });
          },
          backgroundColor: AppColor.whiteColor,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: const Duration(milliseconds: 400),
          items: [
            Icon(Icons.home,
                color: activeIndex == 0 ? AppColor.greyColor : AppColor.whiteColor,
                size: 30),
            Icon(
              Icons.person, color: activeIndex == 1 ? AppColor.greyColor : AppColor.whiteColor,
              size: 30,
            ),
          ]),
      body: pages.elementAt(activeIndex),
    );
  }
}

