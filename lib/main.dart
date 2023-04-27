import 'package:club_house/view_models/controllers/user_prefrence/image_profile_user_reference.dart';
import 'package:club_house/view_models/controllers/user_prefrence/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:club_house/res/getx_localizations/languages.dart';
import 'package:club_house/res/routes/routes.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreference.init();
  await ImageProfilePreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // Define the default brightness and colors.
        //brightness: Brightness.dark,
        primaryColor: const Color(0xff009688),

      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}