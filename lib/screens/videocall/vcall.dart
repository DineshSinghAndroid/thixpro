import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
class VCallScreen extends StatefulWidget {
  final String? channelName;
  final ClientRoleType? role;

    VCallScreen({Key? key, this.channelName, this.role}) : super(key: key);

  @override
  State<VCallScreen> createState() => _VCallScreenState();
}

class _VCallScreenState extends State<VCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(

),
    );
  }
}
