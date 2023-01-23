import 'package:Thixpro/screens/Pages/corporate.dart';
import 'package:Thixpro/screens/Pages/itr.dart';
import 'package:Thixpro/screens/Pages/tax.dart';
import 'package:Thixpro/screens/messages/model/UserModel.dart';
import 'package:Thixpro/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Pages/gst.dart';

class HomeScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  HomeScreen({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String title;
    int index;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chatting App"),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
              },
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/adv.jpg'),
                    )),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: DefaultTabController(
              length: 4,
              child: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (_, __) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.purple, width: 0.3)),
                              ),
                              child: const TabBar(
                                unselectedLabelColor: Colors.black,
                                unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(142, 142, 142, 1)),
                                labelColor: Colors.black,
                                labelPadding: EdgeInsets.zero,
                                labelStyle: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                // indicatorColor: AppTheme.primaryColor,
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 10 * .3),
                                ),
                                isScrollable: false,
                                tabs: [
                                  Tab(
                                    text: 'GST',
                                  ),
                                  Tab(
                                    text: 'CORPORATE',
                                  ),
                                  Tab(
                                    text: 'TAX',
                                  ),
                                  Tab(
                                    text: 'ITR',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    GstScreen(
                      userModel: widget.userModel,
                      firebaseUser: widget.firebaseUser,
                    ),
                    CorporateScreen(),
                    TaxScreen(),
                    ITRScreen(),
                  ],
                ),
              )),
        ));
  }
}
