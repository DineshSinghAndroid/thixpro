import 'package:Thixpro/screens/Pages/corporate.dart';
import 'package:Thixpro/screens/Pages/itr.dart';
import 'package:Thixpro/screens/Pages/tax.dart';
import 'package:Thixpro/screens/messages/model/UserModel.dart';
import 'package:Thixpro/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Pages/gst.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, UserModel? userModel, User? firebaseUser})
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
          title: Text("Chatting App"),
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                decoration: BoxDecoration(
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.purple, width: 0.3)),
                              ),
                              child: TabBar(
                                unselectedLabelColor: Colors.black,
                                unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color:
                                        const Color.fromRGBO(142, 142, 142, 1)),
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
                                tabs: const [
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    GstScreen(),
                    CorporateScreen(),
                    TaxScreen(),
                    ITRScreen(),
                  ],
                ),
              )),
        ));
  }
}
