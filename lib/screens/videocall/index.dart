import 'dart:math';

import 'package:Thixpro/screens/videocall/vcall.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRoleType? role = ClientRoleType.clientRoleBroadcaster;
  @override
  void dispose(){
    _channelController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
TextField(
  controller: _channelController,
  decoration: InputDecoration(
    errorText: _validateError ?'Channel name is madatory' :null,
    hintText: "Channel Name",
  ),

),
          RadioListTile(
            title: Text("Broadcaster"),
            onChanged: (ClientRoleType? value){
              setState(() {
                role = value;
              });
            },
            value: ClientRoleType.clientRoleBroadcaster,
            groupValue: role,
          ),
          RadioListTile(
            title: Text("Audiance"),
            onChanged: (ClientRoleType? value){
              setState(() {
                role = value;
              });
            },
            value: ClientRoleType.clientRoleAudience,
            groupValue: role,
          ),
          
          MaterialButton(onPressed: onJoin,child: Text("Join"),)
        ],
      ),
    );
  }

  Future<void> onJoin() async{
    setState(() {
      _channelController.text.isEmpty ? _validateError = true : _validateError =false;
    });
    if(_channelController.text.isNotEmpty){
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          VCallScreen(channelName: _channelController.text,role: role,)));
    }


  }
  Future<void> _handleCameraAndMic(Permission permission) async{
    final status = await permission.request();
    log(status.index.toDouble());
  }
}
