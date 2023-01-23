import 'package:Thixpro/screens/bottom_navbar.dart';
import 'package:Thixpro/screens/common/login.dart';
import 'package:Thixpro/screens/home.dart';
import 'package:Thixpro/screens/messages/chats/chatScreen.dart';
import 'package:Thixpro/screens/messages/model/FirebaseHelper.dart';
import 'package:Thixpro/screens/messages/model/UserModel.dart';
import 'package:Thixpro/screens/videocall/call.dart';
import 'package:Thixpro/screens/videocall/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Logged In
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    } else {
      runApp(MyApp());
    }
  } else {
    // Not logged in
    runApp(MyApp());
  }
}

// Not Logged In
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

// Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        userModel: userModel,
        firebaseUser: firebaseUser,
      ),
    );
  }
}
