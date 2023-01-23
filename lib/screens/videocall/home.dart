import 'package:Thixpro/screens/videocall/login.dart';
import 'package:flutter/material.dart';

import 'call.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VCallScreen(
                      callID: '2',
                    )));
          },
          child: Text("Join Call"),
        ),
      ),
    );
  }
}
