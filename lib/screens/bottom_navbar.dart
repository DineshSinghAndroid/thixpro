import 'package:Thixpro/screens/messages/chat.dart';
import 'package:Thixpro/screens/video_call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/app_theme.dart';
import '../widgets/sementions.dart';
import 'home.dart';

class BottomNavbars extends StatefulWidget {
  const BottomNavbars({Key? key}) : super(key: key);

  @override
  State<BottomNavbars> createState() => _BottomNavbarsState();
}

class _BottomNavbarsState extends State<BottomNavbars> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    VideoCall(),
    ChatScreen(),
    ChatScreen(),
  ];

  final PageStorageBucket list = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: list,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: AddSize.size80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: AddSize.size40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: AddSize.size22,
                            child: Icon(
                              Icons.home,
                              size: AddSize.size12,
                              color: currentTab == 0
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            )),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? AppTheme.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: AddSize.size30,
                    onPressed: () {
                      setState(() {
                        currentScreen = VideoCall();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: AddSize.size22,
                            child: Icon(
                              Icons.video_call,
                              size: AddSize.size12,
                              color: currentTab == 1
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            )),
                        Text(
                          'Video Call',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? AppTheme.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //right
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    // minWidth: AddSize.size30,
                    onPressed: () {
                      setState(() {
                        currentScreen = ChatScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: AddSize.size22,
                            child: Icon(
                              Icons.home,
                              size: AddSize.size12,
                              color: currentTab == 2
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            )),
                        // Icon(
                        //   Icons.add,
                        //   color: currentTab == 3 ? Colors.blue : Colors.grey,
                        // ),
                        Text(
                          'Chat',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? AppTheme.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: AddSize.size40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ChatScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: AddSize.size22,
                            child: Icon(
                              Icons.person,
                              size: AddSize.size12,
                              color: currentTab == 3
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            )),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? AppTheme.primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
