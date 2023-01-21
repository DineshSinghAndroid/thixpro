import 'package:Thixpro/screens/common/login.dart';
import 'package:Thixpro/screens/common/splash.dart';
import 'package:Thixpro/screens/messages/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  // if(currentUser != null) {
  //   // Logged In
  //   UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
  //   if(thisUserModel != null) {
  //     runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
  //   }
  //   else {
  //     runApp(const MyApp());
  //   }
  // }
  // else {
  //   // Not logged in
  //   runApp(const MyApp());
  // }
}

// Not Logged In
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var logger = Logger();
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

  MyAppLoggedIn({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
