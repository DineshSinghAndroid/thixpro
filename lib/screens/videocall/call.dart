import 'package:Thixpro/screens/messages/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'contants.dart';
import 'login.dart';

class VCallScreen extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  VCallScreen({Key? key, required this.callID, required this.userModel, required this.firebaseUser}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: MyConst.appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: MyConst.appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userModel.uid.toString(),
      userName: userModel.fullname.toString(),
      callID: '2',
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
