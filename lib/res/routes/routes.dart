import 'package:club_house/res/components/country_state_city_widget.dart';
import 'package:club_house/res/components/instagram_widget.dart';
import 'package:club_house/view/clubs/clubs_view.dart';
import 'package:club_house/view/home/home_view.dart';
import 'package:club_house/view/otp/otp.dart';
import 'package:club_house/view/otp/verification.dart';
//import 'package:club_house/view/profile/profilePage.dart';
import 'package:club_house/view_models/controllers/main/main_page_controller.dart';
import 'package:club_house/view_models/controllers/otp/otp_controller.dart';
import 'package:get/get.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:club_house/view/login/login_view.dart';
import 'package:club_house/view/splash/splash_screen.dart';
import '../../view/main/main_page.dart';
import '../../view/profile/profilePage.dart';
import '../../view/profile/update_profile_view.dart';
import '../../view/register/register_view.dart';
import '../../view/welcome/welcome_view.dart';
import '../components/twitter_widget.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RoutesName.welcomeScreen,
          page: () => const WelcomeView(),
        ),
        GetPage(
          name: RoutesName.registerScreen,
          page: () => const RegisterView(),
        ),
        GetPage(
          name: RoutesName.loginScreen,
          page: () => const LoginView(),
        ),
        GetPage(
          name: RoutesName.otpView,
          page: () => const OTPScreen(),
        ),

      GetPage(
      name: RoutesName.instagramPage,
      page: () => const InstagramView(),
    ),
        GetPage(
          name: RoutesName.mainPage,
          page: () => const MainPage(),
        ),
    GetPage(
      // get Club Page
      name: RoutesName.clubs,
      page: () => const Clubs(),

    ),
    GetPage(
      name: RoutesName.profile,
      page: () => const ProfilePage(),

    ),
    GetPage(
      name: RoutesName.editProfilePage,
      page: () => const EditProfilePage(),

    ),
    GetPage(
      name: RoutesName.verificationView,
      page: () => const VerificationScreen(),

    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => const HomeView(),
    ),
    /*GetPage(
      name: RoutesName.cscWidget,
      page: () => CSCWidget(userId: "262",),
    ),*/
    GetPage(
      name: RoutesName.twitterPage,
      page: () => TwitterLoginWidget(),
    ),
  ];
}
