import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/bottom_navbar.dart';
import '../screens/home.dart';
import '../screens/common/login.dart';
import '../screens/messages/chat.dart';
import '../screens/profile.dart';
import '../screens/common/sign_up.dart';
import '../screens/common/splash.dart';
import '../screens/video_call.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var home = "/home";
  static var loginScreen = "/loginScreen";
  static var signupScreen = "/signupScreen";
  static var videoCall = "/videoCall";
  static var chatScreen = "/chatScreen";
  static var profileScreen = "/profileScreen";
  static var bottomNavbar = "/bottomNavbar";
  static var userMessageScreen = "/userMessageScreen";

  static var route = [
    GetPage(name: '/', page: () => const Splash()),
    GetPage(name: MyRouter.splashScreen, page: () => const Splash()),
    GetPage(name: MyRouter.home, page: () => HomeScreen()),
    // GetPage(name: MyRouter.loginScreen, page: () =>   Login(isSelectedPandit)),
    GetPage(name: MyRouter.signupScreen, page: () => const SignUpScreen()),
    GetPage(name: MyRouter.videoCall, page: () => const VideoCall()),
    GetPage(name: MyRouter.chatScreen, page: () => const ChatScreen()),
    GetPage(name: MyRouter.profileScreen, page: () => ProfilePage()),
    GetPage(name: MyRouter.bottomNavbar, page: () => const BottomNavbar()),
  ];
}
