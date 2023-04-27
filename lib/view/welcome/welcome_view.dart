
import 'package:club_house/res/dimensions.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../res/components/country_state_city_widget.dart';
import '../../res/components/round_button.dart';
import '../../view_models/controllers/Profile/addUserLocation_controller.dart';
import '../../view_models/controllers/Profile/update_profile_controller.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {


  // String location = 'Null, Press Button';
  // String Address = '';
  // String locality = '';
  // String country = '';
  // String latitude = '';
  // String longitude = '';
  // AddLocationController addLocationController = Get.put(AddLocationController());
  // UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  //
  // String? _currentAddress;
  // Position? _currentPosition;
  //
  // @override
  // void initState() {
  //   getCurrentUserCity();
  //   addLocationController.stateName.value;
  //   addLocationController.countryName.value;
  //   //_getCurrentPosition();
  //   //addLocationController.addLocationAPI();
  //   print("addLocationController.stateName.value ${addLocationController.stateName.value}");
  //   print("addLocationController.countryName.value ${addLocationController.countryName.value}");
  //   super.initState();
  // }
  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }
  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //       _currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //
  //       addLocationController.stateName.value = place.locality.toString();
  //       addLocationController.countryName.value = place.country.toString();
  //       addLocationController.latitude.value = position.latitude.toString();
  //       addLocationController.longitude.value = position.longitude.toString();
  //
  //       latitude = position.latitude.toString();
  //       longitude = position.longitude.toString();
  //       print("latitude name ${addLocationController.latitude.value}");
  //       print("longitude name ${addLocationController.longitude.value}");
  //       print("locality name ${addLocationController.stateName.value}");
  //       print("Country name ${addLocationController.countryName.value}");
  //
  //       addLocationController.addLocationAPI();
  //
  //       _currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country},,'
  //           ' ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }
  //
  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) {
  //     return;
  //   }else{
  //     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
  //       setState(() => _currentPosition = position);
  //       //addLocationController.addLocationAPI();
  //       //updateProfileController.updateProfileApi();
  //       _getAddressFromLatLng(_currentPosition!);
  //     }).catchError((e) {
  //       debugPrint(e.toString());
  //     });
  //
  //   }
  // }
  // Future<void> getCurrentUserCity() async {
  //   if(addLocationController.stateName.value.isNotEmpty && addLocationController.countryName.value.isNotEmpty){
  //     print("Builddddddddddddddddddddddddddddddddddd");
  //     print("addLocationController.stateName.value  ${addLocationController.stateName.value}");
  //     print("addLocationController.countryName.value  ${addLocationController.countryName.value}");
  //     return;
  //   }else{
  //     FutureBuilder(
  //         future: _getCurrentPosition(),
  //         //GHGFRRE
  //         builder: (context, snapshot) {
  //           print("SNAPSHOT DATA $snapshot");
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           if (snapshot.hasError) {
  //             print("Snapshot Error: ${snapshot.hasError}");
  //             return CSCWidget();
  //
  //           }
  //           if (snapshot.hasData) {
  //             print("Calling Add Location");
  //             addLocationController.stateName.value ;
  //             addLocationController.countryName.value;
  //             addLocationController.latitude.value;
  //             addLocationController.longitude.value;
  //             addLocationController.addLocationAPI();
  //             //updateProfileController.updateProfileApi();
  //             //getAddressFromLatLong();
  //             print("Printing information from  address $Address");
  //             return Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Text('Coordinates Points', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(location, style: TextStyle(color: Colors.black, fontSize: 16),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     'ADDRESS',
  //                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(Address.toString()),
  //
  //                   // ElevatedButton(onPressed: () async{
  //                   //   Position position = await _getGeoLocationPosition();
  //                   //   location ='Lat: ${position.latitude} , Long: ${position.longitude}';
  //                   //   getAddressFromLatLong(position);
  //                   // }, child: Text('Get Location')
  //                   // ),
  //                   // SizedBox(height: 30,),
  //                 ],
  //               ),
  //             );
  //           }
  //           return Center(child: Text("Address ${_currentAddress.toString()}"));
  //         });
  //   }
  // }
  //
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundButton(
              width: Dimensions.getWidth,
              height: Dimensions.getHeight * 0.06,
              title: 'login'.tr,
              onPress: () {
                Get.toNamed(RoutesName.loginScreen);
              },
            ),
            SizedBox(height: Dimensions.getHeight * 0.02,),
            RoundButton(
              width: Dimensions.getWidth,
              height: Dimensions.getHeight * 0.06,
              title: 'register'.tr,
              onPress: () {
                Get.toNamed(RoutesName.registerScreen);
              },
            ),


                // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                // Text('ADDRESS: ${_currentAddress ?? ""}'),
                // Text('longitude: ${addLocationController.longitude.value ?? ""}'),
                // Text('latitude: ${addLocationController.latitude.value ?? ""}'),
                // Text('countryName: ${addLocationController.countryName.value ?? ""}'),
                // Text('stateName: ${addLocationController.stateName.value ?? ""}'),
                const SizedBox(height: 32),
                // ElevatedButton(
                //   onPressed: _getCurrentPosition,
                //   child: const Text("Get Current Location"),
                // )


          ],
        ),
      ),
    );
  }
}

